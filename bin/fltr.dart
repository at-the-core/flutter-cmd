import 'package:fltr/cmd.dart' as impl;
import 'package:fltr/exec.dart';

Future<int> main(List<String> arguments) async {
  try {
    await impl.main(arguments);
    return 0;
  } on NonZeroExitCode catch (e) {
    return e.exitCode;
  }
}
