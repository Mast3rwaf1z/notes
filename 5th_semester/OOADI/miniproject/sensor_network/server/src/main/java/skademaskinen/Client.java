package skademaskinen;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class Client implements Runnable{
    private Socket socket;

    public Client(Socket socket){
        this.socket = socket;
    }

    @Override
    public void run() {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String in;
            while ((in = reader.readLine()) != null){
                System.out.println(in);
            }
            System.out.println("Closed connection...");
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
