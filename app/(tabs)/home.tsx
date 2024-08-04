import { Text, View, SafeAreaView, StyleSheet } from 'react-native';
import { LineChart } from 'react-native-gifted-charts';

export default function home() {
    const data = [{ value: 50 }, { value: 80 }, { value: 90 }, { value: 70 }];
    return (
        <SafeAreaView style={styles.container}>
            <View>
                <Text>Main dashboard</Text>
            </View>
            <View>
                <LineChart data={data} />
                <Text>Graph</Text>
            </View>
            <View>
                <Text>More graphs</Text>
            </View>
            <View>
                <Text>Navbar</Text>
            </View>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
});