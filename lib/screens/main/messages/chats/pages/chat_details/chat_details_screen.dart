import 'package:flutter/material.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/router/index.dart';

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
