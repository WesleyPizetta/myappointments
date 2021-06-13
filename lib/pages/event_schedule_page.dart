import 'package:flutter/material.dart';
import 'package:flutter_agenda/models/event_model.dart';
import '../utils.dart' as Utils;
import 'package:intl/intl.dart';

class EventSchedule extends StatefulWidget {
  final EventModel? event; // Call the Event Model

  const EventSchedule({Key? key, this.event}) : super(key: key);

  _EventScheduleState createState() => _EventScheduleState();
}

class _EventScheduleState extends State<EventSchedule> {
  final _formKey = GlobalKey<FormState>(); // Key for the form validation
  final _titleController =
      TextEditingController(); // A controller for the title input
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      // Initializes the fromDate & toDate variables if an event don't exists
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  // Releases the memory allocated to variables when state object is removed
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // Builds the EventSchedule page view
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
              titleInput(),
              SizedBox(
                width: 12,
              ),
              selectData()
            ],
          ),
        ),
      ),
    );
  }

  // Title field widget
  Widget titleInput() {
    return TextFormField(
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Type your event title',
        prefixIcon: Icon(Icons.text_fields),
      ),
      onFieldSubmitted: (_) {},
      validator: (title) => title != null && title.isEmpty
          ? 'Please, assign a title to your event'
          : null,
      controller: _titleController,
    );
  }

  // Data selectors widget. Here we call both fromDateSelect and toDateSelect
  Widget selectData() {
    return Column(
      children: [fromDateSelect()],
    );
  }

  // "From" date selector widget
  Widget fromDateSelect() {
    return Row(children: [
      Expanded(
        child: dropdownButton(text: Utils.toDate(fromDate)),
      )
    ]);
  }

  // "To" date selector widget
  Widget toDateSelect() {
    return Row(children: [
      Expanded(
        child: dropdownButton(text: Utils.toDate(fromDate)),
      )
    ]);
  }

  // Dropdown widget
  Widget dropdownButton({text: String}) {
    return Column();
  }

  // Save button widget
  List<Widget> buildEventActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: () {},
          icon: Icon(Icons.done),
          label: Text('Save'),
        )
      ];
}
