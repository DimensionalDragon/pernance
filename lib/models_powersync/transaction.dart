import "package:powersync/powersync.dart";

const transactionSchema = Table(
  'transaction',
  [ 
    Column.text('name'),
    Column.text('category_id'),
    Column.integer('price'),
    Column.text('date'),
    Column.text('created_at'), 
    Column.text('user_id')
  ],
  indexes: [
    Index('category', [IndexedColumn('category_id')])
  ]
);