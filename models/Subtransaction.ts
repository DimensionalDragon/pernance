import Realm from "realm";

class Subtransaction extends Realm.Object {
    static schema = {
      name: "Subtransaction",
      properties: {
        _id: "objectId",
        transaction: "Transaction",
        name: "string",
        price: "int",
      },
      primaryKey: "_id",
    };
}

export default Subtransaction;