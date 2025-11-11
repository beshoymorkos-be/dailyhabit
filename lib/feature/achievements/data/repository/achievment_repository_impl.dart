
import 'package:injectable/injectable.dart';

import '../../domain/entity/ahievement_entity.dart';
import '../../domain/repository/achievement_repository.dart';
import '../data_source/local_data_source/achieve_data_source.dart';
import '../models/achievement_model.dart';
@LazySingleton(as: AchievementRepository)
class AchievementRepositoryImpl implements AchievementRepository {
  final AchievementLocalDataSource localDataSource;

  AchievementRepositoryImpl(this.localDataSource);

  @override
  Future<void> addAchievement(AchievementEntity achievement) async {
    try {
      final model = AchievementModel.fromEntity(achievement);
      await localDataSource.addAchievement(model);
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Future<List<AchievementEntity>> getAllAchievements() async {
    try {
      final models = await localDataSource.getAllAchievements();
      return models.map((m) => m.toEntity()).toList();
    }catch(e){
      throw e.toString();
    }
  }
}
