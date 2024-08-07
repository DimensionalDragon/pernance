import Realm from "realm";

class Transaction extends Realm.Object {
    static schema = {
      name: "Transaction",
      properties: {
        _id: "objectId",
        user: "User", // Relationship to User
        name: "string",
        category: "Category", // Relationship to Category
        price: "int",
        date: "date",
        subtransactions: "Subtransaction[]"
      },
      primaryKey: "_id",
    };
}

export default Transaction;