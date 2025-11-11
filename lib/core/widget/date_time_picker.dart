import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter/material.dart';

class TimePickerExample extends StatefulWidget {
  const TimePickerExample({super.key});

  @override
  State<TimePickerExample> createState() => _TimePickerExampleState();
}

class _TimePickerExampleState extends State<TimePickerExample> {
  String selectedTime = "لم يتم اختيار وقت بعد";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedTime,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            DatePicker.showTimePicker(
              context,
              showTitleActions: true,
              onConfirm: (time) {
                setState(() {
                  selectedTime =
                  "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                });
              },
              locale: LocaleType.ar,
            );
          },
          child: const Text("اختيار الوقت"),
        ),
      ],
    );
  }
}
