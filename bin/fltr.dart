import 'dart:io';

import 'package:fltr/doctor.dart';

void main(List<String> arguments) async {
  doctor(arguments);
  final flutter = await Process.start(
    'flutter',
    arguments,
    mode: ProcessStartMode.inheritStdio,
    runInShell: true,
  );
  exit(await flutter.exitCode);
}
