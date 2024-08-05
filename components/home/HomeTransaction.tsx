import { StyleSheet, Text, View } from "react-native";

type HomeTransactionProps = {
    name: string;
    amount: number;
}

export default function HomeTransaction({name, amount}: HomeTransactionProps) {
    return (
        <View style={styles.container}>
            <Text>{name}</Text>
            <Text>{amount}</Text>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        width: '100%',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        borderColor: 'red',
        borderWidth: 2,
    },
});