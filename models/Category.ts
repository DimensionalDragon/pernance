import Realm, {BSON} from "realm";
import Transaction from "./Transaction";

class Category extends Realm.Object {
    _id!: BSON.ObjectId;
    name!: string;
    budget!: number;
    transactions!: Transaction[];

    static schema = {
      name: "Category",
      properties: {
        _id: "objectId",
        name: "string",
        budget: "int",
        transactions: "Transaction[]"
      },
      primaryKey: "_id",
    };
}

export default Category;