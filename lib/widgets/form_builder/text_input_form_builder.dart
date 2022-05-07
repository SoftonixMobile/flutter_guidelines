import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guidelines/styles/index.dart';
import 'package:stx_form_bloc/stx_form_bloc.dart';

class TextInputFormBuilder extends StatefulWidget {
  const TextInputFormBuilder({
    Key? key,
    this.label = '',
    this.hintText,
    this.isObscureText = false,
    this.fieldFocusNode,
    this.nextFieldFocusNode,
    this.onSubmit,
    required this.fieldBloc,
  }) : super(key: key);

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
  initState() {
    _controller = TextEditingController(text: widget.fieldBloc.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldBloc, TextFieldBlocState>(
      bloc: widget.fieldBloc,
      builder: (context, state) {
        TextSelection previousSelection = _controller.selection;
        _controller.text = state.value;
        _controller.selection = previousSelection;

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
            maxLines: 1,
            decoration: InputDecoration(
              hintText: widget.hintText,
              errorText: state.displayError,
              helperText: '',
              helperMaxLines: 1,
              errorMaxLines: 1,
              helperStyle: AppTextStyles.error,
              errorStyle: AppTextStyles.error,
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
