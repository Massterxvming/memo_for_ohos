import 'package:memo_for_ohos/common/common.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingInfoLogic extends GetxController {
  static SettingInfoLogic? get logic => DependencyTool.capture(Get.find);

  String appName = '';
  String version = '';
  String buildNumber = '';
  String packageName = '';

  @override
  void onInit() {
    super.onInit();
    _loadPackageInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appName = info.appName;
      version = info.version;
      buildNumber = info.buildNumber;
      packageName = info.packageName;
      update();
    } catch (_) {}
  }
}

class SettingInfoPage extends StatelessWidget {
  const SettingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingInfoLogic());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '设置',
        ),
        leading: const BackButton(),
      ),
      body: GetBuilder<SettingInfoLogic>(builder: (logic) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              title: const Text('关于'),
              subtitle: Text(
                  '${logic.appName}  v${logic.version}'),
              leading: const Icon(Icons.info_outline),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text('主题设置'),
              subtitle: const Text('切换浅色/深色模式'),
              leading: const Icon(Icons.color_lens_outlined),
              trailing: GetBuilder<ThemeStore>(
                builder: (store) {
                  final bool isDark = store.themeMode == ThemeMode.dark;
                  return Switch(
                    value: isDark,
                    onChanged: (value) {
                      store.setThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light);
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
