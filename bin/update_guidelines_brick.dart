import 'dart:convert';
import 'dart:io';

/// This is a script to apply new changes from the flutter_guidelines project
/// to the stx_project_template brick
///
const brickPath = 'bricks/stx_project_template';
const templatePath = '$brickPath/__brick__';

const templateSources = [
  '.claude/skills',
  '.env.example',
  '.fvmrc',
  '.gitignore',
  '.vscode/launch.json',
  '.vscode/tasks.json',
  'CLAUDE.md',
  'Makefile',
  'analysis_options.yaml',
  'assets',
  'build.yaml',
  'devtools_options.yaml',
  'docs',
  'lib',
  'packages',
  'pubspec.lock',
  'pubspec.yaml',
  'resources',
  'scripts',
  'test',
];

const envExamplePath = '.env.example';
const envNameKey = 'ENV';
const envNames = ['dev', 'prod'];
const envTemplateValues = {
  'APP_API_URL': 'https://softonix.org',
};

const mustacheOpen = '{{';
const escapedMustacheOpen = '{{=<% %>=}}{{<%={{ }}=%>';

void main() {
  if (!File('$brickPath/brick.yaml').existsSync()) {
    fail('$brickPath not found. Run this script from the project root.');
  }

  final files = listSourceFiles();

  final template = Directory(templatePath);
  if (template.existsSync()) template.deleteSync(recursive: true);
  template.createSync(recursive: true);

  files.forEach(copyToTemplate);
  envNames.forEach(writeEnvFile);

  stdout.writeln('Updated $templatePath (${files.length} files copied).');
}

List<String> listSourceFiles() {
  final missing = templateSources.where(
    (path) => FileSystemEntity.typeSync(path) == .notFound,
  );
  if (missing.isNotEmpty) {
    fail('Template sources not found: ${missing.join(', ')}');
  }

  final result = Process.runSync(
    'git',
    [
      'ls-files',
      '--cached',
      '--others',
      '--exclude-standard',
      '-z',
      '--',
      ...templateSources,
    ],
    stdoutEncoding: utf8,
    stderrEncoding: utf8,
  );
  if (result.exitCode != 0) fail('git ls-files failed: ${result.stderr}');

  return (result.stdout as String)
      .split('\x00')
      .where((path) => path.isNotEmpty && File(path).existsSync())
      .toList();
}

void copyToTemplate(String path) {
  final target = File('$templatePath/$path');
  target.parent.createSync(recursive: true);
  File(path).copySync(target.path);

  final content = tryReadText(target);
  if (content == null) return;

  final converted = toBrickFormat(content);
  if (converted != content) target.writeAsStringSync(converted);
}

String? tryReadText(File file) {
  try {
    return utf8.decode(file.readAsBytesSync());
  } on FormatException {
    return null;
  }
}

String toBrickFormat(String content) {
  return content
      .replaceAll(mustacheOpen, escapedMustacheOpen)
      .replaceAll(
        'FlutterGuidelinesApp',
        '{{#pascalCase}}{{project_name}}{{/pascalCase}}App',
      )
      .replaceAll('flutter_guidelines', '{{project_name}}');
}

void writeEnvFile(String envName) {
  final lines = File(envExamplePath).readAsLinesSync().map((line) {
    final separator = line.indexOf('=');
    if (separator == -1 || line.trimLeft().startsWith('#')) return line;

    final key = line.substring(0, separator).trim();
    final value = key == envNameKey
        ? envName
        : envTemplateValues[key] ??
              fail('No template value for $key. Add it to envTemplateValues.');

    return '$key=$value';
  });

  File(
    '$templatePath/.env.$envName',
  ).writeAsStringSync('${lines.join('\n')}\n');
}

Never fail(String message) {
  stderr.writeln(message);
  exit(1);
}
