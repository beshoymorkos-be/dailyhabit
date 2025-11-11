import 'package:dailyhabitd/feature/habit/data/data_source/local_data_source/habit_local_data_source.dart';
import 'package:dailyhabitd/feature/habit/data/models/habit_model.dart';
import 'package:dailyhabitd/feature/habit/domain/entities/habit_entity.dart';
import 'package:dailyhabitd/feature/habit/domain/repository/habit_repository.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as:HabitRepository )
class HabitRepositoryImpl implements HabitRepository{
  final HabitLocalDataSource _dataSource;

  HabitRepositoryImpl(this._dataSource);
  @override
  Future<void> addHabit(HabitEntity habit) async{
   try{
     final model=HabitModel.fromEntity(habit);
     return _dataSource.add(model);

   }catch(e){
throw e.toString();
   }
  }

  @override
  Future<void> deleteHabit(String id) {
    try{
      return _dataSource.delete(id);

    }catch(e){
throw e.toString();
    }
  }

  @override
  Future<List<HabitEntity>> getAllHabits() async{
    try{
      final model =await _dataSource.getAll();
      return model.map((e)=>e.toEntity()).toList();

    }catch(e){
      throw e.toString();

    }
  }

  @override
  Future<void> updateHabit(HabitEntity habit) {
    try{
      final model = HabitModel.fromEntity(habit);
      return _dataSource.update(model);

    }catch(e){
      throw e.toString();

    }
  }

}