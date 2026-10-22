import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/blocs/index.dart';

class const MainStateListener({
  super.key,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              current.status.isSuccess && previous.data != current.data,
          listener: (context, state) {
            getIt<Logger>().registerUser(
              id: state.data.id,
              userName: state.data.userName,
            );
          },
        ),
      ],
      child: child,
    );
  }
}
