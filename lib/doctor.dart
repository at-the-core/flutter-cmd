// ignore_for_file: avoid_print

import 'dart:io';

void doctor(List<String> arguments) {
  if (!_isDoctor(arguments)) {
    return;
  }
  final check = stdout.hasTerminal ? '\x1B[32m[✓]\x1B[0m' : '[✓]';
  print('$check Extensible (fltr, 0.1.0)');
  print('');
}

bool _isDoctor(List<String> arguments) =>
    arguments.length == 2 && arguments[0] == 'doctor' && arguments[1] == '-v';
