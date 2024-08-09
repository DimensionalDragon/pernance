import Realm, {BSON} from "realm";

class User extends Realm.Object {
  _id!: BSON.ObjectId;
  firebaseUID!: string;
  name!: string;
  email!: string;

  static schema = {
    name: "User",
    properties: {
      _id: "objectId",
      firebaseUID: "string",
      name: "string",
      email: "string",
    },
    primaryKey: "_id",
  };
}

export default User