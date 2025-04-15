// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
// ignore_for_file: prefer_single_quotes
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart' show AssetLoader;
class CodegenLoader extends AssetLoader{
  const CodegenLoader();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }
  static const Map<String,dynamic> frFR = {
  "changePassword": "Changer le mot de passe",
  "chats": "Chats",
  "chatsScreenTitle": "@:chats @:screenText",
  "dashboard": "Tableau de bord",
  "dashboardScreenTitle": "@:dashboard @:screenText",
  "languageName": "French",
  "messages": "Messages",
  "posts": "Des postes",
  "postsScreenTitle": "@:posts @:screenText",
  "screenText": "Filtrer",
  "settings": "Réglages",
  "settingsScreenTitle": "@:settings @:screenText",
  "signOut": "Se déconnecter"
};
static const Map<String,dynamic> enUS = {
  "changePassword": "Change Password",
  "chats": "Chats",
  "chatsScreenTitle": "@:chats @:screenText",
  "dashboard": "Dashboard",
  "dashboardScreenTitle": "@:dashboard @:screenText",
  "languageName": "English",
  "messages": "Messages",
  "posts": "Posts",
  "postsScreenTitle": "@:posts @:screenText",
  "screenText": "Screen",
  "settings": "Settings",
  "settingsScreenTitle": "@:settings @:screenText",
  "signOut": "Sign Out"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"fr_FR": frFR, "en_US": enUS};
static const List<Locale> supportedLocales = [Locale("fr", "FR"), Locale("en", "US")];
static const String path = "resources/langs";
}
