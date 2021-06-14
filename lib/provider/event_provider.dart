import '../models/event_model.dart';
import 'package:flutter_agenda/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  final List<EventModel> _events = [];

  List<EventModel> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<EventModel> get eventsOfSelectedDate => _events;

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }
}