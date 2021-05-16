import 'dart:math';

import 'package:dulichquangninh/presentation/journey/luu_tru/widgets/triangle_widget.dart';
import 'package:dulichquangninh/presentation/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItemWidget extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;
  final IconData iconBack;
  final IconData iconFront;

  const CardItemWidget(
      {@required this.frontWidget,
      @required this.backWidget,
      @required this.iconBack,
      @required this.iconFront});

  @override
  _CardItemWidgetState createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  bool _displayFront;
  bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _displayFront = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation();
  }

  void _switchCard() {
    setState(() {
      _displayFront = !_displayFront;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        child: _displayFront ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_displayFront) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
        key: ValueKey(true),
        child: widget.frontWidget,
        iconData: widget.iconFront,
        color: AppColor.primaryColor);
  }

  Widget _buildRear() {
    return __buildLayout(
        key: ValueKey(false),
        child: widget.backWidget,
        iconData: widget.iconBack,
        color: AppColor.primaryDarkColor);
  }

  Widget __buildLayout(
      {Key key, Widget child, IconData iconData, Color color}) {
    return Card(
      key: key,
      elevation: 3,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 68.h,
            width: double.infinity,
            child: child,
          ),
          Align(
            alignment: Alignment.topRight,
            child: TriangleWidget(
              icon: iconData,
              sizeIcon: 32.w,
              sizeContainer: 80.w,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
