import 'package:flutter_agenda/models/event_model.dart';
import '../provider/event_provider.dart';
import 'package:flutter_agenda/utils.dart' as Utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventViewPage extends StatelessWidget {
  final EventModel event;

  const EventViewPage({
    Key? key,
    required this.event
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildViewActions(),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: <Widget>[
          buildDateTime(event),
          SizedBox(height: 32),
          Text(
            event.eventName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            event.eventDescription,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildDateTime(EventModel event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', Utils.toDate(event.from)),
        if(!event.isAllDay) buildDate('To', Utils.toDate(event.to))
      ],
    );
  }

  Widget buildDate(String text, String event) {
    return Row(
      children: [
        ListTile(
          title: Text(text),
        ),
        ListTile(
          title: Text(event),
        )
      ],
    );
  }


  List<Widget> buildViewActions() =>
      [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: (){},
          icon: Icon(Icons.done),
          label: Text('Save'),
        )
      ];
}