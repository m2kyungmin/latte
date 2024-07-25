import 'dart:io';

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
  // ignore: unused_field
  late String _currentMonth;
  bool _showFullCalendar = false;
  List<Map<String, String>> entries = []; // 일기 항목을 저장할 리스트

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay =
        DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day);
    _lastDay =
        DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day);
    _selectedDay = _focusedDay;
    _difference = 0;
    _updateDifference();
    _currentMonth = DateFormat.MMMM().format(_focusedDay);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _currentMonth = DateFormat.MMMM().format(_focusedDay);
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

  void _toggleCalendarFormat() {
    setState(() {
      _showFullCalendar = !_showFullCalendar;
    });
  }

  Future<void> _showPopup() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) => const Dialog(
        child: pop_up_window(),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        entries.add(result);
      });
    }
  }

  void _removeEntry(int index) {
    setState(() {
      entries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 246, 248),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(10.0),
          width: getProportionateScreenWidth(10),
          height: getProportionateScreenHeight(10),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/fall.png',
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8)),
            child: IconButton(
              icon: Icon(Icons.calendar_month, size: 35),
              onPressed: _toggleCalendarFormat,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(65)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    daysOfWeekHeight: 18,
                    rowHeight: 100,
                    headerStyle: HeaderStyle(
                      headerMargin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
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
                    calendarFormat: _showFullCalendar
                        ? CalendarFormat.month
                        : CalendarFormat.week,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: _onDaySelected,
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                        _currentMonth = DateFormat.MMMM().format(_focusedDay);
                      });
                    },
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 223, 238),
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 245, 231, 239),
                          spreadRadius: -22.0,
                          blurRadius: 22.0,
                        ),
                      ],
                    ),
                    child: Text(
                      _difference != null
                          ? 'D+${-_difference! + 1}'
                          : 'Loading...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 246, 158, 211),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: _showPopup,
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 253, 179, 208),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: getProportionateScreenHeight(25)),
                                Icon(Icons.add),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
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
                        ),
                        const SizedBox(width: 10),
                        ...entries.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, String> entryData = entry.value;
                          return MouseRegion(
                            onEnter: (_) {
                              setState(() {});
                            },
                            onExit: (_) {
                              setState(() {});
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: FileImage(
                                            File(entryData['imagePath']!)),
                                        fit: BoxFit.cover,
                                        opacity: 0.5,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.darken,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    25)),
                                        Text(
                                          entryData['title']!.length > 7
                                              ? '${entryData['title']!.substring(0, 7)}...'
                                              : entryData['title']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          entryData['content']!.length > 10
                                              ? '${entryData['content']!.substring(0, 10)}...'
                                              : entryData['content']!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        if (entryData.containsKey('icon'))
                                          Icon(
                                              IconData(
                                                int.parse(entryData['icon']!),
                                                fontFamily: 'MaterialIcons',
                                              ),
                                              color: Color(int.parse(
                                                  entryData['iconColor']!)),
                                              size: 50),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    onPressed: () => _removeEntry(index),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
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
        GestureDetector(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => const Dialog(
              child: pop_up_window(),
            ),
          ),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 253, 179, 208),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                Icon(Icons.add),
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
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
