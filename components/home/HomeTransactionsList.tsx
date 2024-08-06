import { StyleSheet, View } from "react-native";
import HomeTransaction from "./HomeTransaction";

type Transaction = {
    name: string;
    amount: number;
}

type HomeTransactionsListProps = {
    transactions: Array<Transaction>;
}

export default function HomeTransactionsList({transactions}: HomeTransactionsListProps) {
    return (
        <View style={styles.container}>
            {transactions.map(({name, amount}) => (
                <HomeTransaction key={name} name={name} amount={amount} />
            ))}
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        alignItems: 'center',
    },
});