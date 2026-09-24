import 'dart:io';

import 'package:cupertino_ui/cupertino_ui.dart' hide CupertinoAlertDialog;
import 'package:material_ui/material_ui.dart';
import 'package:upgrader/upgrader.dart';

import 'app_upgrade_alert.dart';

/// Dialog that prompts the user to update the app
///  when a new version is available.
class const AppUpgraderDialog({
  super.key,
  required final GlobalKey<NavigatorState> navigatorKey,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButtonTheme(
      // Making the Material dialog use the same colors
      //  as Cupertino for consistency
      data: TextButtonThemeData(
        style: theme.textButtonTheme.style?.copyWith(
          foregroundColor: const WidgetStatePropertyAll(
            CupertinoColors.systemBlue,
          ),
        ),
      ),
      child: AppUpgradeAlert(
        navigatorKey: navigatorKey,
        dialogStyle: Platform.isIOS ? .cupertino : .material,
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
  String get body => 'A new version of {{appName}} is available!';
}
