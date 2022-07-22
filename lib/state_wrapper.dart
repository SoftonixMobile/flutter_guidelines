import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/services/index.dart';

class StateWrapper extends StatelessWidget {
  const StateWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: child,
    );
  }
}
