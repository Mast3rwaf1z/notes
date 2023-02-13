package skademaskinen;

import org.jline.reader.LineReader;
import org.jline.reader.LineReaderBuilder;

public class CLI implements Runnable {
    private boolean IsRunning = true;

    @Override
    public void run() {
        LineReader reader = LineReaderBuilder.builder().build();
        for(String line = ""; !line.equals("exit"); line = reader.readLine("> ")){
        }
        IsRunning = false;
        System.exit(0);
        
    }

    public boolean isRunning(){
        return IsRunning;
    }
    
}
