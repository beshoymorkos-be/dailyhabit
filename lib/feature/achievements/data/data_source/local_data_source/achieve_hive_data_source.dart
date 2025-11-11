import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../models/achievement_model.dart';
import 'achieve_data_source.dart';
@LazySingleton(as:AchievementLocalDataSource )
class AchievementLocalDataSourceImpl implements AchievementLocalDataSource {
  final Box<AchievementModel> box;

  AchievementLocalDataSourceImpl(this.box);

  @override
  Future<void> addAchievement(AchievementModel achievement) async {
    try {
      await box.put(achievement.id,achievement  );
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Future<List<AchievementModel>> getAllAchievements() async {
    try {
      return box.values.toList();
    }catch(e){
      throw e.toString();
    }
  }
}