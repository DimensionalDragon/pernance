import { BSON } from "realm";
import realm from "@/models";

export const seedDatabase = () => {
    try {
      realm.write(() => {
        // Check if data already exists
        if (realm.objects('User').length === 0) { 
          // Create users
          realm.create('User', {
            _id: new BSON.ObjectId(),
            firebaseUID: 'user1',
            name: 'John Doe',
            email: 'john.doe@example.com',
          });
          // Create categories
          const category1 = realm.create('Category', {
            _id: new BSON.ObjectId(),
            name: 'Food',
            budget: 500,
          });
          const category2 = realm.create('Category', {
            _id: new BSON.ObjectId(),
            name: 'Entertainment',
            budget: 200,
          });
          // Create transactions
          realm.create('Transaction', {
            _id: new BSON.ObjectId(),
            name: 'Grocery Shopping',
            amount: 150,
            category: category1, 
          });
          // Create periodic transactions
          realm.create('PeriodicTransaction', {
            _id: new BSON.ObjectId(),
            name: 'Netflix Subscription',
            price: 15,
            periodInDays: 30,
            isPaid: false,
          });
          // ... add more seed data as needed
        }
      });
    } catch (error) {
      console.error('Error seeding database: ', error);
    }
  };
export default realm;