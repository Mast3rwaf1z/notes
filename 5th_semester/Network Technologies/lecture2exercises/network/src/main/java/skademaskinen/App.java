package skademaskinen;

public class App 
{
    public static void main( String[] args ) throws InterruptedException{

        Network.startNetwork(4);
        Thread.sleep(1000);
        for(int i = 0; i < 4; i++){
            System.out.println("Adding a message to device #"+i+" receive queue");
            Network.transmit(i, "this is a message");
            Thread.sleep(1000);
        }
        Network.shutdown();
    }
}
