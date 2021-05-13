import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/app.dart';
import 'package:dulichquangninh/presentation/journey/ditich_detail/di_tich_detail_screen.dart';
import 'package:dulichquangninh/presentation/journey/home/home_screen.dart';
import 'package:dulichquangninh/presentation/journey/luu_tru/bloc/luu_tru_bloc.dart';
import 'package:dulichquangninh/presentation/journey/luu_tru/luu_tru_screen.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
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
        return MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case NamedRouters.homeScreen:
        final coverImages = args[ArgKeyConstants.coverImages];
        final mapDiTich = args[ArgKeyConstants.diTichMap];

        return MaterialPageRoute(
            builder: (context) => HomeScreen(coverImages, mapDiTich));
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
            return BlocProvider<LuuTruBloc>(
              create: (_) => locator<LuuTruBloc>()..add(GetLuuTruData()),
              child: LuuTruScreen(),
            );
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: BlocProvider<LuuTruBloc>(
                  create: (_) => locator<LuuTruBloc>()..add(GetLuuTruData()),
                  child: child,
                ),
              ),
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
