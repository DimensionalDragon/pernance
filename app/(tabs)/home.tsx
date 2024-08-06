import { Text, View, StyleSheet, ScrollView } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LineChart } from 'react-native-gifted-charts';

import HomeTransactionsList from '@/components/home/HomeTransactionsList';
import HomeCategoriesList from '@/components/home/HomeCategoriesList';

export default function home() {
    const chartDummyData = [{ value: 50 }, { value: 80 }, { value: 90 }, { value: 70 }];
    const transactionsDummyData = [{ name: "T1", amount: 10 }, { name: "T2", amount: 20 }, { name: "T3", amount: 30 }];
    const categoriesDummyData = [{ name: "Category 1", icon: "icon1" }, { name: "Category 2", icon: "icon2" }, { name: "Category 3", icon: "icon3" }, { name: "Category 4", icon: "icon4" }, { name: "Category 5", icon: "icon5" }, { name: "Category 6", icon: "icon6" },];

    return (
        <SafeAreaView style={styles.container}>
            <ScrollView>
                <View style={styles.chartContainer}>
                    <LineChart data={chartDummyData} height={100} />
                </View>
                <View>
                    <View>
                        <Text>Today's transactions</Text>
                    </View>
                    <View style={styles.container}>
                        <HomeTransactionsList transactions={transactionsDummyData} />
                    </View>
                </View>
                <View>
                    <View> 
                        <Text>This month's budget</Text>
                    </View>
                    <View style={styles.container}>
                        <HomeCategoriesList categories={categoriesDummyData} />
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
        paddingHorizontal: 10,
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
    },
    chartContainer: {
        backgroundColor: 'white',
        padding: 20,
        margin: 10,
        borderRadius: 10,
        
        shadowColor: '#000',
        shadowOffset: {
          width: 0,
          height: 2,
        },
        shadowOpacity: 0.25,
        shadowRadius: 4,
        elevation: 5, 
    },
    debug: {
        borderColor: 'blue',
        borderWidth: 2,
    }
});