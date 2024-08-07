import Realm from "realm";

class Saving extends Realm.Object {
    static schema = {
      name: "Saving",
      properties: {
        _id: "objectId",
        balance: "int",
        income_sources: "Transaction[]"
      },
      primaryKey: "_id",
    };
}

export default Saving;