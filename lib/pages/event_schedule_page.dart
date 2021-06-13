import 'package:flutter/material.dart';
import 'package:flutter_agenda/models/event_model.dart';

class EventSchedule extends StatefulWidget {
  final EventModel? event;

  const EventSchedule({Key? key, this.event}) : super(key: key);

  _EventScheduleState createState() => _EventScheduleState();
}

class _EventScheduleState extends State<EventSchedule> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEventActions(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              titleInput()
            ],
          ),
        ),
      ),
    );
  }

  Widget titleInput() {
    return TextFormField(
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Type your event title',
        prefixIcon: Icon(Icons.text_fields),
      ),
      onFieldSubmitted: (_) {},
      validator: (title) =>
        title != null && title.isEmpty ? 'Please, assign a title to your event' : null,
      controller: _titleController,
    );
  }

  List<Widget> buildEventActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent
          ),
          onPressed: () {},
          icon: Icon(Icons.done),
          label: Text('Save'),
        )
  ];
}
