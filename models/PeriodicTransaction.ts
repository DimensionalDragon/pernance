import Realm, {BSON} from "realm";

class PeriodicTransaction extends Realm.Object {
  _id!: BSON.ObjectId;
  name!: string;
  price!: number;
  periodInDays!: number;
  is_paid!: boolean;

  static schema = {
    name: "PeriodicTransaction",
    properties: {
      _id: "objectId",
      name: "string",
      price: "int",
      periodInDays: "int",
      isPaid: "bool"
    },
    primaryKey: "_id",
  };
}

export default PeriodicTransaction;