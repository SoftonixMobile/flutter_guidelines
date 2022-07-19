import 'package:flutter/material.dart';

import 'package:flutter_guidelines/localization/index.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen>
     {
  var iconData = Icons.abc;

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.profileInfoScreenTitle.tr(),
        ),
        IconButton(
          icon: Icon(iconData),
          onPressed: () {
            setState(() {
              iconData = Icons.read_more;
            });
          },
        ),
      ],
    );
  }
}
