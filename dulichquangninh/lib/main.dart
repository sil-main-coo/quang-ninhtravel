import 'package:dulichquangninh/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/delegate/bloc_delegate.dart';
import 'common/injector/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAuHg_A2KrRByq2nmxwcy0834Mkd9NTX5c',
    appId: '1:633401164212:android:e70c5525fb79cf18c632e1',
    messagingSenderId: '633401164212',
    projectId: 'dulichquangninh-e7063',
    storageBucket: 'dulichquangninh-e7063.appspot.com',
  ));

  Bloc.observer = SimpleBlocObserver();

  runApp(App());
}
