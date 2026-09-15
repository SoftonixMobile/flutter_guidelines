import 'package:flutter/cupertino.dart' hide CupertinoDialogAction;
import 'package:flutter/material.dart';

import 'package:customizable_cupertino_dialog/customizable_cupertino_dialog.dart';
import 'package:upgrader/upgrader.dart';

class AppUpgradeAlert({
  super.key,
  super.upgrader,
  super.barrierDismissible,
  super.dialogStyle,
  super.onIgnore,
  super.onLater,
  super.onUpdate,
  super.shouldPopScope,
  super.showIgnore,
  super.showLater,
  super.showReleaseNotes,
  super.cupertinoButtonTextStyle,
  super.dialogKey,
  super.navigatorKey,
  final CupertinoDynamicColor? cupertinoDialogColor =
      CustomizableCupertinoAlertDialog.opaqueCupertinoDialogColor,
  super.child,
}) extends UpgradeAlert {
  @override
  AppUpgradeAlertState createState() => AppUpgradeAlertState();
}

class AppUpgradeAlertState extends UpgradeAlertState {
  @override
  Widget alertDialog(
    Key? key,
    String title,
    String message,
    String? releaseNotes,
    BuildContext context,
    bool cupertino,
    UpgraderMessages messages,
  ) {
    // If installed version is below minimum app version,
    //  or is a critical update, disable ignore and later buttons.
    final isBlocked = widget.upgrader.blocked();
    final showIgnore = !isBlocked && widget.showIgnore;
    final showLater = !isBlocked && widget.showLater;

    Widget? notes;
    if (releaseNotes != null) {
      notes = Padding(
        padding: const .only(top: 15),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: cupertino ? .center : .start,
          children: <Widget>[
            Text(
              messages.message(.releaseNotes) ?? '',
              style: const TextStyle(fontWeight: .bold),
            ),
            Text(releaseNotes),
          ],
        ),
      );
    }
    final textTitle = Text(title, key: const Key('upgrader.dialog.title'));
    final content = Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: cupertino ? .center : .start,
          mainAxisSize: .min,
          children: <Widget>[
            Text(message),
            Padding(
              padding: const .only(top: 15),
              child: Text(messages.message(.prompt) ?? ''),
            ),
            ?notes,
          ],
        ),
      ),
    );
    final actions = <Widget>[
      if (showIgnore)
        button(
          cupertino: cupertino,
          text: messages.message(.buttonTitleIgnore),
          context: context,
          onPressed: () => onUserIgnored(context, true),
        ),
      if (showLater)
        button(
          cupertino: cupertino,
          text: messages.message(.buttonTitleLater),
          context: context,
          onPressed: () => onUserLater(context, true),
        ),
      button(
        cupertino: cupertino,
        text: messages.message(.buttonTitleUpdate),
        context: context,
        onPressed: () => onUserUpdated(context, !widget.upgrader.blocked()),
        isDefaultAction: true,
      ),
    ];

    final cupertinoDialogColor = switch (widget) {
      AppUpgradeAlert(:final cupertinoDialogColor) => cupertinoDialogColor,
      _ => null,
    };

    return cupertino
        ? CustomizableCupertinoAlertDialog(
            key: key,
            title: textTitle,
            content: content,
            actions: actions,
            dialogColor: cupertinoDialogColor,
          )
        : AlertDialog(
            key: key,
            title: textTitle,
            content: content,
            actions: actions,
          );
  }

  @override
  Widget button({
    required bool cupertino,
    String? text,
    required BuildContext context,
    VoidCallback? onPressed,
    bool isDefaultAction = false,
  }) {
    if (!cupertino) {
      return super.button(
        cupertino: cupertino,
        context: context,
        text: text,
        onPressed: onPressed,
        isDefaultAction: isDefaultAction,
      );
    }

    return CupertinoDialogAction(
      textStyle: widget.cupertinoButtonTextStyle,
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      child: Text(text ?? ''),
    );
  }
}
