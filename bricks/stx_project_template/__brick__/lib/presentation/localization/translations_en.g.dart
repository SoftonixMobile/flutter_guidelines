///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final tr = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$common$en common = Translations$common$en._(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get languageLabel => 'Language';

	late final Translations$common$language$en language = Translations$common$language$en._(_root);
	late final Translations$common$validators$en validators = Translations$common$validators$en._(_root);
}

// Path: common.language
class Translations$common$language$en {
	Translations$common$language$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get english => 'English';

	/// en: 'French'
	String get french => 'French';
}

// Path: common.validators
class Translations$common$validators$en {
	Translations$common$validators$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Field is required'
	String get required => 'Field is required';

	/// en: 'Email is invalid'
	String get email => 'Email is invalid';

	/// en: 'Must be at least $min characters'
	String minLength({required Object min}) => 'Must be at least ${min} characters';

	/// en: 'Must be at most $max characters'
	String maxLength({required Object max}) => 'Must be at most ${max} characters';
}
