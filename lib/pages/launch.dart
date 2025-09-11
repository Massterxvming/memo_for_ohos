import 'package:memo_for_ohos/pages/setting/setting_info.dart';
import 'package:memo_for_ohos/tools/time_util.dart';

import '../common/common.dart';
import 'add_notes/add_notes.dart';
import '../storage_service/stoage_service.dart';

class LaunchLogic extends GetxController {
  static LaunchLogic? get logic => DependencyTool.capture(Get.find);

  List<NoteListModel> noteList = [];

  @override
  void onInit() {
    super.onInit();
    // _loadFromCache();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _loadFromCache() async {
    final List<NoteListModel> list =
        await StorageService.instance.readNoteList();
    noteList = list;
    update();
  }

  Future<void> reloadFromCache() => _loadFromCache();
}

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LaunchLogic());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.book, color: Colors.blueAccent),
            const SizedBox(width: 8),
            const Text(
              '光阴手账',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // 跳转到设置页面
                Get.to(const SettingInfoPage());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '设置',
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<LaunchLogic>(builder: (logic) {
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          reverse: true,
          shrinkWrap: true,
          itemCount: logic.noteList.length,
          itemBuilder: (context, groupIndex) {
            final group = logic.noteList[groupIndex];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 2,
              child: ExpansionTile(
                leading: const Icon(Icons.timeline, color: Colors.green),
                title: Text(
                  TimeUtil.formatTimeStamp(group.publishDate),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: List.generate(group.itemList.length, (noteIndex) {
                  final item = group.itemList[noteIndex];
                  return ListTile(
                    leading: const Icon(
                      Icons.note,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // trailing: Chip(
                    //   label: Text(
                    //     '步骤${noteIndex + 1}',
                    //     style: const TextStyle(fontSize: 10),
                    //   ),
                    //   backgroundColor: Colors.yellow.shade50,
                    // ),
                    onTap: () async {
                      final result = await Get.to(
                        const AddNotePage(),
                        arguments: item.toJson(),
                      );
                      if (result == true) {
                        await LaunchLogic.logic?.reloadFromCache();
                      }
                    },
                    onLongPress: () async {
                      _showDeleteBottomSheetForItem(context, item.id);
                    },
                  );
                }),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        onPressed: () async {
          final result = await Get.to(const AddNotePage());
          if (result == true) {
            await LaunchLogic.logic?.reloadFromCache();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showDeleteBottomSheetForGroup(BuildContext context, int publishDate) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.redAccent),
              title: const Text('删除分组及其所有笔记'),
              onTap: () async {
                await StorageService.instance
                    .deleteNoteListByPublishDate(publishDate);
                Navigator.of(ctx).pop();
                await LaunchLogic.logic?.reloadFromCache();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('取消'),
              onTap: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    },
  );
}

void _showDeleteBottomSheetForItem(BuildContext context, String id) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.redAccent),
              title: const Text('删除该笔记'),
              onTap: () async {
                await StorageService.instance.deleteNoteItemById(id);
                Navigator.of(ctx).pop();
                await LaunchLogic.logic?.reloadFromCache();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('取消'),
              onTap: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    },
  );
}
