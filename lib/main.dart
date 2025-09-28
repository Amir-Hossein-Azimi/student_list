import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_list/app.dart';

//http
//retrofit
//dio
void main() {
  //enable edge to edge API36,android16
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  //
  runApp(const MyApp());
}
