import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

class CustomFormBlocListener<
  T extends FormBloc<SuccessType, String>,
  SuccessType
>({
  super.key,
  super.child,
  FormBlocListenerCallback<SuccessType, String>? onSubmitting,
  FormBlocListenerCallback<SuccessType, String>? onSuccess,
  FormBlocListenerCallback<SuccessType, String>? onFailure,
  FormBlocListenerCallback<SuccessType, String>? onCancel,
  super.formBloc,
}) extends FormBlocListener<T, SuccessType, String> {
  this
    : super(
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
}
