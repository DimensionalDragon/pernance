import "package:powersync/powersync.dart";

const categorySchema = Table(
  'category',
  [ 
    Column.text('name'),
    Column.integer('budget'),
    Column.text('created_at'), 
    Column.text('user_id')
  ]
);