import 'dart:io';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:upgrader/upgrader.dart';

/// Dialog that prompts the user to update the app
///  when a new version is available.
class const AppUpgraderDialog({
  super.key,
  required final GlobalKey<NavigatorState> navigatorKey,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: const TextButtonThemeData(),
      child: UpgradeAlert(
        navigatorKey: navigatorKey,
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
        cupertinoButtonTextStyle: const TextStyle(
          color: CupertinoColors.systemBlue,
        ),
        showReleaseNotes: false,
        showIgnore: false,
        barrierDismissible: true,
        upgrader: Upgrader(messages: DPUpgraderMessages()),
        child: child,
      ),
    );
  }
}

/// Custom messages
class DPUpgraderMessages() extends UpgraderMessages {
  @override
  String get buttonTitleLater => 'Later';

  @override
  String get buttonTitleUpdate => 'Update';

  @override
  String get body => 'A new version of {{=<% %>=}}{{<%={{ }}=%>appName}} is available!';
}
