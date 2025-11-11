
import '../../domain/entities/habit_entity.dart';

abstract class HabitState {}

class HabitInitial extends HabitState {}

class HabitLoading extends HabitState {}

class HabitLoaded extends HabitState {
  final List<HabitEntity> habits;
  HabitLoaded(this.habits);
}

class HabitError extends HabitState {
  final String message;
  HabitError(this.message);
}


class AddHabitLoading extends HabitState {}
class DeleteHabitLoading extends HabitState {}
class DeleteHabitLoaded extends HabitState {}
class DeletHabitError extends HabitState {
  final String message;
  DeletHabitError(this.message);
}

class AddHabitLoaded extends HabitState {

}

class AddHabitError extends HabitState {
  final String message;
  AddHabitError(this.message);
}


class UpdatHabitLoading extends HabitState {}

class UpdatHabitLoaded extends HabitState {

}

class UpdatHabitError extends HabitState {
  final String message;
  UpdatHabitError(this.message);
}

