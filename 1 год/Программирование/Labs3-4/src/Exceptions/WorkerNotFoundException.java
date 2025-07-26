package Exceptions;

public class WorkerNotFoundException extends Exception {
    public WorkerNotFoundException(String message) {
        super(message);
        
    }

    @Override
    public String getMessage() {
        return "Такого работника нет";
    }
}