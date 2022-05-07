import 'package:flutter/material.dart';
import 'package:flutter_guidelines/localization/index.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.profileDocumentsScreenTitle.tr(),
      ),
    );
  }
}
