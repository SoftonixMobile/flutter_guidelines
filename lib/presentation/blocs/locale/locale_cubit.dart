import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/repositories/index.dart';
import 'package:flutter_guidelines/presentation/localization/index.dart';

part 'locale_cubit.freezed.dart';
part 'locale_state.dart';

@LazySingleton(scope: 'app')
class LocaleCubit(final LocalizationRepository _repository)
    extends Cubit<LocaleState> {
  this : super(LocaleState(current: AppLocaleUtils.findDeviceLocale()));

  Future<void> restore() async {
    final code = await _repository.getLanguageCode();
    final saved = code != null ? AppLocaleUtils.parse(code) : null;

    final appLocale = saved != null && _isLocaleAvailable(saved)
        ? saved
        : state.current;

    await _apply(appLocale);
  }

  Future<void> select(AppLocale locale) async {
    if (!_isLocaleAvailable(locale) || locale == state.current) return;

    await _apply(locale);

    try {
      await _repository.saveLanguageCode(locale.languageTag);
    } catch (e, stackTrace) {
      addError(e, stackTrace);
    }
  }

  Future<void> _apply(AppLocale locale) async {
    await LocaleSettings.setLocale(locale);

    emit(state.copyWith(current: locale));
  }

  bool _isLocaleAvailable(AppLocale locale) {
    return state.available.contains(locale);
  }
}
