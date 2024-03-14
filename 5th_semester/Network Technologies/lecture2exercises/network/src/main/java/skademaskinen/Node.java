package skademaskinen;

import java.util.ArrayList;
import java.util.List;

public class Node implements Runnable{
    int id;
    List<String> receiveQueue = new ArrayList<>();

    public Node(int id){
        this.id = id;
    }

    @Override
    public void run() {
        System.out.println("node #" + id + " started");
        Network.lock.lock();
        Network.lock.unlock();
        while(Network.isRunning()){
            if(receiveQueue.size() > 0){
                String message = receiveQueue.remove(0);
                System.out.println(message);
            }
        }
    }
    
}
