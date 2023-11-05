import 'dart:io';

import 'package:fltr/exec.dart';
import 'package:path/path.dart';

Future<bool> create(List<String> arguments) async {
  final template = _getTemplate(arguments);
  if (['app', 'module', 'package', 'plugin', 'plugin_ffi', 'skeleton']
      .contains(template)) {
    return false;
  }

  final dir = Directory(arguments.last);
  final pathExists = dir.existsSync();
  if (!pathExists) {
    dir.createSync(recursive: true);
  }
  final pubspecFile =
      File('${dir.absolute.path}${Platform.pathSeparator}pubspec.yaml');
  final name = basename(normalize(dir.absolute.path));
  await pubspecFile.writeAsString('''
name: $name
environment:
  sdk: '>=3.0.0 <4.0.0'
''');
  try {
    await execute(
      'dart',
      ['pub', 'add', 'dev:$template'],
      workingDirectory: dir.absolute.path,
      quiet: true,
    );
    await execute(
      'dart',
      ['run', '--verbosity', 'warning', '$template:create', ...arguments],
      workingDirectory: dir.absolute.path,
    );
  } catch (e) {
    if (!pathExists) {
      dir.deleteSync(recursive: true);
    }
    rethrow;
  }
  return true;
}

String _getTemplate(List<String> arguments) {
  for (var ix = 1; ix != arguments.length - 1; ++ix) {
    final arg = arguments[ix];
    if (arg == '-t' || arg == '--template') {
      return arguments[ix + 1];
    }
  }
  for (var ix = 1; ix != arguments.length; ++ix) {
    final arg = arguments[ix];
    if (arg.startsWith('--template=')) {
      return arg.substring('--template='.length);
    }
  }
  return 'app';
}
