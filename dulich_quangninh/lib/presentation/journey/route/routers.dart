import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/app.dart';
import 'package:dulichquangninh/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dulichquangninh/presentation/journey/am_thuc/am_thuc_screen.dart';
import 'package:dulichquangninh/presentation/journey/diem_du_lich/diem_du_lich_screen.dart';
import 'package:dulichquangninh/presentation/journey/ditich_detail/di_tich_detail_screen.dart';
import 'package:dulichquangninh/presentation/journey/luu_tru/luu_tru_screen.dart';
import 'package:dulichquangninh/presentation/journey/main/main_screen.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/sign_in/sign_in_screen.dart';
import 'package:dulichquangninh/presentation/journey/sign_up/sign_up_screen.dart';
import 'package:dulichquangninh/presentation/journey/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'argument_key_constants.dart';

RouteFactory routers() {
  return (RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => App());
      case NamedRouters.splashScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: locator<AppBloc>()
                    ..add(GetApplicationData()),
                  child: SplashScreen(),
                ));
        break;
      case NamedRouters.signInScreen:
        return MaterialPageRoute(builder: (context) => SignInScreen());
        break;
      case NamedRouters.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
        break;
      case NamedRouters.mainScreen:
        final coverImages = args[ArgKeyConstants.coverImages];
        final mapDiTich = args[ArgKeyConstants.diTichMap];

        return MaterialPageRoute(
            builder: (context) => MainScreen(coverImages, mapDiTich));
      case NamedRouters.diTichDetailScreen:
        final diTichModel = args[ArgKeyConstants.diTichModel];
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return DiTichDetailScreen(diTichModel);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      case NamedRouters.luuTruScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return LuuTruScreen();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      case NamedRouters.diemDuLichScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return DiemDuLichScreen();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      case NamedRouters.amThucScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AmThucScreen();
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      default:
        return MaterialPageRoute(
            builder: (context) => NotFoundPage(settings.name));
    }
  };
}

class NotFoundPage extends StatelessWidget {
  final String _named;

  const NotFoundPage(this._named);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not found page'),
      ),
      body: Center(
        child: Text('Sorry not found page: $_named'),
      ),
    );
  }
}
