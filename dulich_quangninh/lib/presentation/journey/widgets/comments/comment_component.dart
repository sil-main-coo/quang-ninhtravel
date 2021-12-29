import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:dulichquangninh/presentation/journey/widgets/comments/widgets/comment_item_widget.dart';
import 'package:dulichquangninh/presentation/journey/widgets/error/dialogs.dart';
import 'package:dulichquangninh/presentation/journey/widgets/loader/loader_dialog.dart';
import 'package:dulichquangninh/providers/data_sources/remote/di_tich_source.dart';
import 'package:dulichquangninh/providers/models/comment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentComponent extends StatelessWidget {
  CommentComponent(
      {Key key, @required this.streamComments, @required this.idPost})
      : super(key: key);

  final Stream<Event> streamComments;
  final String idPost;

  final _commentCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _loader = AppLoaderDialog();

  final _diTichSource = locator.get<DiTichSource>();
  final _authCubit = locator.get<AuthCubit>();

  Future _handleComment(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      try {
        _loader.show(context);
        _diTichSource.addNewCommentToDB(
            idPost,
            Comment(
                uid: _authCubit.user.profile.id,
                fullName: _authCubit.user.profile.fullName,
                content: _commentCtrl.text.trim()));
        _loader.hide(context);
        _commentCtrl.clear();
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
    return StreamBuilder<Event>(
        stream: streamComments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comment> comments = [];
            final rawData = snapshot.data.snapshot.value;

            if (rawData != null) {
              (rawData as Map).forEach((id, value) {
                comments.insert(0, Comment.fromJson(Map.from(value), id));
              });
            }

            return _buildComment(context, comments);
          }
          return Center(child: const CircularProgressIndicator());
        });
  }

  Widget _buildComment(BuildContext context, List<Comment> comments) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [_buildFieldComment(context), _buildComments(comments)],
      ),
    );
  }

  Widget _buildFieldComment(BuildContext context) {
    final labelStyle = TextStyle(
        fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 24.sp);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: Text(
                  'VIẾT BÌNH LUẬN',
                  style: labelStyle,
                ),
              ),
              Divider(),
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          TextFormField(
            controller: _commentCtrl,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: 24.sp),
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return 'Bạn chưa nhập bình luận';

              return null;
            },
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              hintText: 'Nhập nhận xét của bạn...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 24.sp),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 24.sp),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                  onPressed: () => _handleComment(context),
                  child: Text(
                    'Gửi',
                    style: TextStyle(fontSize: 24.sp, color: Colors.white),
                  ))),
        ],
      ),
    );
  }

  Widget _buildComments(List<Comment> comments) {
    final labelStyle = TextStyle(
        fontWeight: FontWeight.w600, color: Colors.blue, fontSize: 24.sp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.w,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w),
              child: Text(
                'CÁC BÌNH LUẬN KHÁC',
                style: labelStyle,
              ),
            ),
            Divider(),
          ],
        ),
        SizedBox(
          height: 8.w,
        ),
        Column(
          children: comments
              .map((comment) => ACommentWidget(
                    comment: comment,
                  ))
              .toList(),
        )
      ],
    );
  }
}
