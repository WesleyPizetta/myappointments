import 'package:flutter/material.dart';

class EventModel {
  final String eventName;
  final String eventDescription;
  final List<String> guestsEmail;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const EventModel({
    required this.eventName,
    required this.eventDescription,
    required this.from,
    required this.to,
    required this.guestsEmail,
    this.backgroundColor = Colors.lightBlue,
    this.isAllDay = false,
  });
}
