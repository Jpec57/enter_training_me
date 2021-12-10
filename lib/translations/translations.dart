import 'package:enter_training_me/translations/de.dart';
import 'package:enter_training_me/translations/en.dart';
import 'package:enter_training_me/translations/fr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  static const defaultLocale = Locale('en', 'US');
  static const supportedLocales = ['en_US', 'fr_FR', 'de_DE'];

  static Locale getLocaleFromFullLocaleString(String locale) {
    List<String> localeParts = locale.split("_");
    if (localeParts.length != 2) {
      throw Exception(
          "Invalid locale string format. Should be formatted like this : <locale_code>_<country_code> (Ex: 'fr_FR')");
    }
    return Locale(localeParts[0], localeParts[1]);
  }

  static Locale getLocaleFromStrings(String locale, String countryCode) {
    return Locale(locale, countryCode);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnglishTranslations.translations,
        'fr_FR': FrenchTranslations.translations,
        'de_DE': GermanTranslations.translations,
      };
}
