import 'dart:io';

import 'package:fltr/exec.dart';
import 'package:yaml/yaml.dart';

Future<void> prepareBefore(List<String> arguments) async {
  if (!_shouldPrepareBefore(arguments)) {
    return;
  }
  await _prepare();
}

Future<void> prepareAfter(List<String> arguments) async {
  if (!_shouldPrepareAfter(arguments)) {
    return;
  }
  await _prepare();
}

bool _shouldPrepareBefore(List<String> arguments) =>
    arguments.isNotEmpty &&
    ['analyze', 'assemble', 'build', 'drive', 'run'].contains(arguments[0]);
bool _shouldPrepareAfter(List<String> arguments) =>
    arguments.isNotEmpty &&
    ['pub', 'upgrade', 'downgrade'].contains(arguments[0]);

const _trusted = [
  'riddance_env',
];

Future<void> _prepare() async {
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    return;
  }
  final YamlMap? doc = loadYaml(await pubspecFile.readAsString());
  final YamlMap? devDependencies = doc?['dev_dependencies'];
  if (devDependencies == null) {
    return;
  }
  for (final package in _trusted) {
    if (devDependencies.containsKey(package)) {
      await execute('dart', ['run', '$package:prepare']);
    }
  }
}
