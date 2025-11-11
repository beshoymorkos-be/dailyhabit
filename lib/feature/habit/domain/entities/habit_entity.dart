class HabitEntity {
  final String id;
  final String nameHabit;
  final String goalHabitBerDay;
  final bool completed;
  final DateTime createdAt;
  final String nameImage;
 final List<int>? updatCount;
   int counter;
   double percent;
   DateTime ? lastUpdat;
   DateTime ? lastResetWeek;

  HabitEntity({
    this.lastResetWeek,
    this.updatCount,
    this.lastUpdat,
    required this.id,
    required this.nameHabit,
    required this.goalHabitBerDay,
    required this.nameImage,
    this.completed = false,
    this.counter = 0,
    this.percent = 0.0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
  HabitEntity copyWith({
    DateTime?lastResetWeek,
    List<int>?updatCount,
    DateTime? lastUpdat,
    String? id,
    String? nameHabit,
    String? goalHabitBerDay,
    String? nameImage,
    bool? completed,
    int? counter,
    double? percent,
    DateTime? createdAt,
  }) {
    return HabitEntity(
      lastResetWeek: lastResetWeek?? this.lastResetWeek,
      updatCount: updatCount ?? this.updatCount,
      lastUpdat: lastUpdat ?? this.lastUpdat,
      id: id ?? this.id,
      nameHabit: nameHabit ?? this.nameHabit,
      goalHabitBerDay: goalHabitBerDay ?? this.goalHabitBerDay,
      nameImage: nameImage ?? this.nameImage,
      completed: completed ?? this.completed,
      counter: counter ?? this.counter,
      percent: percent ?? this.percent,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
