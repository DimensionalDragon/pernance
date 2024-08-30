import 'package:realm/realm.dart';

part 'user.realm.dart';

@RealmModel()
class $AppUser {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late String firebaseUID;
  late String name;
  late String email;
}