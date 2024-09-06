// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FinancialTransaction extends $FinancialTransaction
    with RealmEntity, RealmObjectBase, RealmObject {
  FinancialTransaction(
    ObjectId id,
    String name,
    int price,
    DateTime date, {
    Category? category,
    Iterable<FinancialSubtransaction> subtransactions = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set<RealmList<FinancialSubtransaction>>(this,
        'subtransactions', RealmList<FinancialSubtransaction>(subtransactions));
  }

  FinancialTransaction._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Category? get category =>
      RealmObjectBase.get<Category>(this, 'category') as Category?;
  @override
  set category(covariant Category? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  int get price => RealmObjectBase.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObjectBase.set(this, 'price', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  RealmList<FinancialSubtransaction> get subtransactions =>
      RealmObjectBase.get<FinancialSubtransaction>(this, 'subtransactions')
          as RealmList<FinancialSubtransaction>;
  @override
  set subtransactions(covariant RealmList<FinancialSubtransaction> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<FinancialTransaction>> get changes =>
      RealmObjectBase.getChanges<FinancialTransaction>(this);

  @override
  Stream<RealmObjectChanges<FinancialTransaction>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FinancialTransaction>(this, keyPaths);

  @override
  FinancialTransaction freeze() =>
      RealmObjectBase.freezeObject<FinancialTransaction>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'name': name.toEJson(),
      'category': category.toEJson(),
      'price': price.toEJson(),
      'date': date.toEJson(),
      'subtransactions': subtransactions.toEJson(),
    };
  }

  static EJsonValue _toEJson(FinancialTransaction value) => value.toEJson();
  static FinancialTransaction _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'price': EJsonValue price,
        'date': EJsonValue date,
      } =>
        FinancialTransaction(
          fromEJson(id),
          fromEJson(name),
          fromEJson(price),
          fromEJson(date),
          category: fromEJson(ejson['category']),
          subtransactions: fromEJson(ejson['subtransactions']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FinancialTransaction._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, FinancialTransaction, 'FinancialTransaction', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
      SchemaProperty('price', RealmPropertyType.int),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('subtransactions', RealmPropertyType.object,
          linkTarget: 'FinancialSubtransaction',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
