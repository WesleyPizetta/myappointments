import '../models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<EventModel> appointments) {
    this.appointments = appointments;
  }

  EventModel getEvent(int index) => appointments![index] as EventModel;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).eventName;

  @override
  String getDescription(int index) => getEvent(index).eventDescription;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}