import 'package:fltr/cmd.dart' as fltr;
import 'package:test/test.dart';

void main() {
  test('succeeds', () async {
    await fltr.main([]);
  });

  test('diagnoses', () async {
    await fltr.main(['doctor']);
  });
}
