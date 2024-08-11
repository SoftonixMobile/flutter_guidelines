import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';

class TextInputFormBuilder extends StatefulWidget {
  const TextInputFormBuilder({
    super.key,
    this.label = '',
    this.hintText,
    this.isObscureText = false,
    this.fieldFocusNode,
    this.nextFieldFocusNode,
    this.onSubmit,
    required this.fieldBloc,
  });

  final String label;
  final String? hintText;
  final bool isObscureText;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFieldFocusNode;
  final VoidCallback? onSubmit;
  final TextFieldBloc fieldBloc;

  @override
  State<TextInputFormBuilder> createState() => _TextInputFormBuilderState();
}

class _TextInputFormBuilderState extends State<TextInputFormBuilder> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.fieldBloc.value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.text;

    final errorTextStyle = typography.caption1.copyWith(color: colors.error);

    return BlocBuilder<TextFieldBloc, TextFieldBlocState>(
      bloc: widget.fieldBloc,
      builder: (context, state) {
        if (_controller.text != state.value) {
          final previousSelection = _controller.selection;

          final offset =
              min(previousSelection.baseOffset, state.toString().length);

          _controller
            ..text = state.toString()
            ..selection = previousSelection.copyWith(
              baseOffset: offset,
              extentOffset: offset,
            );
        }
        return Focus(
          onFocusChange: (value) {
            if (!value) {
              widget.fieldBloc.focusChanged();
            }
          },
          child: TextField(
            controller: _controller,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            focusNode: widget.fieldFocusNode,
            obscureText: widget.isObscureText,
            onChanged: (value) => widget.fieldBloc.changeValue(value),
            onSubmitted: (value) {
              widget.nextFieldFocusNode?.requestFocus();
              widget.onSubmit?.call();
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              errorText: state.displayError,
              helperText: '',
              helperMaxLines: 1,
              errorMaxLines: 1,
              helperStyle: errorTextStyle,
              errorStyle: errorTextStyle,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
