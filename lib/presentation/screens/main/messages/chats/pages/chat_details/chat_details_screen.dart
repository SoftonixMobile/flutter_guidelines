import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';

@RoutePage()
class const ChatDetailsScreen({super.key, required final Chat chat})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typographyTheme;

    return Scaffold(
      body: Center(
        child: Text(
          chat.name,
          style: typography.titleLarge,
        ),
      ),
    );
  }
}
