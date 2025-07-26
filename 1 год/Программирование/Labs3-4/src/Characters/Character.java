package Characters;
import Enums.Status;
import Exceptions.CapacityException;
import Exceptions.RemoveNonExistingPeopleException;
import Locations.Place;

import java.util.Objects;

public abstract class Character {
    protected String name;
    protected Status status;
    protected Place currentPlace;

    public Character(String name, Status status, Place place) {
        this.name = name;
        this.status = status;
        goInto(place);
    }


    public void goInto(Place place) {
        if (currentPlace != null && place != null && currentPlace.equals(place)) return; // повторное вхождение
        try {
            place.addPeople(this);
            if (currentPlace != null)
                currentPlace.removePeople(this);
            this.currentPlace = place;
            System.out.println(this.name + " вошел в " + place.getName() + ".");
        } catch (RemoveNonExistingPeopleException | CapacityException e) {
            System.out.println("Обнаружена ошибка: " + e.getMessage());
        }
    }


    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void getStatus() {
        System.out.println(name + " " +  status);
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return name;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null || this.getClass() != obj.getClass()) {return false; }
        Character character = (Character) obj;
        return this.name.equals(character.name) && this.status.equals(character.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, status) + 52;
    }


}
