class AchievementEntity {
  final String habitId;
  final String id;
  final String habitName;
  final DateTime completedAt;
  final String? iconName;

  AchievementEntity({
    required this.habitId,
    required this.id,
    required this.habitName,
    required this.completedAt,
    this.iconName,
  });
}
