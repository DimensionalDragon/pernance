import { Tabs } from "expo-router";

import {MaterialIcons} from "@expo/vector-icons"

export default function MainLayout() {
    return (
        <Tabs>
            <Tabs.Screen name='home' options={{
                headerShown: false,
                tabBarIcon: ({ color, size }) => (
                    <MaterialIcons name="home" color={color} size={size} />
                )
             }} />
            <Tabs.Screen name='transactions' options={{ 
               tabBarIcon: ({ color, size }) => (
                <MaterialIcons name="money-off" color={color} size={size} />
               )
             }} />
        </Tabs>
    )
}