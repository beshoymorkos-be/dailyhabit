import 'package:dailyhabitd/core/constent/app_theme.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/list_habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/custom_icons.dart';
import '../../../../core/widget/defult_text.dart';

class EditHabit extends StatefulWidget {
  static const routeName='edit';
  const EditHabit({super.key});

  @override
  State<EditHabit> createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  bool selectedNot=false;
  TextEditingController _nameHabit=TextEditingController();
  TextEditingController _goalHabit=TextEditingController();
  TextEditingController _reminderTime=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.HabitGradient
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text('Edit Habit',style:Theme.of(context).textTheme.titleLarge ,),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(

              children: [
                DefultText(hint: 'Enter The Name Habit',
                  controller: _nameHabit,
                ),
                const SizedBox(height: 30,),
                DefultText(hint: 'Enter The Goal Per Day',
                  controller: _goalHabit,
                ),
                const SizedBox(height: 30,),
                DefultText(hint: 'Enter The Reminder Time',
                  controller: _reminderTime,
                ),
                const SizedBox(height: 30,),
                CustomIcons(),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Enable Notifications',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 18),),
                    Switch(value:selectedNot ,
                        //activeColor: Colors.blue,
                        activeTrackColor: Colors.blue,
                        onChanged: (value){
                          setState(() {
                            selectedNot=value;
                          });
                        })
                  ],
                ),
                const SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap: (){},
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 240.w,
                        padding: const EdgeInsets.symmetric(vertical: 8,),
                        decoration: const BoxDecoration(
                          gradient: AppTheme.buttonGradient,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Center(
                          child: Text(
                            'Save Edit The Habit',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
