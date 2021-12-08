import 'package:enter_training_me/translations/de.dart';
import 'package:enter_training_me/translations/en.dart';
import 'package:enter_training_me/translations/fr.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnglishTranslations.translations,
        'fr_FR': FrenchTranslations.translations,
        'de_DE': GermanTranslations.translations, 
      };
}
