import 'package:flutter/material.dart';
import 'package:flutter_agenda/models/event_model.dart';
import '../utils.dart' as Utils;
import '../provider/event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EventSchedule extends StatefulWidget {
  final EventModel? event; // Call the Event Model

  const EventSchedule({Key? key, this.event}) : super(key: key);

  _EventScheduleState createState() => _EventScheduleState();
}

class _EventScheduleState extends State<EventSchedule> {
  final _formKey = GlobalKey<FormState>(); // Key for the form validation
  final _titleController =
  TextEditingController(); //
  final _emailController = TextEditingController(); // A controller for the title input
  String lastValue = '';
  List<String> emails = [];
  FocusNode focus = FocusNode();
  late DateTime fromDate;
  late DateTime toDate;
  bool _isSelected = false;

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

  //TODO: Save the schedule data in the model and display it on main page
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
              selectData(),
              SizedBox(
                width: 12,
              ),
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
      onFieldSubmitted: (_) => saveForm(),
      validator: (title) =>
      title != null && title.isEmpty
          ? 'Please, assign a title to your event'
          : null,
      controller: _titleController,
    );
  }

  // Data selectors widget. Here we call both fromDateSelect and toDateSelect
  Widget selectData() {
    return Column(
      children: [fromDropdown(), toDropdown()],
    );
  }

  // "From" date selector widget
  Widget fromDropdown() {
    return buildHeader(
        headerTitle: 'FROM',
        child: Row(children: [
          Expanded(
            flex: 2,
            child: dropdownButton(
                text: Utils.toDate(fromDate),
                onClicked: () => selectFromDateTime(selectDate: true)),
          ),
          Expanded(
            child: dropdownButton(
                text: Utils.toTime(fromDate),
                onClicked: () => selectFromDateTime(selectDate: false)),
          ),
        ]));
  }

  // "To" date selector widget
  Widget toDropdown() {
    return buildHeader(
        headerTitle: 'TO',
        child: Row(children: [
          Expanded(
            flex: 2,
            child: dropdownButton(text: Utils.toDate(toDate),
                onClicked: () => selectToDateTime(selectDate: true)),
          ),
          Expanded(
            child: dropdownButton(text: Utils.toTime(toDate),
                onClicked: () => selectToDateTime(selectDate: false)),
          )
        ]));
  }

  Future selectFromDateTime({required bool selectDate}) async {
    final date = await selectDateTime(fromDate, selectDate: selectDate);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      fromDate = date;
    });
  }

  Future selectToDateTime({required bool selectDate}) async {
    final date = await selectDateTime(toDate, selectDate: selectDate,
        firstDate: selectDate ? fromDate : null);

    if (date == null) return;

    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> selectDateTime(DateTime initialDate,
      {required bool selectDate, DateTime? firstDate}) async {
    if (selectDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime.now(),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
      Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate)
      );
      if (timeOfDay == null) return null;
      final date = DateTime(
          initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }


  // Dropdown widget
  Widget dropdownButton({
    required String text,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  //TODO: Finish the multiple input logic
  Widget emailInput(String label, Color color) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Guests E-mail',
        prefixIcon: Icon(Icons.mail),
      ),
      controller: _emailController,
      focusNode: focus,
      onChanged: (String val) {
        setState(() {
          if (val != lastValue) {
            lastValue = val;
            if (val.endsWith(' ') && validateEmail(val.trim())) {
              if (!emails.contains(val.trim())) {
                emails.add(val.trim());
              }
              _emailController.clear();
            } else if (val.endsWith(' ') && !validateEmail(val.trim())) {
              _emailController.clear();
            }
          }
        });
      },
      onEditingComplete: () {
        updateEmails();
        print(this.emails);
      },
    );
  }

  updateEmails() {
    setState(() {
      if (validateEmail(_emailController.text)) {
        if (!emails.contains(_emailController.text)) {
          emails.add(_emailController.text.trim());
        }
        _emailController.clear();
      } else if (!validateEmail(_emailController.text)) {
        _emailController.clear();
      }
    });
  }

  setEmails(List<String> emails) {
    this.emails = emails;
  }


  Widget buildHeader({required Widget child, required String headerTitle}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(headerTitle, style: TextStyle(fontWeight: FontWeight.bold)),
          child
        ],
      ),
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = EventModel(
          eventName: _titleController.text,
          eventDescription: 'Description',
          guestsEmail: _emailController.text,
          to: toDate,
          from: fromDate,
          isAllDay: false
      );

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      Navigator.of(context).pop();
    }
  }

  bool validateEmail(String value) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return emailValid;
  }

  // Save button widget
  List<Widget> buildEventActions() =>
      [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: saveForm,
          icon: Icon(Icons.done),
          label: Text('Save'),
        )
      ];
}
