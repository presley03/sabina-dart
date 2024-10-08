import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('id');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!['en', 'id'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }
}