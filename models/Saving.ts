import Realm, {BSON} from "realm";
import Transaction from "./Transaction";

class Saving extends Realm.Object {
  _id!: BSON.ObjectId;
  balance!: number;
  incomeSources!: Transaction[];

  static schema = {
    name: "Saving",
    properties: {
      _id: "objectId",
      balance: "int",
      incomeSources: "Transaction[]"
    },
    primaryKey: "_id",
  };
}

export default Saving;