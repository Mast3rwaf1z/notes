package skademaskinen;

import java.io.IOException;
import java.net.MalformedURLException;

public class App 
{
    public static void main( String[] args ) throws MalformedURLException, IOException{
        double x[] = {1, 2, 3, 4, 50};        
        double h[] = {};
        double y[] = doConvolution(x, h);
        Plotter.makePlot(y, "n", "value");


        
    }
    public static double[] doConvolution(double x[], double h[]){
        
        return x;
    }
}
