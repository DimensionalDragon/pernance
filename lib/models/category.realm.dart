// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Category extends $Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    ObjectId id,
    String name,
    int budget, {
    User? user,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'user', user);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'budget', budget);
  }

  Category._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  User? get user => RealmObjectBase.get<User>(this, 'user') as User?;
  @override
  set user(covariant User? value) => RealmObjectBase.set(this, 'user', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get budget => RealmObjectBase.get<int>(this, 'budget') as int;
  @override
  set budget(int value) => RealmObjectBase.set(this, 'budget', value);

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Stream<RealmObjectChanges<Category>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Category>(this, keyPaths);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'user': user.toEJson(),
      'name': name.toEJson(),
      'budget': budget.toEJson(),
    };
  }

  static EJsonValue _toEJson(Category value) => value.toEJson();
  static Category _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'budget': EJsonValue budget,
      } =>
        Category(
          fromEJson(id),
          fromEJson(name),
          fromEJson(budget),
          user: fromEJson(ejson['user']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Category._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'User'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('budget', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
