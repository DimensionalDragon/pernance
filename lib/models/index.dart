import 'package:realm/realm.dart';

import 'package:pernance/models/user.dart';
import 'package:pernance/models/subtransaction.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/models/category.dart';


var config = Configuration.local([
  AppUser.schema,
  FinancialTransaction.schema,
  FinancialSubtransaction.schema,
  Category.schema,
]);
var realm = Realm(config);
