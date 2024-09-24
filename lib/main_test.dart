import "package:flutter/material.dart";
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latte/bottompages/secondpage/secondpage_click.dart';
import 'package:latte/size_config.dart';
import 'package:latte/widgets/login.dart';
import 'bottompages/firstpage/firstpage.dart';
import 'bottompages/secondpage/secondpage.dart';
import 'bottompages/thirdpage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting(); // 추가된 부분, 원하는 로케일로 변경
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
