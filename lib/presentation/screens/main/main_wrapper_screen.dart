import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/blocs/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';

@RoutePage(name: 'MainRouter')
class const MainWrapperScreen({super.key}) extends StatefulWidget {
  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState() extends State<MainWrapperScreen> {
  @override
  void initState() {
    super.initState();

    getIt.pushNewScope(init: configureUserDependencies);
  }

  @override
  void dispose() {
    unawaited(getIt.popScope());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MainStateWrapper(
      child: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            current.status.isSuccess && previous.data != current.data,
        listener: (context, state) {
          getIt<Logger>().registerUser(
            id: state.data.id,
            userName: state.data.userName,
          );
        },
        child: const AutoRouter(),
      ),
    );
  }
}

class const _MainStateWrapper({
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()..lazyLoad()),
      ],
      child: child,
    );
  }
}
