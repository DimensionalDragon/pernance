import Realm from "realm";

class User extends Realm.Object {
    static schema = {
      name: "User",
      properties: {
        _id: "objectId", // Primary key
        firebase_uid: "string",
        name: "string",
        email: "string",
      },
      primaryKey: "_id",
    };
}

export default User