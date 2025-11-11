
import '../entity/ahievement_entity.dart';

abstract class AchievementRepository {
  Future<void> addAchievement(AchievementEntity achievement);
  Future<List<AchievementEntity>> getAllAchievements();
}
