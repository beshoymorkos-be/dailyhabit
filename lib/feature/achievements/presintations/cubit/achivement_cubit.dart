  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:injectable/injectable.dart';
  import '../../domain/entity/ahievement_entity.dart';
  import '../../domain/use_case/add_achievement_usecase.dart';
  import '../../domain/use_case/get_monthly_achievements_use_case.dart';
  import 'achivement_state.dart';

  @singleton
  class AchievementCubit extends Cubit<AchievementState> {
    final AddAchievementUseCase addAchievementUseCase;
    final GetMonthlyAchievementsUseCase getMonthlyAchievementsUseCase;

    AchievementCubit(this.addAchievementUseCase, this.getMonthlyAchievementsUseCase)
        : super(AchievementInitial());

    Future<void> addAchievement(AchievementEntity achievement) async {
      try {
        await addAchievementUseCase(achievement);
        emit(AddAchievementLoaded());
        getMonthlyAchievements();

      } catch (e) {
        emit(AddAchievementError(e.toString()));
      }
    }

    Future<void> getMonthlyAchievements() async {
      emit(AchievementLoading());
      try {
        final achievements = await getMonthlyAchievementsUseCase();
        emit(AchievementLoaded(achievements));
      } catch (e) {
        emit(AchievementError(e.toString()));
      }
    }
  }
