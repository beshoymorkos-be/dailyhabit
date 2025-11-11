import 'package:dailyhabitd/feature/habit/domain/use_case/add_habit_use_case.dart';
import 'package:dailyhabitd/feature/habit/domain/use_case/delete_habit_use_case.dart';
import 'package:dailyhabitd/feature/habit/domain/use_case/get_habits_use_case.dart';
import 'package:dailyhabitd/feature/habit/domain/use_case/updat_habit_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/habit_entity.dart';
import 'habit_state.dart';

@singleton
class HabitCubit extends Cubit<HabitState> {
  final GetHabitsUseCase _getHabitsUseCase;
  final AddHabitUseCase _addHabitUseCase;
  final UpdatHabitUseCase _updatHabitUseCase;
  final DeleteHabitUseCase _deleteHabitUseCase;
  HabitCubit(this._getHabitsUseCase, this._addHabitUseCase,
      this._updatHabitUseCase, this._deleteHabitUseCase)
      : super(HabitInitial());

  Future<void> gitHabits() async {
    emit(HabitLoading());
    try {
      final habs = await _getHabitsUseCase();
      emit(HabitLoaded(habs));
    } catch (e) {
      emit(HabitError('Failed to load habits: ${e.toString()}'));
    }
  }

  Future<void> addHabit(HabitEntity habitEntity) async {
    emit(AddHabitLoading());
    try {
      await _addHabitUseCase(habitEntity);
      emit(AddHabitLoaded());
    } catch (e) {
      emit(AddHabitError(e.toString()));
    }
  }

  Future<void> updateHabit(HabitEntity habitEntity) async {
    emit(UpdatHabitLoading());
    try {
      await _updatHabitUseCase(habitEntity);
      emit(UpdatHabitLoaded());
      gitHabits();
    } catch (e) {
      emit(UpdatHabitError(e.toString()));
    }
  }

  Future<void> deleteHabit(String id) async {
    emit(DeleteHabitLoading());
    try {
      await _deleteHabitUseCase(id);
      emit(DeleteHabitLoaded());
    } catch (e) {
      emit(DeletHabitError(e.toString()));
    }
  }

  HabitEntity updateHabitForToday(HabitEntity habit, double pre) {
    final now = DateTime.now();

    // آخر مرة تم فيها تصفير الأسبوع
    final lastReset = habit.lastResetWeek ?? habit.createdAt;
    final daysPassed = now.difference(lastReset).inDays;

    // جهز قائمة التحديث اليومية
    List<int> updatedCount = habit.updatCount ?? List<int>.filled(7, 0);

    // لو بدأ أسبوع جديد، نعمل reset
    DateTime? newLastResetWeek = habit.lastResetWeek;
    if (daysPassed >= 7) {
      updatedCount = List<int>.filled(7, 0);
      newLastResetWeek = now; // تحديث آخر تصفير
    }

    // نزود اليوم الحالي
    final todayIndex = now.weekday - 1;
    updatedCount[todayIndex] += 1;

    // نعمل نسخة جديدة من HabitEntity مع كل التحديثات
    final updatedHabit = habit.copyWith(
      percent: pre,
      updatCount: updatedCount,
      lastUpdat: now,
      lastResetWeek: newLastResetWeek,
      counter: habit.counter + 1,
    );

    return updatedHabit;
  }

  double calculatePercentage(HabitEntity habit) {
    final goal = int.tryParse(habit.goalHabitBerDay) ?? 1;
    double ratio = habit.counter / goal;
    if (ratio > 1.0) ratio = 1.0;
    return double.parse((ratio * 100).toStringAsFixed(1));
  }
}
