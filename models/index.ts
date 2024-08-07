import Realm from "realm";
import User from "./User"; 
import Transaction from "./Transaction"; 
import Subtransaction from "./Subtransaction";
import Category from "./Category";
import PeriodicTransaction from "./PeriodicTransaction";
import Saving from "./Saving";

const realm = new Realm({
    schema: [User, Transaction, Subtransaction, Category, PeriodicTransaction, Saving] 
});
export default realm;