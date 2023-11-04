import 'dart:io';

import 'package:fltr/doctor.dart';
import 'package:fltr/exec.dart';
import 'package:fltr/prepare.dart';

void main(List<String> arguments) async {
  doctor(arguments);
  try {
    await prepareBefore(arguments);
  } catch (e) {
    stderr
      ..writeln('Error preparing.')
      ..writeln(e);
    exit(1);
  }

  await execute('flutter', arguments);

  try {
    await prepareAfter(arguments);
  } catch (e) {
    stderr
      ..writeln('Error preparing.')
      ..writeln(e);
    exit(1);
  }
}
