
import 'package:get/get.dart';

import 'pages/add_notes/add_notes.dart';
import 'pages/pgaes.dart';


class Routes {
  static String launch = "/launch";
  static String guide = "/guide";
  static String menu = "/menu";
  static String unknown = "/unknown";

  static List<GetPage> get getPages {
    return [
      GetPage(
        name: launch,
        page: () => const LaunchPage(),
        transition: Transition.noTransition,
      ),
      ...AddNotesRoutes.getPages,
      // GetPage(
      //   name: guide,
      //   page: () => const GuidePage(),
      //   transition: Transition.noTransition,
      // ),
      // GetPage(
      //   name: menu,
      //   page: () => const MenuPage(),
      //   transition: Transition.noTransition,
      // ),
    ];
  }

  static GetPage get unknownRoute {
    return GetPage(
      name: unknown,
      page: () => const UnknownPage(),
    );
  }

  /// 路由回调方法，处理路由变化事件
  static void routingCallback(Routing? routing) {
    bool isBottomSheet = routing?.isBottomSheet ?? false;
    bool isDialog = routing?.isDialog ?? false;
    if (isBottomSheet || isDialog) return;
    String previous = routing?.previous ?? "";
    String current = routing?.current ?? "";
    if (previous.isEmpty || current.isEmpty) return;
    // AuthRoutes.routingCallback(routing);
    // CommunityRoutes.routingCallback(routing);
    // DiscoverRoutes.routingCallback(routing);
    // HomeRoutes.routingCallback(routing);
    // MessageRoutes.routingCallback(routing);
    // ProfileRoutes.routingCallback(routing);
    // SharedRoutes.routingCallback(routing);
    // 回到Routes.menu页面，Routes.menu页面获得焦点。
    // if (previous == Routes.menu && current == Routes.menu) {}
  }

  /// 回退到菜单页路由
  static void untilMenuRoute() {
    Get.until((route) {
      return Get.currentRoute == Routes.menu;
    });
  }


  ///判断当前路由是否可返回
  static bool canPop() {
    return Get.currentRoute != Routes.menu;
  }
}
