import 'package:memo_for_ohos/pages/setting/setting_info.dart';

import '../common/common.dart';
import 'add_notes/add_notes.dart';

class LaunchLogic extends GetxController {
  static LaunchLogic? get logic => DependencyTool.capture(Get.find);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // TODO: implement onReady
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.book, color: Colors.blueAccent),
            const SizedBox(width: 8),
            const Text(
              '记事本',
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
      body: ListView.builder(
        itemCount: 5, // 外层流水线分组
        itemBuilder: (context, groupIndex) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 2,
            child: ExpansionTile(
              leading: const Icon(Icons.timeline, color: Colors.green),
              title: Text(
                '流水线分组 $groupIndex',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: List.generate(3, (noteIndex) {
                return ListTile(
                  leading: const Icon(Icons.note, color: Colors.blueAccent),
                  title: Text('笔记标题 $groupIndex-$noteIndex'),
                  subtitle: const Text('这里是笔记内容摘要...'),
                  trailing: Chip(
                    label: Text('步骤${noteIndex + 1}',
                        style: const TextStyle(fontSize: 10)),
                    backgroundColor: Colors.yellow.shade50,
                  ),
                  onTap: () {
                    // 跳转到详情页
                  },
                );
              }),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade50,
        foregroundColor: Colors.amber,
        onPressed: () {
          Get.to(const AddNotePage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
