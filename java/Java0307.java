public class Java0307{
     public static void main(String []args){
        // ���� 2, ���� 3, ���� 10 �̓��䐔��̘a
        int n = 10;
        int a = 2;
        int r = 3;
        System.out.println((int) (a * (Math.pow(r, n) - 1)) / (r - 1) );
    }
}
