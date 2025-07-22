import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/styles/index.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Container(
      width: screenSize.width * 0.75,
      height: screenSize.height,
      color: AppColors.white,
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
                      backgroundColor: AppColors.black,
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
                        text: context.tr(LocaleKeys.changePassword),
                        iconData: FontAwesomeIcons.lock,
                      ),
                      GestureDetector(
                        child: buildMenuItem(
                          text: context.tr(LocaleKeys.languageName),
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
                          text: context.tr(LocaleKeys.signOut),
                          iconData: FontAwesomeIcons.rightFromBracket,
                        ),
                        onTap: () {
                          getIt<AuthBloc>().add(const AuthEvent.signOut());
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
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData iconData,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
        color: AppColors.grey,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: AppColors.grey,
        ),
      ),
    );
  }
}
