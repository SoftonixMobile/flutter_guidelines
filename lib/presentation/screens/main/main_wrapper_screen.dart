import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/presentation/blocs/index.dart';
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

    // ignore: discarded_futures
    getIt.pushNewScopeAsync(init: configureUserDependencies).then((_) {
      return _setProfileInLogger();
    });
  }

  Future<void> _setProfileInLogger() async {
    final userBloc = getIt<UserBloc>()..lazyLoad();

    if (userBloc.state.status == .loading) {
      await userBloc.getAsync();
    }

    final userProfile = userBloc.state.data;

    if (mounted) {
      LoggerService.instance.registerUserProfile(userProfile);
    }
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
        BlocProvider(create: (context) => getIt<DrawerBloc>()..load()),
        BlocProvider(create: (context) => getIt<UserBloc>()),
      ],
      child: const AutoRouter(),
    );
  }
}
