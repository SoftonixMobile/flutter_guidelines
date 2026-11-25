import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/domain/models/index.dart';
import 'package:{{project_name}}/presentation/router/index.dart';
import 'package:{{project_name}}/presentation/theme/index.dart';

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
