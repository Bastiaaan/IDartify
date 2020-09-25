import 'dart:mirrors';
import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'package:cli/cli.dart';
import 'package:test/test.dart';

void main() {
  var reflct = reflectClass(Animator);
  print(reflct.declarations[#name].runtimeType);
}
