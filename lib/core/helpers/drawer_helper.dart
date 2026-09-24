import 'package:material_ui/material_ui.dart';

abstract final class RootScaffold() {
  static void openDrawer(BuildContext context) {
    final scaffoldState = context.findRootAncestorStateOfType<ScaffoldState>();
    scaffoldState?.openDrawer();
  }

  static void openEndDrawer(BuildContext context) {
    final scaffoldState = context.findRootAncestorStateOfType<ScaffoldState>();
    scaffoldState?.openEndDrawer();
  }
}
