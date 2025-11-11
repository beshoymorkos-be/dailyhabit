import 'package:dailyhabitd/core/constent/app_theme.dart';
import 'package:dailyhabitd/core/notification/notification_service.dart';
import 'package:dailyhabitd/feature/habit/domain/entities/habit_entity.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/widget/custom_icons.dart';
import '../../../../core/widget/defult_text.dart';

class EditHabit extends StatefulWidget {
  static const routeName = 'edit';
  const EditHabit({super.key});

  @override
  State<EditHabit> createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  TimeOfDay? pickedTime;
  late HabitEntity habit;
  String? selectedIcon;
  bool selectedNot = false;
  final TextEditingController _nameHabit = TextEditingController();
  final TextEditingController _goalHabit = TextEditingController();
  final TextEditingController _reminderTime = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    habit = ModalRoute.of(context)!.settings.arguments as HabitEntity;
    _nameHabit.text = habit.nameHabit;
    _goalHabit.text = habit.goalHabitBerDay;
    selectedIcon = habit.nameImage;
  }

  @override
  void dispose() {
    _nameHabit.dispose();
    _goalHabit.dispose();
    _reminderTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.HabitGradient,
      ),
      child: BlocConsumer<HabitCubit, HabitState>(
        listener: (context, state) {
          if (state is UpdatHabitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("حدث خطأ: ${state.message}")),
            );
          } else if (state is UpdatHabitLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم تعديل العادة بنجاح ✅")),
            );
            Navigator.of(context).pop(); // يرجع للشاشة السابقة بعد التحديث
          }
        },
        builder: (context, state) {
          if (state is UpdatHabitLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // الحالة الأساسية (عرض واجهة التعديل)
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.editHabit,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DefultText(
                      hint: AppLocalizations.of(context)!.enterName,
                      controller: _nameHabit,
                    ),
                    const SizedBox(height: 30),
                    DefultText(
                      hint: AppLocalizations.of(context)!.enterGoal,
                      controller: _goalHabit,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _reminderTime,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Select Reminder Time',
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
                    ),
                    const SizedBox(height: 30),
                    CustomIcons(
                      onIconSelected: (iconName) {
                        setState(() {
                          selectedIcon = iconName;
                        });
                      },
                      // يفضل تمرير الأيقونة الحالية لو حابب تظللها مثلاً
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.enableNotifications,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<HabitCubit>().updateHabit(
                                  HabitEntity(
                                    id: habit.id,
                                    nameHabit: _nameHabit.text,
                                    goalHabitBerDay: _goalHabit.text,
                                    nameImage: selectedIcon!,
                                  ),
                                );
                            if (selectedNot == true) {
                              NotificationService
                                  .showDailyScheduledNotification(
                                      id: int.parse(habit.id),
                                      hour: pickedTime!.hour,
                                      minute: pickedTime!.minute,
                                      title: _nameHabit.text,
                                      body: "Habit Is Now");
                            }
                            NotificationService.showBasicNotification(
                                title: _nameHabit.text, body: 'Is Edit');
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 240.w,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                              gradient: AppTheme.buttonGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.saveEditHabit,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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
}
