import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  final List<String> coverImages;
  final Map<LoaiDiTichModel, List<DiTichModel>> mapDiTichs;

  MainScreen(this.coverImages, this.mapDiTichs);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   HomeScreen(widget.coverImages, widget.mapDiTichs),
    );
  }
}
