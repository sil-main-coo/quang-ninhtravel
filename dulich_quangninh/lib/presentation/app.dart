import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/common/navigation/lifecycle_event_handler.dart';
import 'package:dulichquangninh/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/sign_in/sign_in_screen.dart';
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
            create: (_) => locator<AppBloc>()),
        BlocProvider<AuthCubit>(
            create: (_) => locator<AuthCubit>()..checkAuth())
      ];

  /// ==== INIT LISTENER OF APPLICATION
  @override
  void initState() {
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(onPaused: _onPause));
    locator<AppBloc>()..add(GetApplicationData());
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
            title: 'Du lịch Đông Triều',
            theme: appTheme(buildContext),
            onGenerateRoute: routers(),
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoaded) {
                  if (state.user != null) {
                    return SplashScreen();
                  }
                  return SignInScreen();
                }

                return Scaffold(
                  body: Center(
                    child: const CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPause() async {}
}
