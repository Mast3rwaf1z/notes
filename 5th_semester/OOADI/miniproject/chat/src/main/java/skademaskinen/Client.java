package skademaskinen;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Scanner;

public class Client {
    public static boolean isRunning = true;
    public static int id;
    public static void main(String[] args) throws UnknownHostException, IOException {
        Scanner scanner = new Scanner(System.in);
        id = Integer.parseInt(args[0]);
        Network.setSocket();
        Thread thread = new Thread(new ReceiveListener());
        thread.start();
        for(String line = ""; !line.equals("exit"); line = scanner.nextLine()){
            Network.transmit(line);
            System.out.print("[client #"+id+"] > ");
        }
        scanner.close();
        isRunning = false;
    }
}
