import 'package:dailyhabitd/core/constent/app_theme.dart';
import 'package:dailyhabitd/core/widget/home_screen.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/add_habit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/details_habit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/edit_habit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/habit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
          return
            MaterialApp(
              theme: AppTheme.themeWhite,
              debugShowCheckedModeBanner: false,
              routes: {
                HabitScreen.routeName: (context) => HabitScreen(),
                AddHabit.routeName:(context)=>AddHabit(),
                EditHabit.routeName:(context)=>EditHabit(),
                DetailsHabit.routeName:(context)=>DetailsHabit(),
                HomeScreen.routeName:(context)=>HomeScreen()
              },
            );
        }
    );
  }
}
