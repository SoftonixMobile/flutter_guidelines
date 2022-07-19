import 'package:flutter/widgets.dart';

import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

class CustomFormBlocListener<T extends FormBloc<SuccessResponse, String>,
    SuccessResponse> extends FormBlocListener<T, SuccessResponse, String> {
  CustomFormBlocListener({
    Key? key,
    Widget? child,
    FormBlocListenerCallback<SuccessResponse, String>? onSubmitting,
    FormBlocListenerCallback<SuccessResponse, String>? onSuccess,
    FormBlocListenerCallback<SuccessResponse, String>? onFailure,
    FormBlocListenerCallback<SuccessResponse, String>? onCancel,
    T? formBloc,
  }) : super(
          key: key,
          formBloc: formBloc,
          child: child,
          customListener: (context, state) {
            if (state.status.isLoading) {
              LoadingDialog.show(context);
              onSubmitting?.call(context, state);
            } else if (state.status.isSuccess) {
              LoadingDialog.hide(context);
              onSuccess?.call(context, state);
            } else if (state.status.isFailure) {
              LoadingDialog.hide(context);
              onFailure?.call(context, state);
            } else if (state.status.isCancelled) {
              onCancel?.call(context, state);
            } else if (state.status.isInitial) {
              LoadingDialog.hide(context);
            }
          },
        );

  @override
  Widget? get child => super.child;
}
