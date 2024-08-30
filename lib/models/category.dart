import 'package:realm/realm.dart';

import 'user.dart';
import 'transaction.dart';

part 'category.realm.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late $AppUser? user;
  late String name;
  late int budget;
  late List<$FinancialTransaction> transactions;
}