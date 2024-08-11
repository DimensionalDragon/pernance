import { createUserWithEmailAndPassword, getAuth, updateProfile } from 'firebase/auth';
import { useState } from 'react';
import { Text, View, StyleSheet, TextInput } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler';
import { SafeAreaView } from 'react-native-safe-area-context';

import validator from 'validator'

export default function register() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [name, setName] = useState('');

    const auth = getAuth();

    const handleRegistration = async () => {
        // 1. Validate form data (e.g., check for empty fields, valid email format)
        if (!validator.isEmail(email))
            // TODO: Create error screen and activate it here
            return;
        // 2. Send registration data to your backend API (e.g., using fetch or axios)
        const userCredential = await createUserWithEmailAndPassword(auth, email, password)
        try {
            const user = userCredential.user;
            await updateProfile(user, {displayName: name})
            const jwt = user.getIdToken();
            // TODO: store in SecureStorage
        } catch (error) {
            console.log(error);
        }
                
        // 3. Handle success (e.g., navigate to the login screen) or error (e.g., display error message)
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

                <Text style={styles.label}>Name: <Text style={styles.required}>*</Text></Text>
                <TextInput
                    style={styles.input}
                    value={name}
                    onChangeText={setName}
                />
                
                <TouchableOpacity style={styles.button} onPress={handleRegistration} disabled={!email || !password || !name}>
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
});