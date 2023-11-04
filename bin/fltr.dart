import 'dart:io';

void main(List<String> arguments) async {
  final flutter = await Process.start(
    'flutter',
    arguments,
    mode: ProcessStartMode.inheritStdio,
    runInShell: true,
  );
  exit(await flutter.exitCode);
}
