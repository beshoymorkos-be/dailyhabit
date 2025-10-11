import 'package:dailyhabitd/feature/habit/presintations/habit_screen/add_habit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constent/app_theme.dart';
import 'list_habit.dart';

class HabitScreen extends StatelessWidget {
  static const routeName='habitScreen';
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(

        title: Text('Today',style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30)
            )
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(

                itemBuilder:(context, index) => ListHabit(index: index,),
              itemCount: 5,
              ),
          )
        ],
      ),
      floatingActionButton:Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.mainGradient,
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
        child: FloatingActionButton(
          onPressed:(){
            Navigator.of(context).pushNamed(AddHabit.routeName);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(

              borderRadius: const BorderRadius.all(Radius.circular(100))),
        ),
      ),
    );
  }
}
