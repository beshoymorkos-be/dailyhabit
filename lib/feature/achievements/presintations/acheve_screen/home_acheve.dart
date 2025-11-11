import 'package:dailyhabitd/feature/achievements/presintations/cubit/achivement_cubit.dart';
import 'package:dailyhabitd/feature/achievements/presintations/cubit/achivement_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/constent/app_theme.dart';
import '../../../habit/presintations/cubit/habit_cubit.dart';
import '../../../habit/presintations/cubit/habit_state.dart';

class HomeAcheve extends StatefulWidget {
  @override
  State<HomeAcheve> createState() => _HomeAcheveState();
}

class _HomeAcheveState extends State<HomeAcheve> {
  @override
  void initState() {
    context.read<AchievementCubit>().getMonthlyAchievements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalHabits = context.read<HabitCubit>().state is HabitLoaded
        ? (context.read<HabitCubit>().state as HabitLoaded).habits.length
        : 0;

    return BlocBuilder<AchievementCubit, AchievementState>(
      builder: (context, state) {
        if (state is AchievementLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AchievementError) {
          return Center(child: Text(state.message));
        } else if (state is AchievementLoaded) {
          final achievements = state.achievements;

          final now = DateTime.now();
          final totalDays = DateUtils.getDaysInMonth(now.year, now.month);
          final expectedAchievements = totalHabits * totalDays;
          final completionRate = expectedAchievements == 0
              ? 0
              : (achievements.length / expectedAchievements) * 100;
          final level =
              getLevel(context, achievements.length, totalDays, totalHabits);

          return Scaffold(
            backgroundColor: AppTheme.backgroundLight,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.achievements,
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: AppTheme.mainGradient,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    height: 240.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.achievementsOverview,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.surfaceCard,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.habitsCompleted,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.surfaceCard),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${achievements.length} ',
                                  style: const TextStyle(
                                    color: AppTheme.surfaceCard,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Container(
                              width: 2,
                              color: AppTheme.surfaceCard,
                              height: 100,
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.level,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppTheme.surfaceCard),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        level,
                                        style: const TextStyle(
                                          color: AppTheme.surfaceCard,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${completionRate.toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                      color: AppTheme.surfaceCard,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.habitsAccomplished,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: achievements.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/${achievements[index].iconName}.png',
                          ),
                          trailing: const Icon(
                            Icons.done,
                            color: AppTheme.primaryMint,
                            size: 30,
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  achievements[index].habitName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(achievements[index].completedAt),
                              ),
                            ],
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
          return const SizedBox();
        }
      },
    );
  }

  /// ✅ تحديد المستوى بناءً على عدد الإنجازات
  String getLevel(BuildContext context, int count, int day, int numHabit) {
    if (count < day * numHabit * 0.25)
      return AppLocalizations.of(context)!.beginner;
    if (count < day * numHabit * 0.50)
      return AppLocalizations.of(context)!.consistent;
    if (count < day * numHabit * 0.75) return AppLocalizations.of(context)!.pro;
    return AppLocalizations.of(context)!.legend;
  }
}
