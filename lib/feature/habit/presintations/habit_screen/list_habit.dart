import 'package:dailyhabitd/feature/achievements/domain/entity/ahievement_entity.dart';
import 'package:dailyhabitd/feature/achievements/presintations/cubit/achivement_cubit.dart';
import 'package:dailyhabitd/feature/habit/domain/entities/habit_entity.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_state.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/details_habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // ✅ أضفنا الترجمة
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/constent/app_theme.dart';
import '../../../achievements/presintations/cubit/achivement_state.dart';

class ListHabit extends StatefulWidget {
  const ListHabit({super.key, required this.index, required this.habitEntity});

  final int index;
  final HabitEntity habitEntity;

  @override
  State<ListHabit> createState() => _ListHabitState();
}

class _ListHabitState extends State<ListHabit> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!; // ✅ للوصول إلى النصوص المترجمة
    DateTime now = DateTime.now();

    if (widget.habitEntity.lastUpdat == null ||
        widget.habitEntity.lastUpdat!.day != now.day ||
        widget.habitEntity.lastUpdat!.month != now.month ||
        widget.habitEntity.lastUpdat!.year != now.year) {
      final resetHabit = widget.habitEntity.copyWith(
        counter: 0,
        percent: 0,
        lastUpdat: now,
      );
      context.read<HabitCubit>().updateHabit(resetHabit);
    }

    final pre = calculateMonthlyAttendance(
      int.parse(widget.habitEntity.goalHabitBerDay),
      widget.habitEntity.counter,
    );

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: widget.index.isEven
            ? AppTheme.HabitGradient
            : AppTheme.HabitGradient2,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: widget.habitEntity.nameImage.isNotEmpty
              ? Image.asset('assets/images/${widget.habitEntity.nameImage}.png')
              : const Icon(Icons.water_drop),
          title: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                DetailsHabit.routeName,
                arguments: widget.habitEntity,
              );
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.habitEntity.nameHabit,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 20),
                CircularPercentIndicator(
                  animation: true,
                  radius: 22.0,
                  lineWidth: 2.0,
                  percent: pre / 100,
                  center: Text(
                    "${pre.toStringAsFixed(1)}%",
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                const SizedBox(width: 20),
                Text(
                  '${widget.habitEntity.counter}/${widget.habitEntity.goalHabitBerDay}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          trailing: widget.habitEntity.counter >=
                  int.parse(widget.habitEntity.goalHabitBerDay)
              ? Icon(
                  Icons.done,
                  size: 30,
                  color: AppTheme.primaryMint,
                )
              : BlocListener<HabitCubit, HabitState>(
                  listener: (context, state) {
                    if (state is UpdatHabitError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "${local.errorOccured}: ${state.message}")), // ✅
                      );
                    }
                  },
                  child: BlocListener<AchievementCubit, AchievementState>(
                    listener: (context, state) {
                      if (state is AddAchievementLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(local.newAchievement), // ✅
                          ),
                        );
                      } else if (state is AddAchievementError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(local.errorAddingAchievement), // ✅
                          ),
                        );
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        final updatedHabit = context
                            .read<HabitCubit>()
                            .updateHabitForToday(widget.habitEntity, pre);

                        context.read<HabitCubit>().updateHabit(updatedHabit);

                        if (updatedHabit.counter >=
                            int.parse(widget.habitEntity.goalHabitBerDay)) {
                          context.read<AchievementCubit>().addAchievement(
                                AchievementEntity(
                                  habitId: widget.habitEntity.id,
                                  iconName: widget.habitEntity.nameImage,
                                  id: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  habitName: widget.habitEntity.nameHabit,
                                  completedAt: DateTime.now(),
                                ),
                              );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: AppTheme.mainGradient,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  double calculateMonthlyAttendance(int time, int counter) {
    int totalMeetings = time;
    if (totalMeetings == 0 && counter > time) return 0;
    double ratio = counter / totalMeetings;
    if (ratio > 1.0) ratio = 1.0;
    return ratio * 100;
  }
}
