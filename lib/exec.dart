import 'dart:async';
import 'dart:io' as io;

Future<void> execute(
  String command,
  List<String> arguments, {
  String? workingDirectory,
  bool quiet = false,
}) async {
  final process = await io.Process.start(
    command,
    arguments,
    workingDirectory: workingDirectory,
    mode: quiet ? io.ProcessStartMode.normal : io.ProcessStartMode.inheritStdio,
    runInShell: true,
  );
  if (quiet) {
    unawaited(process.stderr.pipe(io.stderr));
  }
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
