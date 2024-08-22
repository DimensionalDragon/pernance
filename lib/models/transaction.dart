import 'package:realm/realm.dart';

import 'user.dart';
import 'category.dart';
import 'subtransaction.dart';

part 'transaction.realm.dart';

@RealmModel()
class $Transaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  @RealmModel()
  late $User? user;
  late String name;
  @RealmModel()
  late $Category? category;
  late int price;
  late DateTime date;
  @RealmModel()
  late List<$Subtransaction> subtransactions;
}