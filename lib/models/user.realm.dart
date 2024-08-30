// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class AppUser extends $AppUser with RealmEntity, RealmObjectBase, RealmObject {
  AppUser(
    ObjectId id,
    String firebaseUID,
    String name,
    String email,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'firebaseUID', firebaseUID);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
  }

  AppUser._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get firebaseUID =>
      RealmObjectBase.get<String>(this, 'firebaseUID') as String;
  @override
  set firebaseUID(String value) =>
      RealmObjectBase.set(this, 'firebaseUID', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  Stream<RealmObjectChanges<AppUser>> get changes =>
      RealmObjectBase.getChanges<AppUser>(this);

  @override
  Stream<RealmObjectChanges<AppUser>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppUser>(this, keyPaths);

  @override
  AppUser freeze() => RealmObjectBase.freezeObject<AppUser>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'firebaseUID': firebaseUID.toEJson(),
      'name': name.toEJson(),
      'email': email.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppUser value) => value.toEJson();
  static AppUser _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'firebaseUID': EJsonValue firebaseUID,
        'name': EJsonValue name,
        'email': EJsonValue email,
      } =>
        AppUser(
          fromEJson(id),
          fromEJson(firebaseUID),
          fromEJson(name),
          fromEJson(email),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppUser._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, AppUser, 'AppUser', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('firebaseUID', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
