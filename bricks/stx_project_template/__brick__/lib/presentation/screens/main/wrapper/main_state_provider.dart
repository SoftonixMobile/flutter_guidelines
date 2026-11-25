import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/core/index.dart';
import 'package:{{project_name}}/presentation/blocs/index.dart';

class const MainStateProvider({
  super.key,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => getIt<UserBloc>()..load(),
        ),
      ],
      child: child,
    );
  }
}
