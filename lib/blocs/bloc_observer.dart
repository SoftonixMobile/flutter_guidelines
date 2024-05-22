import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/services/logger/index.dart';

class SimpleBlocObserver extends BlocObserver {
  final Logger logger;

  SimpleBlocObserver(this.logger);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.log('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.log('onChange -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.logError(error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.log('onClose -- bloc: ${bloc.runtimeType}');
  }
}
