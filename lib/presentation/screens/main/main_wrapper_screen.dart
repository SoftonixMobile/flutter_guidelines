import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/blocs/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'drawer/drawer_bloc.dart';

@RoutePage(name: 'MainRouter')
class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  @override
  void initState() {
    super.initState();

    unawaited(getIt.pushNewScopeAsync(init: configureUserDependencies));
  }

  @override
  void dispose() {
    unawaited(getIt.popScope());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()..lazyLoad()),
        BlocProvider(create: (context) => getIt<DrawerBloc>()..load()),
      ],
      child: const AutoRouter(),
      // child: BlocListener<UserBloc, UserState>(
      //   listenWhen: (previous, current) =>
      //       current.status.isSuccess && previous.data != current.data,
      //   listener: (context, state) {
      //     LoggerService.instance.registerUserProfile(state.data);
      //   },
      //   child: const AutoRouter(),
      // ),
    );
  }
}
