// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dailyhabitd/feature/achievements/data/data_source/local_data_source/achieve_data_source.dart'
    as _i577;
import 'package:dailyhabitd/feature/achievements/data/data_source/local_data_source/achieve_hive_data_source.dart'
    as _i793;
import 'package:dailyhabitd/feature/achievements/data/models/achievement_model.dart'
    as _i451;
import 'package:dailyhabitd/feature/achievements/data/repository/achievment_repository_impl.dart'
    as _i215;
import 'package:dailyhabitd/feature/achievements/domain/repository/achievement_repository.dart'
    as _i658;
import 'package:dailyhabitd/feature/achievements/domain/use_case/add_achievement_usecase.dart'
    as _i951;
import 'package:dailyhabitd/feature/achievements/domain/use_case/get_monthly_achievements_use_case.dart'
    as _i190;
import 'package:dailyhabitd/feature/achievements/presintations/cubit/achivement_cubit.dart'
    as _i123;
import 'package:dailyhabitd/feature/habit/data/data_source/local_data_source/habit_hive_data_source.dart'
    as _i311;
import 'package:dailyhabitd/feature/habit/data/data_source/local_data_source/habit_local_data_source.dart'
    as _i1014;
import 'package:dailyhabitd/feature/habit/data/models/habit_model.dart'
    as _i409;
import 'package:dailyhabitd/feature/habit/data/repository/habit_repository_impl.dart'
    as _i959;
import 'package:dailyhabitd/feature/habit/domain/repository/habit_repository.dart'
    as _i632;
import 'package:dailyhabitd/feature/habit/domain/use_case/add_habit_use_case.dart'
    as _i42;
import 'package:dailyhabitd/feature/habit/domain/use_case/delete_habit_use_case.dart'
    as _i677;
import 'package:dailyhabitd/feature/habit/domain/use_case/get_habits_use_case.dart'
    as _i210;
import 'package:dailyhabitd/feature/habit/domain/use_case/updat_habit_use_case.dart'
    as _i311;
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart'
    as _i324;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i1014.HabitLocalDataSource>(
        () => _i311.HabitHiveDataSource(gh<_i979.Box<_i409.HabitModel>>()));
    gh.lazySingleton<_i577.AchievementLocalDataSource>(() =>
        _i793.AchievementLocalDataSourceImpl(
            gh<_i979.Box<_i451.AchievementModel>>()));
    gh.lazySingleton<_i632.HabitRepository>(
        () => _i959.HabitRepositoryImpl(gh<_i1014.HabitLocalDataSource>()));
    gh.lazySingleton<_i658.AchievementRepository>(() =>
        _i215.AchievementRepositoryImpl(
            gh<_i577.AchievementLocalDataSource>()));
    gh.lazySingleton<_i951.AddAchievementUseCase>(
        () => _i951.AddAchievementUseCase(gh<_i658.AchievementRepository>()));
    gh.lazySingleton<_i190.GetMonthlyAchievementsUseCase>(() =>
        _i190.GetMonthlyAchievementsUseCase(gh<_i658.AchievementRepository>()));
    gh.lazySingleton<_i42.AddHabitUseCase>(
        () => _i42.AddHabitUseCase(gh<_i632.HabitRepository>()));
    gh.lazySingleton<_i677.DeleteHabitUseCase>(
        () => _i677.DeleteHabitUseCase(gh<_i632.HabitRepository>()));
    gh.lazySingleton<_i210.GetHabitsUseCase>(
        () => _i210.GetHabitsUseCase(gh<_i632.HabitRepository>()));
    gh.lazySingleton<_i311.UpdatHabitUseCase>(
        () => _i311.UpdatHabitUseCase(gh<_i632.HabitRepository>()));
    gh.singleton<_i123.AchievementCubit>(() => _i123.AchievementCubit(
          gh<_i951.AddAchievementUseCase>(),
          gh<_i190.GetMonthlyAchievementsUseCase>(),
        ));
    gh.singleton<_i324.HabitCubit>(() => _i324.HabitCubit(
          gh<_i210.GetHabitsUseCase>(),
          gh<_i42.AddHabitUseCase>(),
          gh<_i311.UpdatHabitUseCase>(),
          gh<_i677.DeleteHabitUseCase>(),
        ));
    return this;
  }
}
