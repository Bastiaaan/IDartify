
import 'package:cli/src/context.dart';
import 'package:cli/src/db/TableManager.dart';
import 'package:cli/dbModels/Customer.dart';

Future main(List<String> arguments) async {
    var customerTable = context.customers;
    //await customerTable.tableExists();
    //context.customers.orderBy((element) => element.name);
}