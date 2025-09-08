import '../common/common.dart';
import '../storage_service/stoage_service.dart';

class ThemeStore extends GetxController {
  static ThemeStore? get logic => DependencyTool.capture(Get.find);

  static const String _themeKey =
      'app_theme_mode'; // 'light' | 'dark' | 'system'

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  Future<void> init() async {
    final String mode =
        StorageService.instance.readString(_themeKey, defaultValue: 'light');
    _themeMode = _parse(mode);
    update();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await StorageService.instance.writeString(_themeKey, _stringify(mode));
    update();
  }

  String _stringify(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
      default:
        return 'light';
    }
  }

  ThemeMode _parse(String s) {
    switch (s) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }
}
