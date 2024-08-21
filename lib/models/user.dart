import 'package:realm/realm.dart';

part 'user.realm.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late String firebaseUID;
  late String name;
  late String email;
}