package skademaskinen;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class ClientAcceptHandler implements Runnable{

    @Override
    public void run() {
        while(Server.isRunning){

            try {
                Socket socket = Server.socket.accept();
                BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                int id = Integer.parseInt(reader.readLine());
                Server.clients.put(id, socket);
                reader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
    }
    
}
