import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planning_poker_ifood/firebase_options.dart';
import 'package:planning_poker_ifood/src/app_widget.dart';
import 'package:planning_poker_ifood/src/core/DI/dependence_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDI();
  runApp(const AppWidget());
}
