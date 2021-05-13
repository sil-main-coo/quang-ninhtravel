import 'package:dulichquangninh/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/delegate/bloc_delegate.dart';
import 'common/injector/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();

  runApp(App());
}
