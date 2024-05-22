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
  copyDirectory(Directory('resources'), brickDirectory);

  copyFileWithDirectory(File('bin/pr.dart'), '$brickPath/bin', 'pr.dart');

  copyFile(File('.env'), '$brickPath/.env', convert: true);
  copyFile(File('.gitignore'), '$brickPath/.gitignore');
  copyFile(File('analysis_options.yaml'), '$brickPath/analysis_options.yaml');
  copyFile(File('build.yaml'), '$brickPath/build.yaml');
  copyFile(File('pubspec.yaml'), '$brickPath/pubspec.yaml', convert: true);
}

void copyFile(
  File file,
  String newPath, {
  bool convert = false,
}) {
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
    'SoftonixApp',
    '{{#pascalCase}}{{project_name}}{{/pascalCase}}',
  );
  newFileContent = newFileContent.replaceAll(
    'Flutter_Guidelines_',
    '{{#constantCase}}{{project_name}}{{/constantCase}}_',
  );

  file.writeAsStringSync(newFileContent);
}
