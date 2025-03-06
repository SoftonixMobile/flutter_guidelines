import 'dart:io';

import 'package:flutter/cupertino.dart' hide CupertinoAlertDialog;
import 'package:flutter/material.dart';

import 'package:upgrader/upgrader.dart';

import 'app_upgrade_alert.dart';

/// Dialog that prompts the user to update the app
///  when a new version is available.
class AppUpgraderDialog extends StatelessWidget {
  const AppUpgraderDialog({super.key, required this.navigatorKey, this.child});

  final GlobalKey<NavigatorState> navigatorKey;

  final Widget? child;

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
        dialogStyle:
            Platform.isIOS
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
class DPUpgraderMessages extends UpgraderMessages {
  @override
  String get buttonTitleLater => 'Later';

  @override
  String get buttonTitleUpdate => 'Update';

  @override
  String get body => 'A new version of {{appName}} is available!';
}
