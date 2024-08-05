import HomeTransactionsList from '@/components/home/HomeTransactionsList';
import { Text, View, StyleSheet, ScrollView } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LineChart } from 'react-native-gifted-charts';

export default function home() {
    const chartDummyData = [{ value: 50 }, { value: 80 }, { value: 90 }, { value: 70 }];
    const transactionsDummyData = [{ name: "T1", amount: 10 }, { name: "T2", amount: 20 }, { name: "T3", amount: 30 }];

    return (
        <SafeAreaView style={styles.container}>
            <ScrollView>
                <View>
                    {/* <LineChart data={chartDummyData} /> */}
                    <Text>Graph</Text>
                </View>
                <View>
                    <View>
                        <Text>Today's transactions</Text>
                    </View>
                    <View>
                        <HomeTransactionsList transactions={transactionsDummyData} />
                    </View>
                </View>
                <View>
                    <View> 
                        <Text>This month's budget</Text>
                    </View>
                    <View>
                        <View>
                            <Text>TODO: HomeCategoriesList</Text>
                        </View>
                    </View>
                </View>
                <View>
                    <View>
                        <Text>Upcoming expenses</Text>
                    </View>
                    <View>
                        <View>
                            <Text>TODO: HomeTransactionList</Text>
                        </View>
                    </View>
                </View>
            </ScrollView>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
});