import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_agenda/pages/event_schedule_page.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _calendarController = CalendarController(); //creating the Calendar Controller

  @override
  void initState() {
    _calendarController.view = CalendarView.week; //initialize the calendar view from _calendarController
    super.initState();
  }

  //Building the entire calendar. Using some widgets to make it better for a future maintenance and make it better to read
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule')),
      body: Center(
        child: renderCalendar(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueGrey,
        onPressed: () => {Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventSchedule()) //EventSchedule is the page where we're going to write all the code for an event creation
        )},
      ),
    );
  }

  //Renders the calendar by using the SfCalendar widget from SyncFusion Calendar package
  Widget renderCalendar(BuildContext context) {
    return SfCalendar(
      controller: _calendarController,
      onViewChanged: (ViewChangedDetails details) {
        List<DateTime> dates = details.visibleDates;
      },
    );
  }
}
