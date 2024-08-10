import { Stack } from 'expo-router';

import { RealmProvider } from '@realm/react';
import realm from '@/models';

export default function RootLayout() {
    return (
        <RealmProvider realm={realm}>
            <Stack>
                <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
                <Stack.Screen name="(auth)" options={{ headerShown: false }} />
            </Stack>
        </RealmProvider>
    );
}
