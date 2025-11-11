
    import '../../models/habit_model.dart';

abstract class HabitLocalDataSource {
  Future<List<HabitModel>> getAll();
  Future<void> add(HabitModel habit);
  Future<void> update(HabitModel habit);
  Future<void> delete(String id);
}