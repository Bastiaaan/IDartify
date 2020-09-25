
import 'package:cli/src/context.dart';

Future main(List<String> arguments) async {
  var customer = context.vendors.take(2);
  print(customer.elementAt(1).id);
}