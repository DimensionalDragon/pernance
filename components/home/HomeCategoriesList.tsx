import { ScrollView, StyleSheet } from "react-native";
import HomeCategory from "./HomeCategory";

import Category from "@/models/Category";

type HomeCategoriesListProps = {
    categories: Array<Category>;
}

export default function HomeCategorysList({categories}: HomeCategoriesListProps) {
    return (
        <ScrollView horizontal={true} style={styles.container}>
            {categories.map((category, i) => (
                <HomeCategory key={category.name} idx={i} category={category} amount={10} />
            ))}
        </ScrollView>
    )
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
    },
});