import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/common/navigation/lifecycle_event_handler.dart';
import 'package:dulichquangninh/presentation/journey/splash_screen/splash_screen.dart';
import 'package:dulichquangninh/presentation/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/app_bloc/app_bloc.dart';
import 'journey/route/routers.dart';

class App extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigator =
      GlobalKey<NavigatorState>();

  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  List<BlocProvider> _getProviders() => [
        BlocProvider<AppBloc>(
            create: (_) => locator<AppBloc>()),

      ];

  /// ==== INIT LISTENER OF APPLICATION
  @override
  void initState() {
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(onPaused: _onPause));
    locator<AppBloc>().add(const GetApplicationData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(640, 360),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: _getProviders(),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
              navigatorKey: App.navigator,
              title: 'Về miền di sản',
              debugShowCheckedModeBanner: false,
              theme: appTheme(context),
              onGenerateRoute: routers(),
              home: SplashScreen(),
            ),
          ),
        );
      },
    );
  }


  Future<void> _onPause() async {}
}
