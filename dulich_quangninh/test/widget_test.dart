// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dulichquangninh/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final List<String> test = [
      'nha-nghi',
      'khach-san']..sort((a, b)=> a.compareTo(b));

    final List<String> test1 = [
      'khach-san',
      'nha-nghi']..sort((a, b)=> a.compareTo(b));

    print(test);
    print(test1);
  });
}
