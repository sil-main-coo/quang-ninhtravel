import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:dulichquangninh/providers/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ACommentWidget extends StatefulWidget {
  const ACommentWidget({Key key, this.comment}) : super(key: key);

  final Comment comment;

  @override
  _ACommentWidgetState createState() => _ACommentWidgetState();
}

class _ACommentWidgetState extends State<ACommentWidget> {
  final _authCubit = locator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24.w,
                child: Text('AB'),
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.comment.fullName}${_authCubit.user.profile.id == widget.comment.uid ? ' (Tôi)' : ''}',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    widget.comment.content,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    widget.comment.createDateTime.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
