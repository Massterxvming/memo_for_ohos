import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../common/common.dart';

class StorageService {
  //实现一个单例
  StorageService._internal();

  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  static StorageService get instance => _instance;

  final _box = GetStorage();

  String noteListKey = 'note_list_key';

  Future<void> init() async {
    await GetStorage.init();
    _noteList = await readNoteList();
  }

  List<NoteListModel> _noteList = [];

  set noteList(List<NoteListModel> value) {
    _noteList = value;
    writeNoteList(value);
  }

  List<NoteListModel> get noteList => _noteList;

  Future<void> writeNoteList(List<NoteListModel> noteList) async {
    final List<String> encoded =
        noteList.map((e) => jsonEncode(e.toJson())).toList();
    await _box.write(noteListKey, encoded);
  }

  Future<List<NoteListModel>> readNoteList() async {
    final dynamic raw = _box.read(noteListKey);
    if (raw == null) return [];
    if (raw is List) {
      final List<String> stringList = raw.map((e) => e.toString()).toList();
      return stringList
          .map((s) {
            try {
              final Map<String, dynamic> map = json.decode(s);
              return NoteListModel.fromJson(map);
            } catch (_) {
              return null;
            }
          })
          .whereType<NoteListModel>()
          .toList();
    }
    return [];
  }

  Future<bool> replaceNoteItemById(NoteItem updatedItem) async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    int startOfDayMillis = startOfDay.millisecondsSinceEpoch;
    for (int i = 0; i < _noteList.length; i++) {
      final NoteListModel model = _noteList[i];
      final int itemIndex =
          model.itemList.indexWhere((e) => e.id == updatedItem.id);
      if (itemIndex != -1) {
        final List<NoteItem> newItems = List<NoteItem>.from(model.itemList);
        newItems[itemIndex] = updatedItem;
        _noteList[i] = NoteListModel(
          publishDate: model.publishDate,
          itemList: newItems,
        );
        await writeNoteList(_noteList);
        return true;
      } else if (model.publishDate == startOfDayMillis) {
        model.itemList.add(updatedItem);

        await writeNoteList(_noteList);
        return true;
      }
    }

    final NoteListModel newModel = NoteListModel(
      publishDate: startOfDayMillis,
      itemList: [updatedItem],
    );
    _noteList = List<NoteListModel>.from(_noteList)..add(newModel);
    await writeNoteList(_noteList);
    return true;
  }

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  dynamic read(String key) {
    return _box.read(key);
  }

  // String helpers with defaults
  Future<void> writeString(String key, String value) async {
    await _box.write(key, value);
  }

  Future<void> writeStringList(String key, List<String> value) async {
    await _box.write(key, value);
  }

  String readString(String key, {String defaultValue = ''}) {
    final dynamic v = _box.read(key);
    if (v is String) return v;
    return defaultValue;
  }

  List<String> readStringList(String key,
      {List<String> defaultValue = const []}) {
    final dynamic v = _box.read(key);
    if (v is List) {
      return v.map((e) => e.toString()).toList();
    }
    return defaultValue;
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }

  Future<void> deleteNoteListByPublishDate(int publishDate) async {
    _noteList = List<NoteListModel>.from(_noteList)
      ..removeWhere((e) => e.publishDate == publishDate);
    await writeNoteList(_noteList);
  }

  Future<bool> deleteNoteItemById(String id) async {
    for (int i = 0; i < _noteList.length; i++) {
      final NoteListModel model = _noteList[i];
      final List<NoteItem> items = List<NoteItem>.from(model.itemList);
      final int idx = items.indexWhere((e) => e.id == id);
      if (idx != -1) {
        items.removeAt(idx);
        if (items.isEmpty) {
          _noteList.removeAt(i);
        } else {
          _noteList[i] = NoteListModel(
            publishDate: model.publishDate,
            itemList: items,
          );
        }
        await writeNoteList(_noteList);
        return true;
      }
    }
    return false;
  }
}
