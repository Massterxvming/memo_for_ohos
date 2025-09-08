import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DependencyTool{
  static Logic? capture<Logic extends GetxController>(
      Function logic, {
        String? tag,
      }) {
    try {
      return logic<Logic>(tag: tag);
    } catch (_) {
      return null;
    }
  }
}