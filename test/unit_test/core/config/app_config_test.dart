import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_guidelines/core/config/index.dart';
import 'package:flutter_guidelines/core/exceptions/config_exception.dart';

void main() {
  group('AppConfig.parse', () {
    const valid = {
      'ENV': 'dev',
      'APP_API_URL': 'https://api.test',
    };

    Map<String, String> validWith(String key, String value) => {
      ...valid,
      key: value,
    };

    // Checks only that the message names the offending key or value, so
    // rewording a message doesn't break the tests.
    Matcher throwsConfigException(String mentioning) => throwsA(
      isA<ConfigException>().having(
        (e) => e.message,
        'message',
        contains(mentioning),
      ),
    );

    test('parses a valid map', () {
      final config = AppConfig.parse(valid);

      expect(config.environment, AppEnvironment.dev);
      expect(config.apiUrl, Uri.parse('https://api.test'));
      expect(config.enableConsoleLogs, isFalse);
    });

    test('parses prod', () {
      final config = AppConfig.parse(validWith('ENV', 'prod'));

      expect(config.environment, AppEnvironment.prod);
      expect(config.environment.isProd, isTrue);
      expect(config.environment.isDev, isFalse);
    });

    test('enables console logs for debug builds', () {
      expect(
        AppConfig.parse(valid, isDebugBuild: true).enableConsoleLogs,
        isTrue,
      );
    });

    for (final key in valid.keys) {
      test('throws when $key is missing', () {
        expect(
          () => AppConfig.parse({...valid}..remove(key)),
          throwsConfigException(key),
        );
      });

      test('throws when $key is empty', () {
        expect(
          () => AppConfig.parse(validWith(key, '')),
          throwsConfigException(key),
        );
      });
    }

    test('throws on unknown ENV', () {
      expect(
        () => AppConfig.parse(validWith('ENV', 'Prod')),
        throwsConfigException('Prod'),
      );
    });

    for (final url in ['api.test', '/v1', 'localhost:8080']) {
      test('throws on invalid APP_API_URL "$url"', () {
        expect(
          () => AppConfig.parse(validWith('APP_API_URL', url)),
          throwsConfigException('APP_API_URL'),
        );
      });
    }
  });
}
