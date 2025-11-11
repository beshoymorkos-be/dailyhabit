
import 'package:injectable/injectable.dart';

import '../entity/ahievement_entity.dart';
import '../repository/achievement_repository.dart';
@lazySingleton
class AddAchievementUseCase {
  final AchievementRepository repository;

  AddAchievementUseCase(this.repository);

  Future<void> call(AchievementEntity achievement) async {
    return await repository.addAchievement(achievement);
  }
}
