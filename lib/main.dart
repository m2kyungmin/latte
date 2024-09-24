import "package:flutter/material.dart";
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latte/bottompages/secondpage/secondpage_click.dart';
import 'package:latte/size_config.dart';
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
  runApp(const HeartPlanner());
}

class HeartPlanner extends StatelessWidget {
  const HeartPlanner({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'MangoDdobak'),
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      navigatorObservers: <NavigatorObserver>[observer],
      home: AnimatedSplashScreen(
        centered: true,
        splash:
            // const Text('Heart Planner',
            //     style: TextStyle(
            //         fontSize: 30.0,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white)),
            SvgPicture.asset(
          'assets/images/image01.svg',
          width: 300,
          height: 300,
        ),
        splashIconSize: double.infinity,
        backgroundColor: const Color(0xffE3CFCC),
        nextScreen: MyWidget(
          analytics: analytics,
          observer: observer,
        ),
        splashTransition:
            SplashTransition.fadeTransition, // https://itwise.tistory.com/19
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
    required this.analytics,
    required this.observer,
  });
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int selectedIndex = 0;

  List<Widget> pages = <Widget>[
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(
      NameValue: 'km',
      AgeValue: '24',
      EmailValue: 'asd@gmail.com',
      ImageValue: 'asd',
    ),
    const SecClick(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[100],
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(color: Colors.blueAccent),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_sharp,
            ),
            label: '캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: '추천',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: '설정',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 247, 109, 150),
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 247, 109, 150)),
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
