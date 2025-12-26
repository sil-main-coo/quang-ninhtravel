import 'package:dulichquangninh/presentation/journey/widgets/space_widgets/vertical_space_widget.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/button_home_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/list_menu_widget.dart';

class HomeScreen extends StatefulWidget {
  final List<String> coverImages;
  final Map<LoaiDiTichModel, List<DiTichModel>> mapDiTichs;
  final ({LoaiDiTichModel menu, List<DiTichModel> list}) khaiQuat;

  HomeScreen(this.coverImages, this.mapDiTichs, this.khaiQuat);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HeaderHomeWidget(widget.coverImages),
            VerticalSpace.init16(),
            Expanded(child: ButtonHomeWidget(widget.mapDiTichs, widget.khaiQuat)),
            // VerticalSpace.init8(),
            // ListMenuHomeWidget(widget.mapDiTichs)
          ],
        ),
      ),
    );
  }
}
