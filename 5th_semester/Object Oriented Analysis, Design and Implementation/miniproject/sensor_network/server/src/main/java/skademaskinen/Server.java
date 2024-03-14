package skademaskinen;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class Server 
{
    static List<Client> clients = new ArrayList<>();
    static CLI cli = new CLI();
    public static void main( String[] args ) throws IOException{
        ServerSocket socket = new ServerSocket(8888);
        Thread cliThread = new Thread(cli);
        cliThread.start();
        while(cli.isRunning()){
            System.out.println("Server ready!");
            Socket clientSocket = socket.accept();
            Client client = new Client(clientSocket);
            clients.add(client);
            Thread thread = new Thread(client);
            thread.start();
        }
        socket.close();
    }
}
