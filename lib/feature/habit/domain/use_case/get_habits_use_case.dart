import 'package:dailyhabitd/feature/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/habit_entity.dart';
@lazySingleton
class GetHabitsUseCase{
  final HabitRepository _repository;

  GetHabitsUseCase(this._repository);
  Future<List<HabitEntity>> call()=>_repository.getAllHabits();

}