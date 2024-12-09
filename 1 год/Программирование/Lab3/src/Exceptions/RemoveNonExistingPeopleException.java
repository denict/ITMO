package Exceptions;

public class RemoveNonExistingPeopleException extends Exception {

    public RemoveNonExistingPeopleException(String message) {
        super(message);
    }
    @Override
    public String getMessage() {
        return "Удаление несуществующих людей";
    }

}
