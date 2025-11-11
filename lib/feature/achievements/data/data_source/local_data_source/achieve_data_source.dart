import '../../models/achievement_model.dart';

abstract class AchievementLocalDataSource {
  Future<void> addAchievement(AchievementModel achievement);
  Future<List<AchievementModel>> getAllAchievements();
}