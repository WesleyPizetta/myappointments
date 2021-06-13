import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'widgets/calendar_widget.dart';

void main() {
  runApp(AgendaApp());
}

class AgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black12,
        accentColor: Colors.yellowAccent,
        primaryColor: Colors.blueGrey
      ),
      title: 'Schedule',
      home: CalendarWidget() //Call the widget that renders the Calendar
    );
  }
}
