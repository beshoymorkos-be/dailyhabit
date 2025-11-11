import 'package:hive/hive.dart';

import '../../domain/entity/ahievement_entity.dart';

part 'achievement_model.g.dart';

@HiveType(typeId: 2)
class AchievementModel extends AchievementEntity with HiveObjectMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String habitName;

  @HiveField(2)
  final DateTime completedAt;

  @HiveField(3)
  final String? iconName;
  @HiveField(4)
  final String habitId;

  AchievementModel({
    required this.habitId,
    required this.id,
    required this.habitName,
    required this.completedAt,
    this.iconName,
  }) : super(
    habitId:habitId ,
    id: id,
    habitName: habitName,
    completedAt: completedAt,
    iconName: iconName,
  );

  factory AchievementModel.fromEntity(AchievementEntity entity) {
    return AchievementModel(
      habitId: entity.habitId,
      id: entity.id,
      habitName: entity.habitName,
      completedAt: entity.completedAt,
      iconName: entity.iconName,
    );
  }

  AchievementEntity toEntity() => AchievementEntity(
    habitId: habitId,
    id: id,
    habitName: habitName,
    completedAt: completedAt,
    iconName: iconName,
  );
}
