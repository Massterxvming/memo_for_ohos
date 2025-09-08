import 'dart:math';

class NoteItem {
  final String id;
  final String title;
  final String content;

  NoteItem({
    String? id,
    required this.title,
    required this.content,
  }) : id = id ?? _generateUuid();

  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}

String _generateUuid() {
  final int micros = DateTime.now().microsecondsSinceEpoch;
  final int rand = Random().nextInt(0x7fffffff);
  return '${micros.toRadixString(16)}-${rand.toRadixString(16)}';
}

class NoteListModel {
  final int publishDate;
  final List<NoteItem> itemList;

  NoteListModel({
    required this.publishDate,
    required this.itemList,
  });

  factory NoteListModel.fromJson(Map<String, dynamic> json) {
    return NoteListModel(
      publishDate: json['publishDate'],
      itemList: (json['itemList'] as List)
          .map((item) => NoteItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'publishDate': publishDate,
      'itemList': itemList.map((item) => item.toJson()).toList(),
    };
  }
}
