import "package:flutter/material.dart";
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:latte/bottompages/secondpage/secondpage_click.dart';
import 'package:latte/size_config.dart';
import 'bottompages/firstpage/firstpage.dart';
import 'bottompages/secondpage/secondpage.dart';
import 'bottompages/thirdpage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const HeartPlanner());
}

class HeartPlanner extends StatelessWidget {
  const HeartPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      //themeMode: ThemeMode.dark,
      home: AnimatedSplashScreen(
        centered: true,
        splash:
            // const Text('Heart Planner',
            //     style: TextStyle(
            //         fontSize: 30.0,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white)),
            Image.asset('assets/images/fall.png'),
        splashIconSize: double.infinity,
        backgroundColor: Colors.black,
        nextScreen: const MyWidget(),
        splashTransition:
            SplashTransition.fadeTransition, // https://itwise.tistory.com/19
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int selectedIndex = 0;

  List<Widget> pages = <Widget>[
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
    const SecClick()
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
        selectedItemColor: Colors.green,
        selectedIconTheme: const IconThemeData(color: Colors.green),
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
