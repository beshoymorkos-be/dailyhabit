

import 'package:injectable/injectable.dart';

import '../entity/ahievement_entity.dart';
import '../repository/achievement_repository.dart';
@lazySingleton
class GetMonthlyAchievementsUseCase {
  final AchievementRepository repository;

  GetMonthlyAchievementsUseCase(this.repository);

  Future<List<AchievementEntity>> call() async {
    final all=await repository.getAllAchievements();
    final now=DateTime.now();
    return all.where((a)=>a.completedAt.year==now.year &&
        a.completedAt.month==now.month).toList();
  }
}
