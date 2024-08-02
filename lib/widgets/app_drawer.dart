import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_guidelines/app/app.dart';
import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/styles/assets.gen.dart';
import 'package:flutter_guidelines/theme/app_theme.dart';
import 'package:flutter_guidelines/widgets/base/app_text.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        backgroundColor: themeData.colors.foreground,
        elevation: 3,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: themeData.colors.background,
                      backgroundImage: AssetImage(Assets.images.logoShort.path),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      buildMenuItem(
                        context,
                        text: LocaleKeys.changePassword.tr(),
                        iconData: FontAwesomeIcons.lock,
                      ),
                      GestureDetector(
                        child: buildMenuItem(
                          context,
                          text: LocaleKeys.languageName.tr(),
                          iconData: FontAwesomeIcons.globe,
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
                        child: buildMenuItem(
                          context,
                          text: LocaleKeys.signOut.tr(),
                          iconData: FontAwesomeIcons.rightFromBracket,
                        ),
                        onTap: () {
                          getIt<AuthBloc>().add(const AuthEvent.signOut());
                        },
                      ),
                      Switch.adaptive(
                        value: context.watch<SwitchProvider>().isDarkTheme,
                        onChanged: context.read<SwitchProvider>().changeTheme,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required String text,
    required IconData iconData,
  }) {
    final themeData = AppTheme.of(context);

    return ListTile(
      leading: Icon(
        iconData,
        color: themeData.colors.grey,
      ),
      title: AppText.body1(
        text,
        color: themeData.colors.background,
      ),
    );
  }
}
