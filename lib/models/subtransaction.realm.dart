// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtransaction.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Subtransaction extends $Subtransaction
    with RealmEntity, RealmObjectBase, RealmObject {
  Subtransaction(
    ObjectId id,
    String name,
    int price, {
    Transaction? transaction,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'transaction', transaction);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'price', price);
  }

  Subtransaction._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  Transaction? get transaction =>
      RealmObjectBase.get<Transaction>(this, 'transaction') as Transaction?;
  @override
  set transaction(covariant Transaction? value) =>
      RealmObjectBase.set(this, 'transaction', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get price => RealmObjectBase.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObjectBase.set(this, 'price', value);

  @override
  Stream<RealmObjectChanges<Subtransaction>> get changes =>
      RealmObjectBase.getChanges<Subtransaction>(this);

  @override
  Stream<RealmObjectChanges<Subtransaction>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Subtransaction>(this, keyPaths);

  @override
  Subtransaction freeze() => RealmObjectBase.freezeObject<Subtransaction>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'transaction': transaction.toEJson(),
      'name': name.toEJson(),
      'price': price.toEJson(),
    };
  }

  static EJsonValue _toEJson(Subtransaction value) => value.toEJson();
  static Subtransaction _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'price': EJsonValue price,
      } =>
        Subtransaction(
          fromEJson(id),
          fromEJson(name),
          fromEJson(price),
          transaction: fromEJson(ejson['transaction']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Subtransaction._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, Subtransaction, 'Subtransaction', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('transaction', RealmPropertyType.object,
          optional: true, linkTarget: 'Transaction'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
