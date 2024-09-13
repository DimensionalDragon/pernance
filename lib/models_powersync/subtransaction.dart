import "package:powersync/powersync.dart";

const subtransactionSchema = Table(
  'subtransactions',
  [ 
    Column.text('name'),
    Column.integer('price'),
    Column.text('transaction_id'),
    Column.text('created_at'), 
    Column.text('user_id')
  ],
  indexes: [
    Index('transaction', [IndexedColumn('transaction_id')])
  ]
);