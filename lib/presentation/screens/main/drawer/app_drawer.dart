import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'drawer_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildMenuItem({
    required String text,
    required IconData iconData,
    required AppColorsTheme colors,
    required AppTypographyTheme typography,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
        color: colors.textSecondary,
      ),
      title: Text(
        text,
        style: typography.bodySmall.copyWith(
          color: colors.textSecondary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final colors = context.theme.colorsTheme;
    final typography = context.theme.typographyTheme;

    return BlocProvider(
      create: (context) => getIt<DrawerBloc>()..lazyLoad(),
      child: Container(
        width: screenSize.width * 0.75,
        height: screenSize.height,
        color: colors.surface,
        child: Drawer(
          elevation: 3,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: screenSize.height,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: colors.textPrimary,
                        backgroundImage: AssetImage(
                          Assets.images.logoShort.path,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          text: context.tr(LocaleKeys.changePassword),
                          iconData: FontAwesomeIcons.lock,
                          colors: colors,
                          typography: typography,
                        ),
                        GestureDetector(
                          child: _buildMenuItem(
                            text: context.tr(LocaleKeys.languageName),
                            iconData: FontAwesomeIcons.globe,
                            colors: colors,
                            typography: typography,
                          ),
                          onTap: () async {
                            final newLocale =
                                context.locale == context.supportedLocales[0]
                                ? context.supportedLocales[1]
                                : context.supportedLocales[0];

                            await context.setLocale(newLocale);
                          },
                        ),
                        GestureDetector(
                          child: _buildMenuItem(
                            text: context.tr(LocaleKeys.signOut),
                            iconData: FontAwesomeIcons.rightFromBracket,
                            colors: colors,
                            typography: typography,
                          ),
                          onTap: () {
                            context.read<AuthBloc>().add(
                              const AuthEvent.signOut(),
                            );
                          },
                        ),
                        BlocBuilder<DrawerBloc, DrawerState>(
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.data.length,
                              itemBuilder: (context, index) {
                                final post = state.data[index];

                                return ListTile(
                                  title: Text(post.name),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
