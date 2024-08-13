// Import the functions you need from the SDKs you need
import { deleteItemAsync, setItemAsync } from "expo-secure-store";
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
import { getAuth, onIdTokenChanged } from "firebase/auth";
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: process.env.EXPO_PUBLIC_API_KEY,
  authDomain: process.env.EXPO_PUBLIC_AUTH_DOMAIN,
  projectId: process.env.EXPO_PUBLIC_PROJECT_ID,
  storageBucket: process.env.EXPO_PUBLIC_STORAGE_BUCKET,
  messagingSenderId: process.env.EXPO_PUBLIC_MESSAGING_SENDER_ID,
  appId: process.env.EXPO_PUBLIC_APP_ID
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firebase Authentication and get a reference to the service
export const auth = getAuth(app);

onIdTokenChanged(auth, async (user) => {
  if (user) {
    // User is signed in or token was refreshed
    const newJwt = await user.getIdToken();
    await setItemAsync('userToken', newJwt); 
  } else {
    // User is signed out
    await deleteItemAsync('userToken');
  }
});

export default app;