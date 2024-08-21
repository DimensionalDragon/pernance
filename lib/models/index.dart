import 'package:realm/realm.dart' as realm_dart;

import 'package:pernance/models/user.dart';

var config = realm_dart.Configuration.local([User.schema]);
var realm = realm_dart.Realm(config);
