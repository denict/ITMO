package Exceptions;

public class CapacityException extends Exception{

    public CapacityException(String message) {
        super(message);
    }

    @Override
    public String getMessage() {
        return "Превышение количества мест";
    }

}
