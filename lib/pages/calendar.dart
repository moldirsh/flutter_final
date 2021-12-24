import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evernote Calendar'), centerTitle: true,),
      body: TableCalendar(focusedDay: focusedDay, firstDay: DateTime(1990), lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
        setState(() {
          format = _format;
        });
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekVisible: true,
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
        setState(() {
          selectedDay = selectDay;
          focusedDay = focusDay;
        });
        },
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
        calendarStyle: CalendarStyle(isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(color: Colors.red[200], shape: BoxShape.circle),
          selectedTextStyle: TextStyle(color: Colors.white), todayDecoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
        ),
      )
    );
  }
}
