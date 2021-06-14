import 'package:flutter_agenda/models/event_data_source.dart';
import 'package:flutter_agenda/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../pages/event_view_page.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if(selectedEvents.isEmpty) {
      return Center(
        child: Text(
          'No events found',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(0.3)
        ),
        appointmentBuilder: appointmentBuilder,
        onTap: (details) {
          if(details.appointments == null) return;

          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventViewPage(event: event))
          );
        },
      ),
    );
  }

  Widget appointmentBuilder (BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),

      ),
      child: Center(
        child: Text(
          event.eventName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );

}
}