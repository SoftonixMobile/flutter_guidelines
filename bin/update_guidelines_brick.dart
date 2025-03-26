import 'dart:io';

/// This is a script to apply new changes from the flutter_guidelines project
/// to the stx_project_template brick
///
void main(List<String> args) async {
  const brickPath = 'bricks/stx_project_template/__brick__';
  final brickDirectory = Directory(brickPath)
    ..deleteSync(recursive: true)
    ..createSync();

  copyDirectory(Directory('assets'), brickDirectory);
  copyDirectory(Directory('lib'), brickDirectory, convert: true);
  copyDirectory(Directory('packages'), brickDirectory);
  copyDirectory(Directory('resources'), brickDirectory);
  copyDirectory(Directory('scripts'), brickDirectory);

  copyFileWithDirectory(
    File('.vscode/launch.json'),
    '$brickPath/.vscode',
    'launch.json',
  );

  copyFile(File('.env.dev'), '$brickPath/.env.dev', convert: true);
  copyFile(File('.env.prod'), '$brickPath/.env.prod', convert: true);
  copyFile(File('.gitignore'), '$brickPath/.gitignore');
  copyFile(File('analysis_options.yaml'), '$brickPath/analysis_options.yaml');
  copyFile(File('build.yaml'), '$brickPath/build.yaml');
  copyFile(File('pubspec.yaml'), '$brickPath/pubspec.yaml', convert: true);
  copyFile(File('Makefile'), '$brickPath/Makefile');
}

void copyFile(
  File file,
  String newPath, {
  bool convert = false,
}) {
  if (file.path.endsWith('DS_Store')) return;

  file.copySync(newPath);

  if (convert) {
    convertToBrickFormat(File(newPath));
  }
}

void copyFileWithDirectory(
  File file,
  String directoryPath,
  String fileName, {
  bool convert = false,
}) {
  final destination = Directory(directoryPath);
  if (!destination.existsSync()) {
    destination.createSync(recursive: true);
  }

  final newPath = destination.path + Platform.pathSeparator + fileName;

  copyFile(file, newPath);
}

void copyDirectory(
  Directory source,
  Directory destination, {
  bool convert = false,
}) {
  final coreFolder =
      Directory(destination.path + Platform.pathSeparator + source.path);
  if (!coreFolder.existsSync()) {
    coreFolder.createSync();
  }

  source.listSync(recursive: true).forEach((entity) {
    final newPath = destination.path + Platform.pathSeparator + entity.path;

    if (entity is File) {
      copyFile(entity, newPath, convert: convert);
    } else if (entity is Directory) {
      final newDestination = Directory(newPath);
      if (!newDestination.existsSync()) {
        newDestination.createSync(recursive: true);
      }
    }
  });
}

void convertToBrickFormat(File file) {
  final fileContent = file.readAsStringSync();

  var newFileContent =
      fileContent.replaceAll('flutter_guidelines', '{{project_name}}');

  newFileContent = newFileContent.replaceAll(
    'FlutterGuidelines',
    '{{#pascalCase}}{{project_name}}{{/pascalCase}}',
  );
  newFileContent = newFileContent.replaceAll(
    'Flutter_Guidelines_',
    '{{#constantCase}}{{project_name}}{{/constantCase}}_',
  );

  file.writeAsStringSync(newFileContent);
}
