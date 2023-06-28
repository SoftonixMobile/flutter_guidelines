import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{project_name}}/blocs/index.dart';
import 'package:{{project_name}}/services/index.dart';

class HomeStateWrapper extends StatelessWidget {
  const HomeStateWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<PostsBloc>(),
        ),
      ],
      child: child,
    );
  }
}
