import Realm, {BSON} from "realm";
import Transaction from "./Transaction";

class Subtransaction extends Realm.Object {
  _id!: BSON.ObjectId;
  transaction!: Transaction;
  name!: string;
  price!: number;

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