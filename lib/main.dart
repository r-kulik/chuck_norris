import 'package:bloc/bloc.dart';
import 'package:chuck_norris/main_application.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

class JokerObserver extends BlocObserver {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  Bloc.observer = JokerObserver();
  runApp(const ChuckTinderApplication());
}
