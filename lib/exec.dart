import 'dart:io';

Future<void> execute(String command, List<String> arguments) async {
  final flutter = await Process.start(
    command,
    arguments,
    mode: ProcessStartMode.inheritStdio,
    runInShell: true,
  );
  final exitCode = await flutter.exitCode;
  if (exitCode != 0) {
    exit(exitCode);
  }
}
