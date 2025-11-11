import 'package:dailyhabitd/feature/habit/data/data_source/local_data_source/habit_local_data_source.dart';
import 'package:dailyhabitd/feature/habit/data/models/habit_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: HabitLocalDataSource)
class HabitHiveDataSource implements HabitLocalDataSource{
  final Box<HabitModel> box;

  HabitHiveDataSource(this.box);
  @override
  Future<void> add(HabitModel habit) async{
   try{
   return  await box.put(habit.id, habit);

   }catch(e){
throw e.toString();
   }
  }

  @override
  Future<void> delete(String id) async{
try{
  return await box.delete(id);
}catch(e){
  throw e.toString();
}
  }

  @override
  Future<List<HabitModel>> getAll() async{

    try{
      final values = box.values.cast<HabitModel>();
      return values.toList();
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> update(HabitModel habit)async {
    try{
      return await box.put(habit.id,habit);
    }catch(e){
      throw e.toString();
    }
  }

}