import java.util.Date;

public class Main {

    public static String getMessage() {
        Date currentDate = new Date();
        return "Hello, Docker! Current date: " + currentDate;
    }

    public static void main(String[] args) {
        System.out.println(getMessage());
    }
}
