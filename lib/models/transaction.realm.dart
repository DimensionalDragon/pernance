// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Transaction extends $Transaction
    with RealmEntity, RealmObjectBase, RealmObject {
  Transaction(
    ObjectId id,
    String name,
    int price,
    DateTime date, {
    User? user,
    Category? category,
    Iterable<Subtransaction> subtransactions = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'user', user);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set<RealmList<Subtransaction>>(
        this, 'subtransactions', RealmList<Subtransaction>(subtransactions));
  }

  Transaction._();

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
  RealmList<Subtransaction> get subtransactions =>
      RealmObjectBase.get<Subtransaction>(this, 'subtransactions')
          as RealmList<Subtransaction>;
  @override
  set subtransactions(covariant RealmList<Subtransaction> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Transaction>> get changes =>
      RealmObjectBase.getChanges<Transaction>(this);

  @override
  Stream<RealmObjectChanges<Transaction>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Transaction>(this, keyPaths);

  @override
  Transaction freeze() => RealmObjectBase.freezeObject<Transaction>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'user': user.toEJson(),
      'name': name.toEJson(),
      'category': category.toEJson(),
      'price': price.toEJson(),
      'date': date.toEJson(),
      'subtransactions': subtransactions.toEJson(),
    };
  }

  static EJsonValue _toEJson(Transaction value) => value.toEJson();
  static Transaction _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
        'name': EJsonValue name,
        'price': EJsonValue price,
        'date': EJsonValue date,
      } =>
        Transaction(
          fromEJson(id),
          fromEJson(name),
          fromEJson(price),
          fromEJson(date),
          user: fromEJson(ejson['user']),
          category: fromEJson(ejson['category']),
          subtransactions: fromEJson(ejson['subtransactions']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Transaction._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, Transaction, 'Transaction', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'User'),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
      SchemaProperty('price', RealmPropertyType.int),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('subtransactions', RealmPropertyType.object,
          linkTarget: 'Subtransaction',
          collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
