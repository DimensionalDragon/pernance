import 'package:realm/realm.dart';

import 'transaction.dart';

part 'category.realm.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late String name;
  late int budget;
  late List<$FinancialTransaction> transactions;
}