import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/domain/models/index.dart';

class UserProfileGroupBloc extends GroupFieldBloc {
  late final TextFieldBloc userName;
  late final TextFieldBloc email;

  final UserProfile? initial;

  UserProfileGroupBloc({this.initial}) {
    userName = TextFieldBloc(
      initialValue: initial?.userName,
    );
    email = TextFieldBloc();

    addFieldBlocs([
      userName,
      email,
    ]);
  }

  UserProfile toUserProfile() {
    return UserProfile(
      id: initial?.id ?? 0,
      userName: userName.value,
    );
  }
}
