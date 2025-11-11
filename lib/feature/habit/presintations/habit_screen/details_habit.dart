import 'package:dailyhabitd/core/notification/notification_service.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_state.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/edit_habit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constent/app_theme.dart';
import '../../../achievements/presintations/cubit/achivement_cubit.dart';
import '../../../achievements/presintations/cubit/achivement_state.dart';
import '../../domain/entities/habit_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsHabit extends StatefulWidget {
  static const routeName = 'detail';
  const DetailsHabit({
    super.key,
  });

  @override
  State<DetailsHabit> createState() => _DetailsHabitState();
}

class _DetailsHabitState extends State<DetailsHabit> {
  @override
  void initState() {
    context.read<AchievementCubit>().getMonthlyAchievements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final habit = ModalRoute.of(context)?.settings.arguments;
    if (habit == null || habit is! HabitEntity) {
      return const Scaffold(
        body: Center(child: Text("No habit data received.")),
      );
    }
    final now = DateTime.now();
    final startDate = habit.createdAt;
    final daysPassed = now.difference(startDate).inDays;
    final totalTimesThisCycle = (daysPassed % 30) + 1;
    final local = AppLocalizations.of(context)!;
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final List<double> weeklyProgress = calculateWeeklyProgress(habit);

    return Container(
      decoration: BoxDecoration(gradient: AppTheme.HabitGradient),
      child: BlocBuilder<AchievementCubit, AchievementState>(
          builder: (context, state) {
        if (state is AchievementLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AchievementError) {
          return const Center(
            child: Text(' Faild in the Achieve'),
          );
        } else if (state is AchievementLoaded) {
          final achievementsForHabit = state.achievements
              .where((a) => (a.habitId ?? '') == (habit.id ?? ''))
              .toList();
          final pre = achievementsForHabit.length / totalTimesThisCycle * 100;
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                'Meditate',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 280,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.weeklyProgress,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200.h,
                          child: BarChart(
                            BarChartData(
                              maxY: 100,
                              gridData: FlGridData(
                                  show: true, horizontalInterval: 20),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 50,
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
                                      final index = value.toInt();
                                      if (index < 0 || index >= days.length) {
                                        return const SizedBox.shrink();
                                      }
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(days[index]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              barGroups: List.generate(
                                  weeklyProgress.length,
                                  (index) => BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: weeklyProgress[index],
                                            width: 20,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.blue,
                                                Colors.teal
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ],
                                      )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]),
                        child: Column(
                          children: [
                            Text(
                              local.currentStreak,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              '${achievementsForHabit.length}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]),
                        child: Column(
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              local.successRate,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              '${pre.toStringAsFixed(2)} %',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]),
                        child: Column(
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              local.totalTimes,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              '$totalTimesThisCycle ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EditHabit.routeName, arguments: habit);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 200.w,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      decoration: const BoxDecoration(
                        gradient: AppTheme.buttonGradient,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Center(
                        child: Text(
                          local.editHabit,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocListener<HabitCubit, HabitState>(
                    listener: (context, state) {
                      if (state is DeleteHabitLoaded) {
                        context.read<HabitCubit>().gitHabits();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(local.itemDeleted)),
                        );
                        Navigator.of(context).pop(true);
                      } else if (state is DeletHabitError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${local.errorOccured} ${state.message}")));
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        context.read<HabitCubit>().deleteHabit(habit.id);
                        NotificationService.cancel(int.parse(habit.id));
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 200.w,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Center(
                          child: Text(
                            local.removeHabit,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }

  List<double> calculateWeeklyProgress(HabitEntity habit) {
    final goal = int.tryParse(habit.goalHabitBerDay) ?? 1;

    List<int> updates = habit.updatCount ?? List<int>.filled(7, 0);
    if (updates.length < 7) {
      updates = List<int>.filled(7, 0);
    }

    return updates.map((count) {
      return ((count / goal) * 100).clamp(0, 100).toDouble();
    }).toList();
  }
}
