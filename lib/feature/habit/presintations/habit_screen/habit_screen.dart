import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_state.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/add_habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constent/app_theme.dart';
import 'list_habit.dart';

class HabitScreen extends StatefulWidget {
  static const routeName = 'habitScreen';
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  void initState() {
    context.read<HabitCubit>().gitHabits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.today,
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<HabitCubit, HabitState>(builder: (context, state) {
              if (state is HabitLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HabitError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is HabitLoaded) {
                final habit = state.habits;
                return ListView.builder(
                  itemBuilder: (context, index) => ListHabit(
                    index: index,
                    habitEntity: habit[index],
                  ),
                  itemCount: habit.length,
                );
              } else {
                return SizedBox();
              }
            }),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: FloatingActionButton(
          onPressed: () {
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
