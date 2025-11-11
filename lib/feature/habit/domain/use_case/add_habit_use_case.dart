import 'package:dailyhabitd/feature/habit/data/models/habit_model.dart';
import 'package:dailyhabitd/feature/habit/domain/entities/habit_entity.dart';
import 'package:dailyhabitd/feature/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AddHabitUseCase{
  final HabitRepository _repository;

  AddHabitUseCase(this._repository);
  Future<void> call(HabitEntity habit)=>_repository.addHabit(habit);

}