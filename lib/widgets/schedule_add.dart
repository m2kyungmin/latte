import 'package:flutter/material.dart';
import 'package:latte/size_config.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class schedule_add extends StatefulWidget {
  const schedule_add({super.key});

  @override
  ScheduleAddState createState() => ScheduleAddState();
}

class ScheduleAddState extends State<schedule_add> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  DateTime _selectedStartTime = DateTime.now();
  DateTime _selectedEndTime = DateTime.now();
  bool _showStartCalendar = false;
  bool _showEndCalendar = false;
  bool _showStartTimePicker = false;
  bool _showEndTimePicker = false;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy년 M월 d일 (E)', 'ko').format(date);
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(600),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromARGB(255, 254, 250, 251),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          SizedBox(height: getProportionateScreenHeight(40)),
          TextField(
            style: TextStyle(fontSize: getProportionateFontSize(15)),
            controller: titleController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: getProportionateScreenHeight(1),
                    color: Color(0xFFF48FB1)),
              ),
              border: OutlineInputBorder(),
              hintText: '제목',
            ),
            keyboardType: TextInputType.text,
            minLines: 1,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),

          // 시작 날짜 선택
          Row(
            children: [
              Container(
                child: const Text('시작'),
                width: getProportionateScreenHeight(45),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  width: getProportionateScreenHeight(190),
                  height: getProportionateScreenHeight(40),
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 236, 243),
                      foregroundColor: const Color.fromARGB(255, 253, 179, 208),
                    ),
                    onPressed: () {
                      setState(() {
                        _showStartCalendar = !_showStartCalendar;
                      });
                    },
                    child: Text(
                      _formatDate(_selectedStartDate),
                      style: TextStyle(
                          color: Color(0xFFF05B88),
                          fontSize: getProportionateFontSize(12.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showStartCalendar)
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _selectedStartDate,
              selectedDayPredicate: (day) => isSameDay(_selectedStartDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedStartDate = selectedDay;
                  _showStartCalendar = false;
                });
              },
              daysOfWeekHeight: getProportionateScreenHeight(20),
              rowHeight: getProportionateScreenHeight(40), // 주 간격 줄이기
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                leftChevronVisible: true,
                rightChevronVisible: true,
                titleTextFormatter: (date, locale) =>
                    '${DateFormat.M(locale).format(date)}월',
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateFontSize(17.0), // 월 글자 크기
                ),
              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateFontSize(16.0),
                ),
                todayTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateFontSize(16.0),
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
                  fontSize: getProportionateFontSize(16.0),
                ),
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(10)),

          // 시작 시간 선택
          Row(
            children: [
              Container(
                width: getProportionateScreenHeight(45),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  width: getProportionateScreenHeight(190),
                  height: getProportionateScreenHeight(40),
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 236, 243),
                      foregroundColor: const Color.fromARGB(255, 253, 179, 208),
                    ),
                    onPressed: () {
                      setState(() {
                        _showStartTimePicker = !_showStartTimePicker;
                      });
                    },
                    child: Text(
                      _formatTime(_selectedStartTime),
                      style: TextStyle(
                          color: Color(0xFFF05B88),
                          fontSize: getProportionateFontSize(12.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showStartTimePicker)
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontSize: getProportionateFontSize(15), color: Colors.black),
              highlightedTextStyle: TextStyle(
                  fontSize: getProportionateFontSize(15), color: Colors.pink),
              spacing: 40,
              itemHeight: getProportionateScreenHeight(40),
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  _selectedStartTime = time;
                });
              },
            ),
          SizedBox(height: getProportionateScreenHeight(10)),

          // 종료 날짜 선택
          Row(
            children: [
              Container(
                child: const Text('종료'),
                width: getProportionateScreenHeight(45),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  width: getProportionateScreenHeight(190),
                  height: getProportionateScreenHeight(40),
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 236, 243),
                      foregroundColor: const Color.fromARGB(255, 253, 179, 208),
                    ),
                    onPressed: () {
                      setState(() {
                        _showEndCalendar = !_showEndCalendar;
                      });
                    },
                    child: Text(
                      _formatDate(_selectedEndDate),
                      style: TextStyle(
                          color: Color(0xFFF05B88),
                          fontSize: getProportionateFontSize(12.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showEndCalendar)
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _selectedEndDate,
              selectedDayPredicate: (day) => isSameDay(_selectedEndDate, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedEndDate = selectedDay;
                  _showEndCalendar = false;
                });
              },
              daysOfWeekHeight: getProportionateScreenHeight(20),
              rowHeight: getProportionateScreenHeight(40), // 주 간격 줄이기
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                leftChevronVisible: true,
                rightChevronVisible: true,
                titleTextFormatter: (date, locale) =>
                    '${DateFormat.M(locale).format(date)}월',
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateFontSize(17.0), // 월 글자 크기
                ),
              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateFontSize(16.0),
                ),
                todayTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateFontSize(16.0),
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
                  fontSize: getProportionateFontSize(16.0),
                ),
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(10)),

          // 종료 시간 선택
          Row(
            children: [
              Container(
                width: getProportionateScreenHeight(45),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  width: getProportionateScreenHeight(190),
                  height: getProportionateScreenHeight(40),
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 236, 243),
                      foregroundColor: const Color.fromARGB(255, 253, 179, 208),
                    ),
                    onPressed: () {
                      setState(() {
                        _showEndTimePicker = !_showEndTimePicker;
                      });
                    },
                    child: Text(
                      _formatTime(_selectedEndTime),
                      style: TextStyle(
                          color: Color(0xFFF05B88),
                          fontSize: getProportionateFontSize(12.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showEndTimePicker)
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontSize: getProportionateFontSize(15), color: Colors.black),
              highlightedTextStyle: TextStyle(
                  fontSize: getProportionateFontSize(15), color: Colors.pink),
              spacing: 40,
              itemHeight: getProportionateScreenHeight(40),
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  _selectedEndTime = time;
                });
              },
            ),
          SizedBox(height: getProportionateScreenHeight(20)),

          // 메모 입력 및 저장 버튼
          TextField(
            style: TextStyle(fontSize: getProportionateFontSize(15)),
            controller: contentController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: getProportionateScreenHeight(1),
                    color: Color(0xFFF48FB1)),
              ),
              border: OutlineInputBorder(),
              hintText: '메모',
            ),
            keyboardType: TextInputType.text,
            minLines: 3,
            maxLines: 3,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 179, 208),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('이전 화면으로'),
              ),
              SizedBox(width: getProportionateScreenHeight(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 179, 208),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      contentController.text.isNotEmpty) {
                    Navigator.pop(context, {
                      'title': titleController.text,
                      'content': contentController.text,
                      'startDate': _formatDate(_selectedStartDate),
                      'startTime': _formatTime(_selectedStartTime),
                      'endDate': _formatDate(_selectedEndDate),
                      'endTime': _formatTime(_selectedEndTime),
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            '모든 항목을 입력해주세요.',
                            style: TextStyle(fontSize: 15),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                '확인',
                                style: TextStyle(color: Color(0xFFF05B88)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('저장하기'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
