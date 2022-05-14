import 'package:flutter/material.dart';
import 'package:time_picker_widget/time_picker_widget.dart';
import 'package:intl/intl.dart';

class selectDateTime extends StatefulWidget {
  const selectDateTime({Key? key}) : super(key: key);

  @override
  State<selectDateTime> createState() => _selectDateTimeState();
}

class _selectDateTimeState extends State<selectDateTime> {
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: timeController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('time must not be empty');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'donate time',
                      prefixIcon: const Icon(
                        Icons.watch_later_outlined,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      showCustomTimePicker(
                          context: context,
                          onFailValidation: (context) =>
                              print('Unavailable selection'),
                          initialTime: TimeOfDay(hour: 8, minute: 0),
                          selectableTimePredicate: (time) =>
                              time!.hour > 7 && time.hour < 21).then((value) {
                        timeController.text = value!.format(context);
                        print(value.format(context));
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ('date must not be empty');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'donate date',
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 5))
                          .then((value) {
                        print(DateFormat.yMMMd().format(value!));
                        dateController.text = DateFormat.yMMMd().format(value);
                      });
                    },
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Container(
                    color: Colors.amber,
                    height: 40.0,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: const Text(
                        'Reservation',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
