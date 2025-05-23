import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:customizable_cupertino_dialog/customizable_cupertino_dialog.dart';
import 'package:upgrader/upgrader.dart';

class AppUpgradeAlert extends UpgradeAlert {
  AppUpgradeAlert({
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
    this.cupertinoDialogColor =
        CustomizableCupertinoAlertDialog.opaqueCupertinoDialogColor,
    super.child,
  });

  final CupertinoDynamicColor? cupertinoDialogColor;

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
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: cupertino
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              messages.message(UpgraderMessage.releaseNotes) ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
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
          crossAxisAlignment: cupertino
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(messages.message(UpgraderMessage.prompt) ?? ''),
            ),
            if (notes != null) notes,
          ],
        ),
      ),
    );
    final actions = <Widget>[
      if (showIgnore)
        button(
          cupertino: cupertino,
          text: messages.message(UpgraderMessage.buttonTitleIgnore),
          context: context,
          onPressed: () => onUserIgnored(context, true),
        ),
      if (showLater)
        button(
          cupertino: cupertino,
          text: messages.message(UpgraderMessage.buttonTitleLater),
          context: context,
          onPressed: () => onUserLater(context, true),
        ),
      button(
        cupertino: cupertino,
        text: messages.message(UpgraderMessage.buttonTitleUpdate),
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
}
