import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_agenda/pages/event_schedule_page.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    _calendarController.view = CalendarView.week;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _displayWidth = MediaQuery.of(context).size.width;
    double _displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Schedule')),
      body: Center(
        child: renderCalendar(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueGrey,
        onPressed: () => {Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventSchedule())
        )},
      ),
    );
  }

  Widget renderCalendar(BuildContext context) {
    return SfCalendar(
      controller: _calendarController,
      onViewChanged: (ViewChangedDetails details) {
        List<DateTime> dates = details.visibleDates;
      },
    );
  }
}
