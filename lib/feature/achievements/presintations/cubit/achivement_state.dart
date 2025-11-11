

import '../../domain/entity/ahievement_entity.dart';

abstract class AchievementState {}

class AchievementInitial extends AchievementState {}
class AchievementLoading extends AchievementState {}
class AddAchievementLoaded extends AchievementState {}
class AddAchievementLoading extends AchievementState {}
class AchievementLoaded extends AchievementState {
  final List<AchievementEntity> achievements;
  AchievementLoaded(this.achievements);
}
class AchievementError extends AchievementState {
  final String message;
  AchievementError(this.message);
}
class AddAchievementError extends AchievementState {
  final String message;
  AddAchievementError(this.message);
}