package skademaskinen;

import java.io.IOException;

public class ReceiveListener implements Runnable{

    @Override
    public void run() {
        while(Client.isRunning){
            try {
                String message = Network.receive();
                System.out.println("\n"+message);
                if(message == null){
                    System.exit(0);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
}
