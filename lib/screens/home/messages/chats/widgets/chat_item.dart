import 'package:flutter/material.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/theme/app_theme.dart';
import 'package:flutter_guidelines/widgets/index.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final borderColor = AppTheme.of(context).colors.grey;

    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: CircleAvatar(
              radius: 32,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: borderColor)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.subhead2(
                              chat.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Date
                            const AppText.caption1('12/05'),
                          ],
                        ),
                        const AppText.caption2(
                          'last message',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
