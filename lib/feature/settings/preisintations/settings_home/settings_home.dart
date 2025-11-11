import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constent/app_theme.dart';
import '../setting_cubit/settihg_cubit.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocBuilder<SettingCubit, Locale>(
      builder: (context, locale) {
        bool darkMode = false;
        bool notifications = true;
        String selectedLanguage = locale.languageCode;

        return Scaffold(
          backgroundColor: AppTheme.backgroundLight,
          appBar: AppBar(
            centerTitle: true,
            title: Text(local.habitAppTitle,
                style: Theme.of(context).textTheme.titleLarge),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.mainGradient,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    local.preferences,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.dark_mode,
                        color: AppTheme.primaryBlue),
                    title: Text(local.darkMode),
                    trailing: Switch(
                      value: darkMode,
                      onChanged: (val) {
                        darkMode = val;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.language, color: AppTheme.primaryBlue),
                    title: Text(local.changeLanguage),
                    trailing: DropdownButton<String>(
                      value: selectedLanguage,
                      underline: const SizedBox(),
                      items: [
                        DropdownMenuItem(
                            value: 'en', child: Text(local.english)),
                        DropdownMenuItem(
                            value: 'ar', child: Text(local.arabic)),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          context.read<SettingCubit>().changeLanguage(val);
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔔 الإشعارات
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications,
                        color: AppTheme.primaryBlue),
                    title: Text(local.manageNotifications), // ✅ مترجم
                    trailing: Switch(
                      value: notifications,
                      onChanged: (val) {
                        // ممكن تضيف cubit خاص بالإشعارات لاحقًا
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // 🗑 زر الحذف
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppTheme.mainGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton.icon(
                    onPressed: () => _showDeleteDialog(context),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      local.deleteAllData, // ✅ مترجم
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final local = AppLocalizations.of(context)!; // ✅ نستخدمها هنا برضو

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            local.confirmDelete, // ✅ "هل تريد الحذف؟"
            textAlign: TextAlign.center,
          ),
          content: Text(
            local.permanentDelete, // ✅ "سيتم حذف العنصر نهائيًا."
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(local.itemDeleted)), // ✅ مترجم
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(local.delete), // ✅ "حذف"
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
              ),
              child: Text(local.cancel), // ✅ "إلغاء"
            ),
          ],
        );
      },
    );
  }
}
