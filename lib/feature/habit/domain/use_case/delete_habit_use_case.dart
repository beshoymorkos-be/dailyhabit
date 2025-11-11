import 'package:dailyhabitd/feature/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class DeleteHabitUseCase{
  final HabitRepository _repository;

  DeleteHabitUseCase(this._repository);
  Future<void> call(String id)=>_repository.deleteHabit(id);

}