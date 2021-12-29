import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/journey/route/named_routers.dart';
import 'package:dulichquangninh/presentation/journey/widgets/animation/fade_animation.dart';
import 'package:dulichquangninh/presentation/journey/widgets/error/dialogs.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/loader_dialog.dart';
import 'package:dulichquangninh/providers/data_sources/remote/auth_remote_provider.dart';
import 'package:dulichquangninh/providers/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameCtrl = TextEditingController();

  final _phoneCtrl = TextEditingController();

  final _passwordCtrl = TextEditingController();

  final _rePasswordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _loader = AppLoaderDialog();

  final _authProvider = locator.get<AuthRemoteProvider>();

  Future _handleSignUp() async {
    if (_formKey.currentState.validate()) {
      try {
        _loader.show(context);
        final user = await _authProvider.signUp(User(
            phone: _phoneCtrl.text.trim(),
            password: _passwordCtrl.text.trim(),
            profile: UserProfile(
              fullName: _fullNameCtrl.text.trim(),
              phone: _phoneCtrl.text.trim(),
              email: '',
              avatar: '',
            )));
        _loader.hide(context);
        AppDialog.showNotifyDialog(
            context: context,
            title: 'Thành công',
            mess:
                'Đăng ký tài khoản thành công.\nHãy đăng nhập để trải nghiệm dịch vụ.',
            textBtn: 'OK',
            function: () => Navigator.pushReplacementNamed(
                context, NamedRouters.signInScreen),
            color: Colors.green,
            titleColor: Colors.green);
      } catch (e) {
        _loader.hide(context);
        AppDialog.showNotifyDialog(
            context: context,
            mess: e.toString(),
            textBtn: 'OK',
            function: () => Navigator.pop(context),
            color: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Đăng ký",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(150, 120, 180, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _fullNameCtrl,
                                        validator: (value) {
                                          if (value == null || value.isEmpty)
                                            return 'Trường bắt buộc';
                                          return null;
                                        },
                                        style: TextStyle(fontSize: 24.sp),
                                        decoration: InputDecoration(
                                            hintText: "Họ và tên",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.sp),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _phoneCtrl,
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 10)
                                            return 'Số điện thoại không hợp lệ';
                                          return null;
                                        },
                                        style: TextStyle(fontSize: 24.sp),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Số điện thoại",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.sp),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _passwordCtrl,
                                        validator: (value) {
                                          if (value == null || value.length < 6)
                                            return 'Mật khẩu phải nhiều hơn 6 ký tự';
                                          return null;
                                        },
                                        style: TextStyle(fontSize: 24.sp),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Mật khẩu",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.sp),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _rePasswordCtrl,
                                        validator: (value) {
                                          if (value == null || value.length < 6)
                                            return 'Mật khẩu phải nhiều hơn 6 ký tự';
                                          if (value !=
                                              _passwordCtrl.text.trim())
                                            return 'Mật khẩu không khớp';
                                          return null;
                                        },
                                        style: TextStyle(fontSize: 24.sp),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Nhập lại mật khẩu",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 24.sp),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          FadeAnimation(
                              1.6,
                              InkWell(
                                onTap: () => _handleSignUp(),
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.orange[900]),
                                  child: Center(
                                    child: Text(
                                      "ĐĂNG KÝ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.sp),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 16.h,
                          ),
                          FadeAnimation(
                              1.7,
                              Text(
                                "Nếu đã có tài khoản? Hãy đăng nhập !",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 22.sp),
                              )),
                          SizedBox(
                            height: 8.h,
                          ),
                          FadeAnimation(
                              1.8,
                              InkWell(
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, NamedRouters.signInScreen),
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.blue),
                                    // color: Colors.blue
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ĐĂNG NHẬP",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.sp,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
