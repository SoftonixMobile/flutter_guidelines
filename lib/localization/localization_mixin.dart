import 'package:flutter/material.dart';
import 'package:flutter_guidelines/localization/index.dart';

mixin EasyLocalizationMixin on StatelessWidget {
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return const _NullWidget();
  }
}

mixin EasyLocalizationStateMixin<TState extends StatefulWidget>
    on State<TState> {
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return const _NullWidget();
  }
}

class _NullWidget extends StatelessWidget {
  const _NullWidget();

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'Widgets that mix EasyLocalizationMixin must call super.build() '
      'but must ignore the return value of the superclass.',
    );
  }
}
