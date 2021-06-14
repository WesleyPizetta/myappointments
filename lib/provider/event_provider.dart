import '../models/event_model.dart';
import 'package:flutter_agenda/utils.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  final List<EventModel> _events = [];

  List<EventModel> get events => _events;

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }
}