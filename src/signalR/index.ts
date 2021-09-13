import * as signalR from '@microsoft/signalr';
import store from '@/store';

const connection = new signalR.HubConnectionBuilder()
    // .configureLogging(signalR.LogLevel.Trace)
    .withUrl(`${process.env.VUE_APP_API}/hubs/views`)
    .build();

connection.on('viewCountUpdate', (value: number) => {
    store.commit('views/setViews', value, { root: true });
});

// eslint-disable-next-line import/prefer-default-export
export function notify(): void {
    connection.send('notifyWatching');
}

export async function startConnection(): Promise<void> {
    try {
        await connection.start();
        console.log('Hub connected');
        notify();
    } catch (error) {
        console.log('Hub connection failed', error);
    }
}

export function isConnected(): boolean {
    return connection.state === signalR.HubConnectionState.Connected;
}
