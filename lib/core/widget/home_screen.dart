import 'package:dailyhabitd/feature/achievements/presintations/acheve_screen/home_acheve.dart';
import 'package:dailyhabitd/feature/habit/presintations/habit_screen/habit_screen.dart';
import 'package:dailyhabitd/feature/settings/preisintations/settings_home/settings_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constent/app_theme.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [HabitScreen(), HomeAcheve(), SettingsHome()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: AppTheme.mainGradient,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: AppLocalizations.of(context)!.home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.workspace_premium),
                  label: AppLocalizations.of(context)!.achievements),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: AppLocalizations.of(context)!.setting),
            ]),
      ),
    );
  }
}
