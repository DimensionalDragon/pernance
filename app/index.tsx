import { Redirect } from "expo-router";
import { getItem } from "expo-secure-store";

export default function Index() {
    const userToken = getItem('userToken');
    if(!userToken) {
        return <Redirect href="./(auth)/login" />
    }
    return <Redirect href="/home" />
}
