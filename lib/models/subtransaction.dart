import 'package:realm/realm.dart';

import 'transaction.dart';

part 'subtransaction.realm.dart';

@RealmModel()
class $FinancialSubtransaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late $FinancialTransaction? transaction;
  late String name;
  late int price;
}