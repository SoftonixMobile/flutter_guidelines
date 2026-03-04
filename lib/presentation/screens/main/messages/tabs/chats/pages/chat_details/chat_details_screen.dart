import 'package:flutter/material.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';

@RoutePage()
class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key, required this.chat});

  final Chat chat;

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
