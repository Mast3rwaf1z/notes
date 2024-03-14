import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class MSP {
    static int processor_count = 4;

    public static void main(String[] args) throws InterruptedException, ExecutionException {
        int size = args.length > 0 ? Integer.parseInt(args[0]) : 10000;
        String type = args.length > 1 ? args[1] : "both";
        int[][] array = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                array[i][j] = new Random().nextInt(10 + 10) - 10;
            }
        }
        if(type.equalsIgnoreCase("seq") || type.equalsIgnoreCase("both")){
            long seq_pre = System.currentTimeMillis();
            int seq_result = AlgorithmMSP_Sequential(array, size, size);
            long seq_post = System.currentTimeMillis();
            System.out.println("Sequential result:         " + Integer.toString(seq_result));
            System.out.println("Sequential Execution time: " + Long.toString((seq_post - seq_pre)) + " milliseconds");
        }
        if(type.equalsIgnoreCase("para") || type.equalsIgnoreCase("both")){
            long para_pre = System.currentTimeMillis();
            int para_result = AlgorithmMSP_Parallel(array, size, size);
            long para_post = System.currentTimeMillis();
            System.out.println("Parallel result:           " + Integer.toString(para_result));
            System.out.println("Parallel Execution time:   " + Long.toString((para_post - para_pre)) + " milliseconds");
        }
    }
        
        
    public static int AlgorithmMSP_1D(int[] a, int n) {
        int min_pSum = 0;
        int pSum[] = new int[n + 1];
        int maxA = Integer.MIN_VALUE;
        for (int i = 1; i < n+1; i++) {
            pSum[i] = pSum[i-1] + a[i-1];
            maxA = maxA >= pSum[i] - min_pSum ? maxA : pSum[i] - min_pSum;
            min_pSum = min_pSum <= pSum[i] ? min_pSum : pSum[i];
        }
        return maxA;
    }

    public static int AlgorithmMSP_Sequential(int[][] A, int N, int M) {
        int maxA = Integer.MIN_VALUE;
        for (int i = 0; i < N; i++) {
            int[] temp = new int[M];
            for (int k = i; k < N; k++) {
                for (int j = 0; j < M; j++) {
                    temp[j] = temp[j] + A[j][k];
                }
                int pSum = AlgorithmMSP_1D(temp, M);
                if (pSum > maxA) {
                    maxA = pSum;
                }
            }
        }
        return maxA;
    }


    public static ArrayList<Integer> task(int[][] A, int i, int N, int M)
            throws InterruptedException, ExecutionException {
        int[] temp = new int[M];
        ArrayList<Integer> Sums = new ArrayList<Integer>();
        for (int k = i; k < N; k++) {
            for (int j = 0; j < M; j++) {
                temp[j] = temp[j] + A[j][k];
            }
            Sums.add(AlgorithmMSP_1D(temp, M));
        }
        return Sums;
    }

    public static int AlgorithmMSP_Parallel(int[][] A, int N, int M) throws InterruptedException, ExecutionException {
        int maxA = Integer.MIN_VALUE;
        ExecutorService outer_pool_executor = Executors.newFixedThreadPool(processor_count);
        ArrayList<Future<ArrayList<Integer>>> processes = new ArrayList<Future<ArrayList<Integer>>>();
        for (int i = 0; i < N; i++) {
            final int index = i;
            processes.add(outer_pool_executor.submit(() -> task(A, index, N, M)));
        }
        ArrayList<Integer> results = new ArrayList<Integer>();
        for (Future<ArrayList<Integer>> future : processes) {
            for (Integer integer : future.get()) {
                results.add(integer);
            }
        }
        maxA = Collections.max(results);
        outer_pool_executor.shutdown();
        return maxA;
    }
}