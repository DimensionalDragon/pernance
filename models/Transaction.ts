import Realm, {BSON} from "realm";
import User from "./User";
import Category from "./Category";
import Subtransaction from "./Subtransaction";

class Transaction extends Realm.Object {
  _id!: BSON.ObjectId;
  user!: User;
  name!: string;
  category!: Category;
  price!: number;
  date!: Date;
  subtransactions!: Subtransaction[];

  static schema = {
    name: "Transaction",
    properties: {
      _id: "objectId",
      user: "User",
      name: "string",
      category: "Category",
      price: "int",
      date: "date",
      subtransactions: "Subtransaction[]"
    },
    primaryKey: "_id",
  };
}

export default Transaction;