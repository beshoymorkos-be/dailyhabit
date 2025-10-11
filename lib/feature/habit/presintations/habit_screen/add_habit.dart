import 'package:dailyhabitd/core/widget/custom_icons.dart';
import 'package:dailyhabitd/core/widget/defult_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/constent/app_theme.dart';

class AddHabit extends StatefulWidget {
  static const routeName='add';
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  bool selectedNot=false;
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameHabit=TextEditingController();
    TextEditingController _goalHabit=TextEditingController();
    TextEditingController _reminderTime=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Habit',
            style: Theme.of(context).textTheme.titleLarge),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
              )
          ),
        ),
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
          InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width:  double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8,),
              decoration: const BoxDecoration(
                gradient: AppTheme.buttonGradient,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
            ],
          ),
        ),
      ),
    );
  }
}
