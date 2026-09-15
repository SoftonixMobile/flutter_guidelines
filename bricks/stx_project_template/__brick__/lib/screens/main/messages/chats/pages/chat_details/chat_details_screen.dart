import 'package:flutter/material.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/router/index.dart';

@RoutePage()
class const ChatDetailsScreen({
  super.key,
  required final Chat chat,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(chat.name),
      ),
    );
  }
}
