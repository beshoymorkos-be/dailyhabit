import 'package:hive/hive.dart';
import '../../domain/entities/habit_entity.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel extends HabitEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nameHabit;

  @HiveField(2)
  final String goalHabitBerDay;

  @HiveField(3)
  final bool completed;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final String nameImage;

  @HiveField(6)
  int counter;
  @HiveField(7)
  double percent;

  @HiveField(8)
  DateTime? lastUpdat;

  @HiveField(9)
  List<int> updatCount;
  @HiveField(10)
  DateTime?lastResetWeek;

  HabitModel({
    this.lastResetWeek,
    required this.id,
    required this.nameHabit,
    required this.goalHabitBerDay,
    required this.nameImage,
    this.completed = false,
    this.counter = 0,
    this.percent = 0.0,
    DateTime? createdAt,
    this.lastUpdat,
    List<int>? updatCount,
  })  : updatCount = updatCount ?? List.filled(7, 0),
        createdAt = createdAt ?? DateTime.now(),
        super(
        lastResetWeek: lastResetWeek,
        id: id,
        nameHabit: nameHabit,
        goalHabitBerDay: goalHabitBerDay,
        nameImage: nameImage,
        completed: completed,
        counter: counter,
        percent: percent,
        createdAt: createdAt,
        lastUpdat: lastUpdat,
      );

  // تحويل من Entity إلى Model
  factory HabitModel.fromEntity(HabitEntity e) {
    return HabitModel(
      lastResetWeek: e.lastResetWeek,
      lastUpdat: e.lastUpdat,
      id: e.id,
      nameHabit: e.nameHabit,
      goalHabitBerDay: e.goalHabitBerDay,
      nameImage: e.nameImage,
      completed: e.completed,
      counter: e.counter,
      percent: e.percent,
      createdAt: e.createdAt,
      updatCount: e.updatCount ?? List.filled(7, 0),
    );
  }

  // تحويل من Model إلى Entity
  HabitEntity toEntity() {
    return HabitEntity(
      lastResetWeek: lastResetWeek,
      lastUpdat: lastUpdat,
      id: id,
      nameHabit: nameHabit,
      goalHabitBerDay: goalHabitBerDay,
      nameImage: nameImage,
      completed: completed,
      counter: counter,
      percent: percent,
      createdAt: createdAt,
      updatCount: updatCount,
    );
  }


  HabitModel copyWith({
    DateTime?lastResetWeek,
    DateTime? lastUpdat,
    String? id,
    String? nameHabit,
    String? goalHabitBerDay,
    String? nameImage,
    bool? completed,
    int? counter,
    double? percent,
    DateTime? createdAt,
    List<int>? updatCount,
  }) {
    return HabitModel(
      lastResetWeek: lastResetWeek,
      lastUpdat: lastUpdat ?? this.lastUpdat,
      id: id ?? this.id,
      nameHabit: nameHabit ?? this.nameHabit,
      goalHabitBerDay: goalHabitBerDay ?? this.goalHabitBerDay,
      nameImage: nameImage ?? this.nameImage,
      completed: completed ?? this.completed,
      counter: counter ?? this.counter,
      percent: percent ?? this.percent,
      createdAt: createdAt ?? this.createdAt,
      updatCount: updatCount ?? this.updatCount,
    );
  }
}
