import 'package:flutter/rendering.dart';

enum LanguageType { ENGLISH, ARABIC }

const String ARABIC = "ar";
const String ENGLISH = "en";

const Locale ARABIC_LOCAL = Locale("ar","EG");
const Locale ENGLISH_LOCAL = Locale("en","US");

const String LOCALISATIONS_PATH = "assets/translations";


extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}