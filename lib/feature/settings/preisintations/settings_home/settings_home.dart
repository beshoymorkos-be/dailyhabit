import 'package:flutter/material.dart';

import '../../../../core/constent/app_theme.dart';

class SettingsHome extends StatefulWidget {
  const SettingsHome({super.key});

  @override
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  bool darkMode = false;
  bool notifications = true;
  String selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Habit App',
            style: Theme.of(context).textTheme.titleLarge),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: AppTheme.mainGradient,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
              )
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height:80),
          const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Preferences",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),

        // Dark Mode
          Card(
          child: ListTile(
            leading: const Icon(Icons.dark_mode, color:  AppTheme.primaryBlue),
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: darkMode,
              onChanged: (val) {
                setState(() => darkMode = val);
              },
            ),
          ),
        ),

            const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.language, color: AppTheme.primaryBlue),
            title: const Text("Change Language"),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                DropdownMenuItem(value: 'fr', child: Text('French')),
              ],
              onChanged: (val) {
                setState(() => selectedLanguage = val!);
              },
            ),
          ),
        ),

            const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading:
            const Icon(Icons.notifications, color:  AppTheme.primaryBlue),
            title: const Text("Manage Notifications"),
            trailing: Switch(
              value: notifications,
              onChanged: (val) {
                setState(() => notifications = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 60),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient:AppTheme.mainGradient,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton.icon(
            onPressed: () =>
            _showDeleteDialog(context),
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text(
              "Delete All Data",
              style: TextStyle(color: Colors.white),
            ),
          ),
          )

          ],
        ),
      ),
    );
  }
  void _showDeleteDialog(BuildContext context){
    showDialog(context: context,
        builder:(BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Do you want to delete?',textAlign: TextAlign.center),
        content: const Text('The item will be permanently deleted.',textAlign: TextAlign.center,),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () {

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("The item has been deleted ✅")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Delet"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400],
            ),
            child: const Text("Cansel"),
          ),

        ],
      );
        }
        );
  }
}
