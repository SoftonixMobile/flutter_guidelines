import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/blocs/index.dart';
import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';

import 'main_scope_provider.dart';
import 'main_state_listener.dart';
import 'main_state_provider.dart';

@RoutePage(name: 'MainRouter')
class const MainWrapperScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScopeProvider(
      child: MainStateProvider(
        child: MainStateListener(
          child: BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              // Once the profile is loaded, keep the app mounted on reloads.
              if (state.data.id != 0) {
                return const AutoRouter();
              }

              return switch (state.status) {
                .failure => _UserLoadFailure(
                  onRetry: context.read<UserBloc>().load,
                ),
                _ => const AppLoader(),
              };
            },
          ),
        ),
      ),
    );
  }
}

class const _UserLoadFailure({
  required final VoidCallback onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorsTheme;
    final typography = context.theme.typographyTheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisSize: .min,
          spacing: 16,
          children: [
            Text(
              context.tr(LocaleKeys.somethingWentWrong),
              style: typography.bodyLarge.copyWith(color: colors.textPrimary),
            ),
            FilledButton(
              onPressed: onRetry,
              child: Text(context.tr(LocaleKeys.retry)),
            ),
          ],
        ),
      ),
    );
  }
}
