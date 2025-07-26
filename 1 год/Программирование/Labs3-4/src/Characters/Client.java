package Characters;

import Exceptions.CapacityException;
import Exceptions.RemoveNonExistingPeopleException;
import Locations.Place;
import Enums.Status;

import java.util.Objects;

public class Client extends Character {

    public Client(String name, Status status, Place currentPlace){
        super(name, status, currentPlace);
    }



    @Override
    public String toString() {
        return "Клиент " + name;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null ||this.getClass() != obj.getClass()) {return false; }
        Client client = (Client) obj;
        return this.name.equals(client.name) && this.status.equals(client.status) && this.currentPlace.equals(client.currentPlace);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, status, currentPlace) + 52;
    }

}
