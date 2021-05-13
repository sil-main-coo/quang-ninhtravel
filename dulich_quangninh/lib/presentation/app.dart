import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/common/navigation/lifecycle_event_handler.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
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

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  List<BlocProvider> _getProviders() => [
        BlocProvider<AppBloc>(
            create: (_) => locator<AppBloc>()..add(GetApplicationData()))
      ];

  /// ==== INIT LISTENER OF APPLICATION
  @override
  void initState() {
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(onPaused: _onPause));
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return ScreenUtilInit(
      designSize: Size(640, 360),
      builder: () => MultiBlocProvider(
        providers: _getProviders(),
        child: GestureDetector(
          onTap: () {
            // unFocus text field
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: MaterialApp(
            navigatorKey: App.navigator,
//            localizationsDelegates: [],
//          supportedLocales: const [
//            Locale(LanguageConstants.en),
//            Locale(LanguageConstants.vn),
//          ],
            title: 'Du lịch Đông Triều',
            theme: appTheme(buildContext),
            onGenerateRoute: routers(),
            initialRoute: NamedRouters.splashScreen,
          ),
        ),
      ),
    );
  }

  Future<void> _onPause() async {}
}
