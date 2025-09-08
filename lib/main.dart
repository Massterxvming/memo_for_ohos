import 'package:memo_for_ohos/routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'common/common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: true,
        title: "记事本",
        theme: DesignTool.theme(),
        themeMode: ThemeMode.light,
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
      ),
    );
  }
}
