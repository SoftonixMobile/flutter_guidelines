import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/blocs/index.dart';
import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';

class const LanguageDropdown({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    final theme = context.theme;

    final (colors, typography) = (
      theme.colorsTheme,
      theme.typographyTheme,
    );

    final textStyle = typography.bodySmall.copyWith(
      color: colors.textSecondary,
    );

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return ListTile(
          leading: Icon(
            FontAwesomeIcons.globe.data,
            color: colors.textSecondary,
          ),
          title: Text(
            tr.common.languageLabel,
            style: textStyle,
          ),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton<AppLocale>(
              value: state.current,
              style: textStyle,
              dropdownColor: colors.surface,
              items: [
                for (final locale in state.available)
                  DropdownMenuItem(
                    value: locale,
                    child: Text(
                      locale.getNativeName(tr),
                    ),
                  ),
              ],
              onChanged: (locale) async {
                if (locale == null) return;

                await context.read<LocaleCubit>().select(locale);
              },
            ),
          ),
        );
      },
    );
  }
}
