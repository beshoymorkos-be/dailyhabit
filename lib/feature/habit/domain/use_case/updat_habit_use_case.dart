import 'package:dailyhabitd/feature/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/habit_entity.dart';

@lazySingleton
class UpdatHabitUseCase {
  final HabitRepository _repository;

  UpdatHabitUseCase(this._repository);
  Future<void> call(HabitEntity habit) => _repository.updateHabit(habit);
}
