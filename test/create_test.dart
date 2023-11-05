import 'dart:io';

import 'package:fltr/create.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Directory.current =
        Directory('${Directory.systemTemp.path}${Platform.pathSeparator}fltr')
          ..createSync(recursive: true)
          ..absolute;
  });

  test('falls back to flutter', () async {
    for (final args in [
      [],
      ['-t', 'app'],
      ['--template', 'app'],
      ['--template=app'],
      ['-t', 'package'],
      ['--template', 'package'],
      ['--template=package'],
    ]) {
      final created = await create(['create', ...args, 'flutter-app']);
      expect(created, false);
    }
  });

  test('creates subdirectory', () async {
    final created =
        await create(['create', '-t', 'riddance_env', 'subdirectory']);
    expect(created, true);
  });

  test('creates in current directory', () async {
    Directory.current = Directory(
      '${Directory.current.absolute.path}${Platform.pathSeparator}existing',
    )
      ..createSync(recursive: true)
      ..absolute;

    final created = await create(['create', '-t', 'riddance_env', '.']);
    expect(created, true);
  });
}
