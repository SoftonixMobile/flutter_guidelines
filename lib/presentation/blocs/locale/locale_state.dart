part of 'locale_cubit.dart';

@freezed
sealed class LocaleState with _$LocaleState {
  const factory({
    required AppLocale current,
    @Default(AppLocale.values) List<AppLocale> available,
  }) = _LocaleState;
}
