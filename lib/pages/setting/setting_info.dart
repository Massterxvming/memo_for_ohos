
import 'package:memo_for_ohos/common/common.dart';

class SettingInfoLogic extends GetxController {
  static SettingInfoLogic? get logic => DependencyTool.capture(Get.find);

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

class SettingInfoPage extends StatelessWidget {
  const SettingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingInfoLogic logic = Get.put(SettingInfoLogic());
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置',),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('关于'),
            subtitle: const Text('查看应用信息'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              // TODO: 跳转到关于页面
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('主题设置'),
            subtitle: const Text('切换浅色/深色模式'),
            leading: const Icon(Icons.color_lens_outlined),
            trailing: Switch(
              value: false, // TODO: 替换为实际主题状态
              onChanged: (value) {
                // TODO: 切换主题
              },
            ),
          ),
        ],
      ),
    );
  }
}
