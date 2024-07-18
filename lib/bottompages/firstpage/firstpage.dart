import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latte/size_config.dart';
import 'package:latte/widgets/pop_up_window.dart';
import 'package:table_calendar/table_calendar.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  DateTime? _selectedDay;
  int? _difference;
  late String _currentMonth; // 현재 달 이름을 저장할 변수 추가

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay =
        DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day);
    _lastDay =
        DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day);
    _selectedDay = _focusedDay;
    _difference = 0; // _difference 초기화
    _updateDifference();
    _currentMonth = DateFormat.MMMM().format(_focusedDay); // _currentMonth 초기화
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; // _focusedDay 업데이트
      _currentMonth = DateFormat.MMMM().format(_focusedDay); // 현재 달 이름 업데이트
      _updateDifference();
    });
    print("Selected day: $_selectedDay");
  }

  void _updateDifference() {
    final dateA = DateTime(2023, 9, 24);
    final DateTime? dateB;
    if (_selectedDay == null) {
      dateB = DateTime.now();
    } else {
      dateB = _selectedDay;
    }
    final difference = dateA.difference(dateB!).inDays;

    setState(() {
      _difference = difference;
    });
  }

  List<Widget> pages = [const diary(), const test()]; //위치수정필요.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // body 위에 appBar
      appBar: AppBar(
        centerTitle: true, // Title text 가운데 정렬
        leading: Container(
          margin: const EdgeInsets.all(10.0), // 여기에 마진 추가
          width: getProportionateScreenWidth(10),
          height: getProportionateScreenHeight(20),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/fall.png', // 이미지는 'assets' 폴더에 있는 것으로 가정
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8)), // Icon에 패딩 추가
            child: const Icon(
              Icons.calendar_month,
              size: 35,
            ),
          ),
        ],
        backgroundColor: Colors.transparent, // appBar 투명색
        elevation: 0.0, // appBar 그림자 농도 설정 (값 0으로 제거)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [
              //     Color.fromRGBO(223, 113, 186, 0),
              //     Colors.white,
              //   ],
              // ),
              ),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(100)),
              TableCalendar(
                rowHeight: 100,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.MMMM(locale).format(date),
                  formatButtonVisible: false,
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                  titleTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 25),
                ),
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  defaultTextStyle: TextStyle(
                    color: Colors.black, // 기본 날짜의 검은색 텍스트
                    fontSize: 16.0,
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.black, // 오늘 날짜의 검은색 텍스트
                    fontSize: 16.0,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent, // 오늘 날짜의 투명 배경
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFFF05B88),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Color(0xFFFAFAFA),
                    fontSize: 16.0,
                  ),
                ),
                locale: 'ko_KR',
                firstDay: _firstDay,
                lastDay: _lastDay,
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    _currentMonth = DateFormat.MMMM()
                        .format(_focusedDay); // 페이지 변경 시 달 업데이트
                  });
                },
              ),
              Container(
                width: 200,
                height: 200,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 255, 160, 249),
                ),
                child: Text(
                  _difference != null
                      ? 'D+${-_difference! + 1}' // _difference 상태 변수를 사용
                      : 'Loading...',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: pages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class diary extends StatelessWidget {
  const diary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.lightBlue),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const Dialog.fullscreen(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        pop_up_window(),
                      ],
                    ),
                  ),
                ),
                icon: const Icon(Icons.add),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              const Text(
                '추억 저장하러 가기!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}

class test extends StatelessWidget {
  const test({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: 160,
          decoration: BoxDecoration(
            image: const DecorationImage(
              opacity: 0.4,
              image: AssetImage('assets/images/fall.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            // color: Colors.lightBlue,
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              const Text(
                '행복한 하루!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              const Text('오늘은 비가 많이 와서 기분이 똥같지만 긍정적으로 생각! 행복한 하루. 끝!'),
            ],
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
