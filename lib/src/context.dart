
import 'package:cli/dbModels/Customer.dart';
import 'package:cli/dbModels/Vehicle.dart';
import 'package:cli/dbModels/Vendor.dart';
import 'package:cli/src/db/DataTable.dart';
import 'package:cli/src/db/DataContext.dart';

class Context extends DataContext {
  
  DataTable<Vehicle> vehicles;  
  DataTable<Vendor> vendors;
  DataTable<Customer> customers;

  Context() {
    customers = DataTable<Customer>();
    vehicles = DataTable<Vehicle>();
    vendors = DataTable<Vendor>();
  }
}

final context = Context();