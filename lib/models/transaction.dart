import 'package:realm/realm.dart';

import 'user.dart';
import 'category.dart';
import 'subtransaction.dart';

part 'transaction.realm.dart';

@RealmModel()
class $FinancialTransaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late $AppUser? user;
  late String name;
  late $Category? category;
  late int price;
  late DateTime date;
  late List<$FinancialSubtransaction> subtransactions;
}