import 'package:flutter/widgets.dart';
import 'package:flutter_guidelines/localization/index.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.profileInfoScreenTitle.tr(),
      ),
    );
  }
}
