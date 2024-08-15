import { getAuth, signInWithEmailAndPassword } from 'firebase/auth';
import { useState } from 'react';
import { Text, View, StyleSheet, TextInput } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler';
import { SafeAreaView } from 'react-native-safe-area-context';

import { setItemAsync } from 'expo-secure-store';
import validator from 'validator'

export default function login() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const [error, setError] = useState('');

    const auth = getAuth();

    const handleRegistration = async () => {
        // 1. Validate form data (e.g., check for empty fields, valid email format)
        if (!validator.isEmail(email)) {
          setError('Invalid email, please enter a valid email address');
          return;
        }
        try {
          // 2. Send registration data to your backend API (e.g., using fetch or axios)
          const userCredential = await signInWithEmailAndPassword(auth, email, password);
          const user = userCredential.user;

          // 3. Handle success (e.g., navigate to the login screen) or error (e.g., display error message)
          const jwt = user.getIdToken();
          await setItemAsync('userToken', jwt);
        } catch (error) {
          if (error instanceof Error)
            setError(error.message);
        }
                
    };

    return (
        <SafeAreaView>
            <View style={styles.container}>
                <Text style={styles.label}>Email: <Text style={styles.required}>*</Text></Text>
                <TextInput
                    style={styles.input}
                    value={email}
                    onChangeText={setEmail}
                    keyboardType="email-address"
                />
                
                <Text style={styles.label}>Password: <Text style={styles.required}>*</Text></Text>
                <TextInput
                    style={styles.input}
                    value={password}
                    onChangeText={setPassword}
                    secureTextEntry 
                />

                {error && (
                    <View style={styles.errorContainer}>
                        <Text>{error}</Text>
                    </View>
                )}
                
                <TouchableOpacity style={styles.button} onPress={handleRegistration} disabled={!email || !password}>
                    <Text style={styles.buttonText}>Register</Text>
                </TouchableOpacity>
            </View>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
    },
    label: {
        fontSize: 16,
        marginBottom: 5,
    },
    input: {
        borderWidth: 1,
        borderColor: '#ccc',
        padding: 10,
        marginBottom: 15,
        borderRadius: 5,
    },
    required: {
        color: 'red',
    },
    button: {
        backgroundColor: '#007bff', // Example blue color
        padding: 15,
        borderRadius: 8,
        alignItems: 'center', 
        marginTop: 20, // Add some spacing
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
    errorContainer: {
        width: '100%',
        textAlign: 'center',
        borderRadius: 2,
        backgroundColor: 'red',
        padding: 5,
    }
});