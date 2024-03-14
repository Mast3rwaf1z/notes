package skademaskinen;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Network {
    static private Map<Integer, Node> nodes = new HashMap<>();
    static public Lock lock = new ReentrantLock();
    private static boolean isRunning = true;
    
    public static void transmit(int nodeId, String message){
        Node node = nodes.get(nodeId);
        node.receiveQueue.add(message);
    }

    public static void startNetwork(int numNodes){
        for(int i = 0; i < numNodes; i++){
            Node node = new Node(i);
            Thread thread = new Thread(node);
            lock.lock();
            thread.start();
            nodes.put(i, node);
            lock.unlock();
        }
    }

    public static boolean isRunning() {
        return isRunning;
    }

    public static void shutdown(){
        System.out.println("shutting down system...");
        isRunning = false;
    }
}
