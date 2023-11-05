import 'dart:io' as io;

Future<void> execute(
  String command,
  List<String> arguments, {
  String? workingDirectory,
}) async {
  final process = await io.Process.start(
    command,
    arguments,
    workingDirectory: workingDirectory,
    mode: io.ProcessStartMode.inheritStdio,
    runInShell: true,
  );
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw NonZeroExitCode(exitCode);
  }
}

final class NonZeroExitCode implements Exception {
  const NonZeroExitCode(this.exitCode);

  final int exitCode;

  void exit() {
    io.exit(exitCode);
  }
}
