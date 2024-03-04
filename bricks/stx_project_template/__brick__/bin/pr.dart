import 'dart:io';

Future<void> main(List<String> args) async {
  await Process.run('dart', [
    'fix',
    '--apply',
  ]);
  await Process.run('dart', [
    'run',
    'import_sorter:main',
  ]);
  await Process.run(
    'dart',
    [
      'run',
      'stx_easy_localization_generator:generate',
      '-O',
      'lib/localization',
    ],
  );
  await Process.run('dart', [
    'run',
    'stx_easy_localization_generator:generate',
    '-f',
    'keys',
    '-o',
    'locale_keys.g.dart',
    '-O',
    'lib/localization',
  ]);
  await Process.run('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
}
