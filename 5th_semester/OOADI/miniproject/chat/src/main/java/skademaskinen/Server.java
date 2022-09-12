package skademaskinen;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Server 
{
    static ServerSocket socket;
    public static Map<Integer, Socket> clients = new HashMap<>();
    public static boolean isRunning = true;
    public static void main( String[] args ) throws IOException{
        Scanner scanner = new Scanner(System.in);
        socket = new ServerSocket(8888);
        Thread thread = new Thread(new ClientAcceptHandler());
        thread.start();
        for(String line = ""; !line.equals("exit"); line = scanner.nextLine()){
            broadcast(line);
            System.out.print("[server] > ");
        }
        scanner.close();
        socket.close();
        isRunning = false;
    }
    public static void broadcast(String message) throws IOException{
        for(Socket client : clients.values()){
            Writer writer = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()));
            writer.write(message+"\n");
            System.out.println("attempted to broadcast message '"+message+"'");
            writer.flush();
        }
    }
}
