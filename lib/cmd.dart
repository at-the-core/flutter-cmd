import 'package:fltr/create.dart';
import 'package:fltr/doctor.dart';
import 'package:fltr/exec.dart';
import 'package:fltr/prepare.dart';

Future<void> main(List<String> arguments) async {
  doctor(arguments);
  if (await create(arguments)) {
    return;
  }

  await prepareBefore(arguments);

  await execute('flutter', arguments);

  await prepareAfter(arguments);
}
