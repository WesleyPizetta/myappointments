import 'package:flutter/material.dart';
import 'package:flutter_agenda/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_agenda/pages/event_schedule_page.dart';
import '../models/event_data_source.dart';
import 'tasks_widget.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _calendarController = CalendarController(); //creating the Calendar Controller

  @override
  void initState() {
    _calendarController.view = CalendarView.month; //initialize the calendar view from _calendarController
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
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget());
      },
      controller: _calendarController,
      onViewChanged: (ViewChangedDetails details) {
        List<DateTime> dates = details.visibleDates;
      },
    );
  }
}
