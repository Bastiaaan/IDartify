

import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'Customer.dart';
import 'package:cli/propertyAnnotations/dataColumn.dart';

class Order extends MotherModel {

  @DataColumn('customerId', int)
  int customerId;

  Customer customer;

  @DataColumn('description', String)
  String description;

  List<dynamic> itemsPurchased;

  @DataColumn('isPayed', bool)
  bool isPayed;
}