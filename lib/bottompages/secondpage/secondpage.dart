import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latte/bottompages/secondpage/secondpage_click.dart';
import 'package:latte/size_config.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  String title;

  Event(this.title);
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});
  static DateTime selectedDay = DateTime.now();

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Event>> events = {};
  final List<Color> eventColors = [
    Color.fromARGB(255, 255, 202, 207),
    Color.fromARGB(255, 249, 238, 186),
    // Color.fromARGB(255, 222, 244, 194),
    // Color.fromARGB(255, 255, 202, 207),
  ];
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    SecondPage.selectedDay = DateTime.now();
    _focusedDay = DateTime.now();

    events[DateTime.utc(2024, 10, 13)] = [Event('닭갈비축제'), Event('프로젝트')];
    events[DateTime.utc(2024, 10, 14)] = [Event('농산물축제')];

    _addEventForDateRange(
      startDate: DateTime.utc(2024, 11, 13),
      endDate: DateTime.utc(2024, 11, 16),
      eventTitle: '홍삼축제',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 10, 3),
      endDate: DateTime.utc(2024, 10, 6),
      eventTitle: '치즈축제',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 10, 2),
      endDate: DateTime.utc(2024, 10, 6),
      eventTitle: '지평선축제',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 10, 9),
      endDate: DateTime.utc(2024, 10, 12),
      eventTitle: '세종축제',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 11, 21),
      endDate: DateTime.utc(2024, 11, 25),
      eventTitle: '방어축제',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 11, 15),
      endDate: DateTime.utc(2024, 11, 17),
      eventTitle: '페스티벌',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 10, 30),
      endDate: DateTime.utc(2024, 11, 3),
      eventTitle: '핑크뮬리',
    );
    _addEventForDateRange(
      startDate: DateTime.utc(2024, 10, 30),
      endDate: DateTime.utc(2024, 11, 4),
      eventTitle: '미술축제',
    );
  }

  void _addEventForDateRange({
    required DateTime startDate,
    required DateTime endDate,
    required String eventTitle,
  }) {
    DateTime date = startDate;
    while (date.isBefore(endDate.add(const Duration(days: 1)))) {
      if (events[date] == null) {
        events[date] = [Event(eventTitle)];
      } else {
        events[date]!.add(Event(eventTitle));
      }
      date = date.add(const Duration(days: 1));
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  Map<String, Color> assignedEventColors = {};

  Color _getUniqueColorForEvent(String eventTitle, List<Color> usedColors) {
    if (assignedEventColors.containsKey(eventTitle)) {
      return assignedEventColors[eventTitle]!;
    }

    List<Color> availableColors =
        eventColors.where((color) => !usedColors.contains(color)).toList();

    Color selectedColor;
    if (availableColors.isNotEmpty) {
      selectedColor = availableColors[random.nextInt(availableColors.length)];
    } else {
      // 모든 색상이 이미 사용된 경우, 임의로 선택
      selectedColor = eventColors[random.nextInt(eventColors.length)];
    }

    assignedEventColors[eventTitle] = selectedColor;
    return selectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 246, 248),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            TableCalendar(
              daysOfWeekHeight: getProportionateScreenHeight(30),
              rowHeight: getProportionateScreenHeight(125),
              locale: 'ko_KR',
              firstDay: DateTime.utc(2021, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  SecondPage.selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SecClick()));
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    DateFormat.yMMMM(locale).format(date),
                formatButtonVisible: false,
                titleTextStyle: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              calendarStyle: const CalendarStyle(
                rangeHighlightColor: Color.fromARGB(255, 252, 246, 248),
                canMarkersOverflow: false,
                markersAutoAligned: true,
                markersAlignment: Alignment.center,
                cellAlignment: Alignment.topCenter,
                cellMargin: EdgeInsets.symmetric(vertical: 10.0),
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 154, 147),
                  shape: BoxShape.circle,
                ),
                tableBorder: TableBorder(
                  top: BorderSide(color: Color.fromARGB(255, 202, 202, 202)),
                  bottom: BorderSide(color: Color.fromARGB(255, 202, 202, 202)),
                ),
                selectedDecoration: BoxDecoration(),
                selectedTextStyle: TextStyle(),
              ),
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    final reversedEvents =
                        (events as List<Event>).reversed.toList();

                    List<Color> usedColors = [];

                    return Positioned(
                      top: 50,
                      child: Column(
                        children: reversedEvents.map((event) {
                          // 같은 날짜에 같은 색이 겹치지 않도록 색상 할당
                          final eventColor =
                              _getUniqueColorForEvent(event.title, usedColors);
                          usedColors.add(eventColor);

                          return Row(children: [
                            Container(
                              width: getProportionateScreenHeight(70),
                              margin: const EdgeInsets.fromLTRB(1, 0, 0, 3),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: eventColor,
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  event.title,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    );
                  }
                  return const SizedBox();
                },
                defaultBuilder: (context, day, focusedDay) {
                  return Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 99, 99, 99),
                        fontSize: 17,
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: getProportionateScreenWidth(40),
                            height: getProportionateScreenHeight(40),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF05B88),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
