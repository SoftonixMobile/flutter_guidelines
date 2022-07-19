import 'package:flutter/material.dart';
import 'package:{{project_name}}/core/index.dart';

import 'package:{{project_name}}/localization/index.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.posts.tr(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => RootScaffold.openDrawer(context),
        ),
      ),
      body: Center(
        child: Text(
          LocaleKeys.postsScreenTitle.tr(),
        ),
      ),
    );
  }
}
