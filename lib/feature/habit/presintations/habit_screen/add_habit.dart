import 'package:dailyhabitd/core/notification/notification_service.dart';
import 'package:dailyhabitd/feature/habit/domain/entities/habit_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dailyhabitd/core/widget/custom_icons.dart';
import 'package:dailyhabitd/core/widget/defult_text.dart';
import 'package:dailyhabitd/feature/habit/data/models/habit_model.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constent/app_theme.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class AddHabit extends StatefulWidget {
  static const routeName = 'add';
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameHabit = TextEditingController();
  final TextEditingController _goalHabit = TextEditingController();
  final TextEditingController _reminderTime = TextEditingController();

  String? selectedIcon;
  bool selectedNot = false;
  TimeOfDay? pickedTime;

  Future<void> _selectTime(BuildContext context) async {
    pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final formattedTime =
          "${pickedTime!.hour.toString().padLeft(2, '0')}:${pickedTime!.minute.toString().padLeft(2, '0')}";
      setState(() {
        _reminderTime.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(local.addNewHabit,
            style: Theme.of(context).textTheme.titleLarge),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Flexible(
              child: Column(
                children: [
                  DefultText(
                    hint: local.enterHabitName,
                    controller: _nameHabit,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _goalHabit,
                    decoration: InputDecoration(
                      labelText: local.enterGoalPerDay,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return local.pleaseEnterGoal;
                      }
                      if (int.tryParse(value.trim()) == null) {
                        return local.goalMustBeNumber;
                      }
                      if (int.parse(value.trim()) <= 0) {
                        return local.goalMustBeGreater;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _reminderTime,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: local.selectReminderTime,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      suffixIcon: const Icon(Icons.access_time),
                    ),
                    onTap: () => _selectTime(context),
                  ),
                  const SizedBox(height: 30),
                  CustomIcons(
                    onIconSelected: (image) {
                      selectedIcon = image;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        local.enableNotifications,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      Switch(
                        value: selectedNot,
                        activeTrackColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            selectedNot = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  BlocListener<HabitCubit, HabitState>(
                    listener: (context, state) {
                      if (state is AddHabitError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${local.errorOccurred} ${state.message}")),
                        );
                      } else if (state is AddHabitLoaded) {
                        context.read<HabitCubit>().gitHabits();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(local.habitSaved)),
                        );
                        Navigator.of(context).pop(true);
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedIcon == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(local.pleaseSelectIcon),
                              ),
                            );
                            return;
                          }

                          final habit = HabitModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            nameHabit: _nameHabit.text.trim(),
                            goalHabitBerDay: _goalHabit.text.trim(),
                            nameImage: selectedIcon!,
                            createdAt: DateTime.now(),
                            lastUpdat: DateTime.now(),
                          );

                          context.read<HabitCubit>().addHabit(habit);
                          if (selectedNot == true && pickedTime != null) {
                            NotificationService.showDailyScheduledNotification(
                                id: int.parse(habit.id),
                                hour: pickedTime!.hour,
                                minute: pickedTime!.minute,
                                title: _nameHabit.text,
                                body: local.habitIsNow);
                          }

                          NotificationService.showBasicNotification(
                              title: _nameHabit.text, body: local.isDone);
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                          gradient: AppTheme.buttonGradient,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Center(
                          child: Text(
                            local.save,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
