// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtransaction.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FinancialSubtransaction extends $FinancialSubtransaction
    with RealmEntity, RealmObjectBase, RealmObject {
  FinancialSubtransaction(
    ObjectId id,
    String name,
    int price, {
    FinancialTransaction? transaction,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'transaction', transaction);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'price', price);
  }

  FinancialSubtransaction._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  FinancialTransaction? get transaction =>
      RealmObjectBase.get<FinancialTransaction>(this, 'transaction')
          as FinancialTransaction?;
  @override
  set transaction(covariant FinancialTransaction? value) =>
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
  Stream<RealmObjectChanges<FinancialSubtransaction>> get changes =>
      RealmObjectBase.getChanges<FinancialSubtransaction>(this);

  @override
  Stream<RealmObjectChanges<FinancialSubtransaction>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FinancialSubtransaction>(this, keyPaths);

  @override
  FinancialSubtransaction freeze() =>
      RealmObjectBase.freezeObject<FinancialSubtransaction>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'transaction': transaction.toEJson(),
      'name': name.toEJson(),
      'price': price.toEJson(),
    };
  }

  static EJsonValue _toEJson(FinancialSubtransaction value) => value.toEJson();
  static FinancialSubtransaction _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'price': EJsonValue price,
      } =>
        FinancialSubtransaction(
          fromEJson(id),
          fromEJson(name),
          fromEJson(price),
          transaction: fromEJson(ejson['transaction']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FinancialSubtransaction._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, FinancialSubtransaction,
        'FinancialSubtransaction', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('transaction', RealmPropertyType.object,
          optional: true, linkTarget: 'FinancialTransaction'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
