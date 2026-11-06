import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/config/index.dart';

extension AppConfigX on BuildContext {
  AppConfig get config => read<AppConfig>();
}
