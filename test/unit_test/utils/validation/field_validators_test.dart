import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/utils/index.dart';

void main() {
  group('FieldValidators', () {
    test('required', () {
      expect(FieldValidators.required('a'), isNull);
      expect(FieldValidators.required([1]), isNull);
      expect(FieldValidators.required(0), isNull);

      for (final value in [null, '', <int>[], <String, int>{}]) {
        expect(
          FieldError.decode(FieldValidators.required(value)),
          isA<RequiredError>(),
        );
      }
    });

    test('booleanRequired', () {
      expect(FieldValidators.booleanRequired(true), isNull);
      expect(
        FieldError.decode(FieldValidators.booleanRequired(false)),
        isA<RequiredError>(),
      );
      expect(
        FieldError.decode(FieldValidators.booleanRequired(null)),
        isA<RequiredError>(),
      );
    });

    test('email', () {
      expect(FieldValidators.email('john@mail.com'), isNull);
      expect(
        FieldError.decode(FieldValidators.email('john')),
        isA<EmailError>(),
      );
      expect(
        FieldError.decode(FieldValidators.email(null)),
        isA<EmailError>(),
      );
    });

    test('minLength keeps its parameter', () {
      final min6 = FieldValidators.minLength(6);
      final min8 = FieldValidators.minLength(8);

      expect(min6('123456'), isNull);
      expect(min6('12345'), 'minLength:6');
      expect(min8('12345'), 'minLength:8');
      expect(
        FieldError.decode(min6(null)),
        isA<MinLengthError>().having((e) => e.min, 'min', 6),
      );
      expect(
        FieldError.decode(min8('12345')),
        isA<MinLengthError>().having((e) => e.min, 'min', 8),
      );
    });

    test('maxLength keeps its parameter', () {
      final max3 = FieldValidators.maxLength(3);

      expect(max3('123'), isNull);
      expect(max3(null), isNull);
      expect(
        FieldError.decode(max3('1234')),
        isA<MaxLengthError>().having((e) => e.max, 'max', 3),
      );
    });
  });

  group('FieldError.decode', () {
    test('returns null for null and for text that is not a code', () {
      expect(FieldError.decode(null), isNull);
      expect(FieldError.decode('Field is required'), isNull);
    });
  });

  group('FieldError.localize', () {
    late Translations en;
    late Translations fr;

    setUpAll(() async {
      en = await AppLocale.en.build();
      fr = await AppLocale.fr.build();
    });

    test('en', () {
      expect(const RequiredError().localize(en), 'Field is required');
      expect(const EmailError().localize(en), 'Email is invalid');
      expect(
        const MinLengthError(6).localize(en),
        'Must be at least 6 characters',
      );
      expect(
        const MaxLengthError(20).localize(en),
        'Must be at most 20 characters',
      );
    });

    test('fr', () {
      expect(const RequiredError().localize(fr), 'Ce champ est obligatoire');
      expect(const EmailError().localize(fr), 'Adresse e-mail invalide');
      expect(
        const MinLengthError(6).localize(fr),
        'Doit contenir au moins 6 caractères',
      );
      expect(
        const MaxLengthError(20).localize(fr),
        'Doit contenir au plus 20 caractères',
      );
    });
  });
}
