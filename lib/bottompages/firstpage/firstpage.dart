import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latte/size_config.dart';
import 'package:latte/widgets/pop_up_window.dart';
import 'package:latte/widgets/schedule_add.dart';
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
  List<Map<String, String>> list = [];
  final List<DateTime> _markerDates = [
    DateTime(DateTime.now().year, 10, 7),
    DateTime(DateTime.now().year, 10, 8),
    DateTime(DateTime.now().year, 10, 27),
    DateTime(DateTime.now().year, 10, 27),
  ];

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

  Future<void> _addPopup() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) => const Dialog(
        child: schedule_add(),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        list.add(result);
      });
    }
  }

  void _removeSchedule(int index) {
    setState(() {
      list.removeAt(index); // 오늘의 일정 리스트에서 항목 제거
    });
  }

  void _removeMemory(int index) {
    setState(() {
      entries.removeAt(index); // 추억 리스트에서 항목 제거
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 246, 248),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(2)),
            child: IconButton(
              icon: const Icon(Icons.add, size: 35),
              onPressed: _addPopup,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(8)),
            child: IconButton(
              icon: const Icon(Icons.calendar_month, size: 35),
              onPressed: _toggleCalendarFormat,
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 252, 246, 248),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(45)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  TableCalendar(
                    availableGestures: AvailableGestures.none,
                    daysOfWeekHeight: getProportionateScreenHeight(18),
                    rowHeight: getProportionateScreenHeight(100),
                    headerStyle: HeaderStyle(
                      headerMargin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      titleCentered: true,
                      titleTextFormatter: (date, locale) =>
                          DateFormat.MMMM(locale).format(date),
                      formatButtonVisible: false,
                      leftChevronVisible: true,
                      rightChevronVisible: true,
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
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
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        // 마커가 필요한 날짜에만 표시하도록 조건 설정
                        if (_markerDates
                            .any((markerDate) => isSameDay(markerDate, day))) {
                          return Positioned(
                            bottom: 13,
                            child: Container(
                              width: getProportionateScreenHeight(8.0),
                              height: getProportionateScreenHeight(8.0),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(
                                    255, 235, 146, 146), // 마커 색상 설정
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }
                        return null;
                      },
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
                    width: getProportionateScreenHeight(250),
                    height: getProportionateScreenHeight(250),
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
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 246, 158, 211),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Transform.translate(
                    offset: Offset(getProportionateScreenHeight(20), 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Container(
                                height: getProportionateScreenHeight(40),
                                width: getProportionateScreenHeight(110),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color.fromARGB(255, 253, 179, 208),
                                ),
                                child: const Center(
                                  child: Text(
                                    '오늘의 일정',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          children: [
                            Column(
                              children: list.asMap().entries.map((data) {
                                int index = data.key;
                                Map<String, String> dataData = data.value;
                                return MouseRegion(
                                  onEnter: (_) {
                                    setState(() {});
                                  },
                                  onExit: (_) {
                                    setState(() {});
                                  },
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          32.0),
                                                ),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 254, 250, 251),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      30, 30, 30, 30),
                                                  // padding: const EdgeInsets.all(
                                                  //     30.0),
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              410),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      10)),
                                                          // Title Section
                                                          Center(
                                                            child: Text(
                                                              dataData['title']!
                                                                          .length >
                                                                      7
                                                                  ? '${dataData['title']!.substring(0, 5)}...'
                                                                  : dataData[
                                                                      'title']!,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFF05B88),
                                                                fontSize: 30,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      20)),

                                                          // Content Section
                                                          Container(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    1.0),
                                                            width:
                                                                getProportionateScreenHeight(
                                                                    500.0),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                205, 205, 205),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      20)),
                                                          // Start Date Section
                                                          const Text(
                                                            '시작',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      241,
                                                                      143,
                                                                      173),
                                                            ),
                                                          ),

                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  dataData[
                                                                      'startDate']!,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            85,
                                                                            85,
                                                                            85),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      getProportionateScreenHeight(
                                                                          10)),
                                                              Text(
                                                                dataData[
                                                                    'startTime']!,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          85,
                                                                          85,
                                                                          85),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      20)),

                                                          // Content Section
                                                          Container(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    1.0),
                                                            width:
                                                                getProportionateScreenHeight(
                                                                    500.0),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                205, 205, 205),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      20)),

                                                          // End Date Section
                                                          const Text(
                                                            '종료',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      241,
                                                                      143,
                                                                      173),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      8)),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  dataData[
                                                                      'endDate']!,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            85,
                                                                            85,
                                                                            85),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      getProportionateScreenHeight(
                                                                          10)),
                                                              Text(
                                                                dataData[
                                                                    'endTime']!,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          85,
                                                                          85,
                                                                          85),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      10)),

                                                          // Content Section
                                                          Container(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    1.0),
                                                            width:
                                                                getProportionateScreenHeight(
                                                                    500.0),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                205, 205, 205),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      20)),
                                                          Container(
                                                            child: Text(
                                                              '내용',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        241,
                                                                        143,
                                                                        173),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            dataData['content']!
                                                                        .length >
                                                                    100
                                                                ? '${dataData['content']!.substring(0, 100)}...'
                                                                : dataData[
                                                                    'content']!,
                                                            style: TextStyle(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      1.5),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      85,
                                                                      85,
                                                                      85),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      50)),

                                                          // Content Section
                                                          Container(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    1.0),
                                                            width:
                                                                getProportionateScreenHeight(
                                                                    500.0),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                205, 205, 205),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      20)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 10, 10),
                                          margin: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 15),
                                          width:
                                              getProportionateScreenHeight(170),
                                          height:
                                              getProportionateScreenHeight(40),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 187, 187, 187)
                                                    .withOpacity(0.5),
                                                spreadRadius: 0.5,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            // color: const Color.fromARGB(
                                            //     235, 252, 242, 225),
                                            // color: const Color.fromARGB(
                                            //     235, 251, 231, 234),
                                            color: const Color.fromARGB(
                                                255, 239, 239, 239),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            dataData['title']!.length > 7
                                                ? '${dataData['title']!.substring(0, 7)}...'
                                                : dataData['title']!,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(40),
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          onPressed: () =>
                                              _removeSchedule(index),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(210),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: _showPopup,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 0, 40),
                            width: getProportionateScreenHeight(150),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 187, 187, 187)
                                          .withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 253, 179, 208),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: getProportionateScreenHeight(25)),
                                const Icon(Icons.add),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                const Text(
                                  '오늘의 일기!',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: getProportionateScreenHeight(10)),
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
                                //추억 저장하기 팝업창 띄우기
                                GestureDetector(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                          backgroundColor: const Color.fromARGB(
                                              255, 254, 250, 251),
                                          child: Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: SingleChildScrollView(
                                              child: Container(
                                                height:
                                                    getProportionateScreenHeight(
                                                        360),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                10)),
                                                    // Title Section
                                                    Center(
                                                      child: Text(
                                                        entryData['title']!
                                                                    .length >
                                                                7
                                                            ? '${entryData['title']!.substring(0, 6)}...'
                                                            : entryData[
                                                                'title']!,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFFF05B88),
                                                          fontSize: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                10)),
                                                    // Divider
                                                    Container(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              1.0),
                                                      width:
                                                          getProportionateScreenHeight(
                                                              500.0),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              205,
                                                              205,
                                                              205),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                20)),
                                                    // Content Section with Icon
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    170),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                  '내용',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          241,
                                                                          143,
                                                                          173),
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                                Text(
                                                                  entryData['content']!
                                                                              .length >
                                                                          100
                                                                      ? '${entryData['content']!.substring(0, 100)}...'
                                                                      : entryData[
                                                                          'content']!,
                                                                  style:
                                                                      TextStyle(
                                                                    height:
                                                                        getProportionateScreenHeight(
                                                                            1.5),
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            85,
                                                                            85,
                                                                            85),
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        if (entryData
                                                            .containsKey(
                                                                'icon'))
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0),
                                                            child: Icon(
                                                              IconData(
                                                                int.parse(
                                                                    entryData[
                                                                        'icon']!),
                                                                fontFamily:
                                                                    'MaterialIcons',
                                                              ),
                                                              color: Color(int
                                                                  .parse(entryData[
                                                                      'iconColor']!)),
                                                              size: 40,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    // Divider
                                                    Container(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              1.0),
                                                      width:
                                                          getProportionateScreenHeight(
                                                              500.0),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              205,
                                                              205,
                                                              205),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        0, 20, 10, 40),
                                    child: Container(
                                      width: getProportionateScreenHeight(140),
                                      decoration: BoxDecoration(
                                        // color: const Color.fromARGB(
                                        //     255, 233, 224, 224),
                                        color: const Color.fromARGB(
                                            255, 239, 239, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 187, 187, 187)
                                                .withOpacity(0.5),
                                            spreadRadius: 0.5,
                                            blurRadius: 10,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        // image: DecorationImage(
                                        //   image: FileImage(
                                        //     File(entryData['imagePath']!),
                                        //   ),
                                        //   fit: BoxFit.cover,
                                        //   opacity: 0.5,
                                        //   colorFilter: ColorFilter.mode(
                                        //     Colors.black.withOpacity(0.3),
                                        //     BlendMode.darken,
                                        //   ),
                                        // ),
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
                                              color: Color.fromARGB(
                                                  255, 85, 85, 85),
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            entryData['content']!.length > 10
                                                ? '${entryData['content']!.substring(0, 10)}...'
                                                : entryData['content']!,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 85, 85, 85),
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      5)),
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
                                ),

                                Positioned(
                                  right: 5,
                                  top: 15,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    onPressed: () => _removeMemory(index),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
