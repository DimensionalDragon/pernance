import Realm from "realm";

class Category extends Realm.Object {
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