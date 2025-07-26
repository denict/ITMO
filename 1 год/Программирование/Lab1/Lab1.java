// variant 31727

public class Lab1 {
    // create arrays
    static short[] z = new short[17];
    static double[] x = new double[19];
    static double[][] z1 = new double[17][19];

    // filling method with required calculated numbers for filling z1-array
    public static double calculate(int i, int j) {
        switch (z[i]) {
            case 14:
                return Math.pow(((Math.atan(Math.cos(x[j])) - 1) / 3), Math.pow(x[j], x[j]/2));
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 10:
            case 13:
            case 16:
                return Math.atan(1/Math.exp(Math.exp(Math.pow(2 * Math.asin((x[j] - 1.5) / 25), 3))));
            default:
                return Math.pow(Math.log(Math.sqrt(Math.abs(x[j]) / 2 * Math.PI)) / (Math.tan(Math.cbrt(Math.pow(x[j], 2))) + 1), 3);
        }
    }

    // Matrix output method for z1-array
    public static void matrixprint(double[][] z1) {
        for (int i = 0; i < z1.length; i++) {
            for (int j = 0; j < z1[i].length; j++) {
                System.out.printf("%6.3f\t", z1[i][j]);
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {


        // filling z-array with required numbers
        final short START = 2;
        for (short i = START; i < z.length + START; i++) {
            z[i - START] = i;
        }

        // filling x-array with required random in the range from -14.0 to 11
        final double MAX = 11d;
        final double MIN = -14d;
        for (int i = 0; i < x.length; i++) {
            x[i] = Math.random() * (MAX - MIN) + MIN;
        }


        // filling z1-array with required calculated numbers
        for (int i = 0; i < z1.length; i++) {
            for (int j = 0; j < z1[i].length; j++) {
                z1[i][j] = calculate(i, j);
            }
        }

        // matrix output
        matrixprint(z1);

    }
}
