package skademaskinen;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;

public class Network {
    final static private int port = 8888;
    static public Socket socket;
    public static void transmit(String message) throws IOException{
        OutputStreamWriter writer = new OutputStreamWriter(socket.getOutputStream());
        writer.write(message);

    }
    public static String receive() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        return reader.readLine();
    }
    public static void setSocket() throws UnknownHostException, IOException{
        socket = new Socket("localhost", port);
    }
}
