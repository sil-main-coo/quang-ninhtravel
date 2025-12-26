import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/app.dart';
import 'package:dulichquangninh/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dulichquangninh/presentation/journey/diem_den_nghi_duong/diem_du_lich/diem_du_lich_screen.dart';
import 'package:dulichquangninh/presentation/journey/diem_den_nghi_duong/nghi_duong/diem_den_screen.dart';
import 'package:dulichquangninh/presentation/journey/hoi_nhap/bloc/hoi_nhap_bloc.dart';
import 'package:dulichquangninh/presentation/journey/hoi_nhap/hoi_nhap_screen.dart';
import 'package:dulichquangninh/presentation/journey/main/main_screen.dart';
import 'package:dulichquangninh/presentation/journey/phi_vat_the/phi_vat_the_screen.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/sign_up/sign_up_screen.dart';
import 'package:dulichquangninh/presentation/journey/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../hoi_nhap/dac_san/dac_san_screen.dart';
import '../hoi_nhap/dac_san_detail/dac_san_detail_screen.dart';
import '../vat_the/ditich_detail/di_tich_detail_screen.dart';
import '../vat_the/vat_the_screen.dart';
import 'argument_key_constants.dart';

RouteFactory routers() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => App());
      case NamedRouters.splashScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: locator<AppBloc>(),
                  child: SplashScreen(),
                ));
        break;
      case NamedRouters.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
        break;
      case NamedRouters.mainScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final coverImages = args[ArgKeyConstants.coverImages];
        final mapDiTich = args[ArgKeyConstants.diTichMap];
        final khaiQuat = args[ArgKeyConstants.khaiQuat];

        return MaterialPageRoute(
            builder: (context) => MainScreen(coverImages, mapDiTich, khaiQuat));
      case NamedRouters.vatThe:
        final args = settings.arguments as Map<String, dynamic>;
        final mapDiTich = args[ArgKeyConstants.diTichMap];

        return MaterialPageRoute(builder: (context) => VatTheScreen(mapDiTich));
      case NamedRouters.phiVatThe:
        return MaterialPageRoute(builder: (context) => PhiVatTheScreen());
      case NamedRouters.hoiNhap:
        final args = settings.arguments as Map<String, dynamic>;
        final khaiQuat = args[ArgKeyConstants.khaiQuat];

        return MaterialPageRoute(
          builder: (context) => BlocProvider<HoiNhapBloc>(
            create: (ct) => HoiNhapBloc(dacSanRepo: locator())
              ..add(
                GetHoiNhapData(khaiQuat: khaiQuat),
              ),
            child: HoiNhapScreen(khaiQuat),
          ),
        );
      case NamedRouters.diTichDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final diTichModel = args[ArgKeyConstants.diTichModel];
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
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
            return DiemDenScreen();
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
      case NamedRouters.dacSanScreen:
        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return DacSanScreen();
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
      case NamedRouters.dacSanDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final dacSanModel = args[ArgKeyConstants.dacSanModel];
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return DacSanDetailScreen(dacSanModel);
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
      default:
        return MaterialPageRoute(
            builder: (context) => NotFoundPage(settings.name ?? ''));
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
