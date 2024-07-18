import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:latte/bottompages/secondpage/secondpage_click.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  String title;

  Event(this.title);
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2024, 7, 13): [Event('title'), Event('title2')],
    DateTime.utc(2024, 7, 22): [Event('title3')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TableCalendar(
        daysOfWeekHeight: 60,
        rowHeight: 100,
        locale: 'ko_KR',
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        // calendarStyle: const CalendarStyle(
        //   markerSize: 10.0,
        // ),
        // eventLoader: _getEventsForDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          print('Selected day: $selectedDay');
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.MMMM(locale).format(date),
          formatButtonVisible: false,
        ),
        calendarStyle: const CalendarStyle(
          canMarkersOverflow: false,
          markersAutoAligned: true,
          markersAlignment: Alignment.bottomCenter,
          cellAlignment: Alignment.center,
          cellMargin: EdgeInsets.symmetric(vertical: 10.0),
          selectedTextStyle: TextStyle(color: Colors.black),
          selectedDecoration: BoxDecoration(
            color: Color.fromARGB(255, 239, 239, 239),
            shape: BoxShape.rectangle,
          ),
          todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 154, 147),
            shape: BoxShape.circle,
          ),
          tableBorder: TableBorder(
            top: BorderSide(color: Color.fromARGB(255, 202, 202, 202)),
            bottom: BorderSide(color: Color.fromARGB(255, 202, 202, 202)),
          ),
        ),
        eventLoader: (day) {
          return _getEventsForDay(day); // 이벤트 로더 함수가 올바르게 설정되었는지 확인
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                top: 1,
                bottom: 1,
                child: Icon(
                  Icons.favorite,
                  color: Colors.pink.withOpacity(0.3), // 불투명도를 0.5로 설정
                  size: 50,
                ),
              );
            }
            return const SizedBox();
          },
          defaultBuilder: (context, day, focusedDay) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = day;
                  _focusedDay = focusedDay;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecClick())); //수정필요
                print('Selected day: $day');
              },
              child: Container(
                alignment: Alignment.topCenter, // 날짜 글씨를 가운데 상단으로 위치 조정
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isSameDay(_selectedDay, day)
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Container(
              alignment: Alignment.topCenter, // 오늘 날짜 글씨를 가운데 상단으로 위치 조정
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 242, 154, 147),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              alignment: Alignment.topCenter, // 선택된 날짜 글씨를 가운데 상단으로 위치 조정
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 239, 239, 239),
                shape: BoxShape.rectangle,
              ),
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = day;
                  _focusedDay = focusedDay;
                });
                print('Selected day: $day');
              },
              child: Container(
                alignment: Alignment.topCenter, // 다른 달 날짜 글씨를 가운데 상단으로 위치 조정
                child: Text(
                  '${day.day}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
