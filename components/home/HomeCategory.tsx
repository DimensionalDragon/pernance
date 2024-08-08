import { StyleSheet, Text, View } from "react-native";

import Category from "@/models/Category";

import { MaterialIcons } from "@expo/vector-icons";

type HomeCategoryProps = {
    category: Category;
    amount: number;
    idx: number
}

export default function HomeCategory({category, amount, idx}: HomeCategoryProps) {
    return (
        <View style={[styles.container, idx > 0 && styles.innerItem]}>
            <View style={styles.iconContainer}>
                <MaterialIcons name='shop' size={24} color="black" />
            </View>
            <Text>{category.name}</Text>
            <Text>{amount}</Text>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'column',
        alignItems: 'center',
    },
    iconContainer: {
        width: 50,
        height: 50,
        borderRadius: 25, 
        borderWidth: 3,
        borderColor: 'green', 
        justifyContent: 'center',
        alignItems: 'center',
    },
    innerItem: { // Not first and not last
        marginLeft: 15
    }
});