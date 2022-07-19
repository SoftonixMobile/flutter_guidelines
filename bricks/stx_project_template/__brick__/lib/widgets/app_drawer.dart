import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:{{project_name}}/blocs/index.dart';
import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/services/index.dart';
import 'package:{{project_name}}/styles/index.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height,
        color: AppColors.white,
        child: Drawer(
          elevation: 3,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primary,
                        backgroundImage:
                            AssetImage(Assets.images.logoShort.path),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        buildMenuItem(
                          text: LocaleKeys.changePassword.tr(),
                          iconData: FontAwesomeIcons.lock,
                        ),
                        GestureDetector(
                            child: buildMenuItem(
                              text: LocaleKeys.languageName.tr(),
                              iconData: FontAwesomeIcons.globe,
                            ),
                            onTap: () async {
                              final newLocale =
                                  context.locale == context.supportedLocales[0]
                                      ? context.supportedLocales[1]
                                      : context.supportedLocales[0];

                              await context.setLocale(newLocale);
                            }),
                        GestureDetector(
                          child: buildMenuItem(
                            text: LocaleKeys.signOut.tr(),
                            iconData: FontAwesomeIcons.rightFromBracket,
                          ),
                          onTap: () {
                            getIt<AuthBloc>().logout();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
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
