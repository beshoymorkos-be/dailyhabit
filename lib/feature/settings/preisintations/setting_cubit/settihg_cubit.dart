import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class SettingCubit extends Cubit<Locale> {
  final Box settingsBox = Hive.box('settings');

  SettingCubit() : super(const Locale('en')) {
    final savedLang = settingsBox.get('lang', defaultValue: 'en') as String;
    emit(Locale(savedLang));
  }

  void changeLanguage(String langCode) {
    emit(Locale(langCode));
    settingsBox.put('lang', langCode);
  }
}
