import 'package:dailyhabitd/core/constent/app_theme.dart';
import 'package:dailyhabitd/core/widget/home_screen.dart';
import 'package:dailyhabitd/feature/achievements/presintations/cubit/achivement_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/cubit/habit_cubit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/add_habit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/details_habit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/edit_habit.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/habit_screen.dart';
import 'package:dailyhabitd/feature/settings/preisintations/setting_cubit/settihg_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/service_locator.dart';
import 'feature/achievements/data/models/achievement_model.dart';
import 'feature/habit/data/models/habit_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitModelAdapter());
  Hive.registerAdapter(AchievementModelAdapter());
  final habitBox = await Hive.openBox<HabitModel>('habitBox');
  final achieveBox = await Hive.openBox<AchievementModel>('achievements');
  await Hive.openBox('settings');

  serviceLocator.registerSingleton<Box<HabitModel>>(habitBox);
  serviceLocator.registerSingleton<Box<AchievementModel>>(achieveBox);

  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator.get<HabitCubit>()),
        BlocProvider(
            create: (context) => serviceLocator.get<AchievementCubit>()),
        BlocProvider(create: (context) => SettingCubit()), // ← Cubit اللغة
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<SettingCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.themeWhite,
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                routes: {
                  HabitScreen.routeName: (context) => const HabitScreen(),
                  AddHabit.routeName: (context) => const AddHabit(),
                  EditHabit.routeName: (context) => const EditHabit(),
                  DetailsHabit.routeName: (context) => const DetailsHabit(),
                  HomeScreen.routeName: (context) => const HomeScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
