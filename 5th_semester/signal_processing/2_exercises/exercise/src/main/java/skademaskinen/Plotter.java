package skademaskinen;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.googlecode.charts4j.AxisLabelsFactory;
import com.googlecode.charts4j.Data;
import com.googlecode.charts4j.GCharts;
import com.googlecode.charts4j.Plots;
import com.googlecode.charts4j.ScatterPlot;

public class Plotter {
    public static void makePlot(double data[], String xaxis, String yaxis) throws MalformedURLException, IOException{
        double time[] = {1,2,3,4,5};
        ScatterPlot plot = GCharts.newScatterPlot(Plots.newScatterPlotData(new Data(time), new Data(data)));
        plot.setGrid(10, 10, 10, 10);
        plot.addXAxisLabels(AxisLabelsFactory.newNumericAxisLabels());
        plot.addYAxisLabels(AxisLabelsFactory.newNumericAxisLabels());
        plot.addRightAxisLabels(AxisLabelsFactory.newAxisLabels(Arrays.asList(xaxis)));
        plot.addTopAxisLabels(AxisLabelsFactory.newAxisLabels(Arrays.asList(yaxis)));
        
        plot.setSize(500, 300);
        try(InputStream in = new URL(plot.toURLString()).openStream()){
            File file = new File("./image.jpg");
            file.delete();
            Files.copy(in, Paths.get("./image.jpg"));
        }

}
public static List<String> lengthLabels(int length){
    List<String> result = new ArrayList<>();
    for (int i = 0; i < length; i++) {
        result.add(String.valueOf(i));
    }
    return result;
}
}
