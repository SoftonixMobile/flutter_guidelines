import '../translations.g.dart';

extension AppLocaleX on AppLocale {
  String getNativeName(Translations tr) {
    final common = tr.common;

    return switch (this) {
      .en => common.language.english,
      .fr => common.language.french,
    };
  }
}
