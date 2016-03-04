public class Java0503 {
    public static void main(String []args) {
        for (int degree = -90; degree <= 90; degree += 15) {
            if ((degree + 90) % 180 != 0) {
                double radian = Math.toRadians(degree);
                double x2     = radian * radian;
                // ����̐��ڊ֐�
                double d1     = myTan(radian, x2, 15, 0.0); // 15:�K�v�Ȑ��x��������\���傫�Ȋ
                // �W���̐��ڊ֐�
                double d2     = Math.tan(radian);
                // �W���֐��Ƃ̍���
                System.out.println(String.format("%3d : %13.10f - %13.10f = %13.10f", degree, d1, d2, d1 - d2));
            }
        }
    }

    // ����̐��ڊ֐�
    private static double myTan(double x, double x2, int n, double t) {
        t = x2 / (n - t);
        n -= 2;  
        if (n <= 1) 
            return x / (1 - t);
        else
            return myTan(x, x2, n, t);
    }
}
