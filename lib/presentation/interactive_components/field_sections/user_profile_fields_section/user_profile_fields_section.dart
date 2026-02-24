import 'package:flutter/material.dart';

import 'package:flutter_guidelines/presentation/widgets/index.dart';
import 'user_profile_group_bloc.dart';

class UserProfileFieldsSection extends StatelessWidget {
  const UserProfileFieldsSection({super.key, required this.groupBloc});

  final UserProfileGroupBloc groupBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputFormBuilder(
          fieldBloc: groupBloc.userName,
        ),
        TextInputFormBuilder(
          fieldBloc: groupBloc.email,
        ),
      ],
    );
  }
}
