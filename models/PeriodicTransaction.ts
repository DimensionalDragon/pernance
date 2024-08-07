import Realm from "realm";

class PeriodicTransaction extends Realm.Object {
    static schema = {
      name: "PeriodicTransaction",
      properties: {
        _id: "objectId",
        name: "string",
        price: "int",
        period_in_days: "int",
        is_paid: "bool"
      },
      primaryKey: "_id",
    };
}

export default PeriodicTransaction;