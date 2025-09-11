import 'package:memo_for_ohos/routes.dart';
import 'package:memo_for_ohos/storage_service/stoage_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'common/common.dart';
import 'stores/theme_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  Get.put(ThemeStore());
  ThemeStore.logic?.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return RefreshConfiguration(
      child: GetBuilder<ThemeStore>(builder: (store) {
        return GetMaterialApp(
          title: "光阴手账",
          theme: DesignTool.theme(),
          darkTheme: DesignTool.darkTheme(),
          themeMode: store.themeMode,
          initialRoute: Routes.launch,
          getPages: Routes.getPages,
          unknownRoute: Routes.unknownRoute,
          // navigatorObservers: [appNavigatorObserver],
          routingCallback: Routes.routingCallback,
          defaultTransition: Transition.cupertino,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
                boldText: false,
              ),
              child: child!,
            );
          },
        );
      }),
    );
  }
}
