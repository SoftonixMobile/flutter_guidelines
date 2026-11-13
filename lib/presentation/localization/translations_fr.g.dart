///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsFr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
}

// Path: common
class _Translations$common$fr implements Translations$common$en {
	_Translations$common$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get languageLabel => 'Langue';
	@override late final _Translations$common$language$fr language = _Translations$common$language$fr._(_root);
}

// Path: common.language
class _Translations$common$language$fr implements Translations$common$language$en {
	_Translations$common$language$fr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get english => 'Anglaise';
	@override String get french => 'Français';
}
