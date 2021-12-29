import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);

  final _authCubit = locator.get<AuthCubit>();

  void _handleSignOut(BuildContext context) {
    _authCubit.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, NamedRouters.signInScreen, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 120.w,
              child: Text(
                _authCubit.user.profile.getAvatarText(),
                style: TextStyle(fontSize: 72.sp),
              ),
            ),
            SizedBox(height: 48.w,),
            Text(
              _authCubit.user.profile.fullName,
              style: TextStyle(
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(height: 24.w,),
            Text(
              _authCubit.user.profile.phone,
              style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            SizedBox(height: 64.w,),
            SizedBox(
              height: 24.h,
              width: 210.w,
              child: RaisedButton(
                onPressed: () => _handleSignOut(context),
                color: Colors.orange,
                child: Text(
                  'ĐĂNG XUẤT',
                  style: TextStyle(fontSize: 26.sp, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
