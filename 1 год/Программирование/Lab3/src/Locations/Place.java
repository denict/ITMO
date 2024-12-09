package Locations;
import Exceptions.CapacityException;
import Exceptions.RemoveNonExistingPeopleException;

import java.util.ArrayList;
import java.util.Objects;
import Characters.Character;

public abstract class Place {
    protected String name;
    protected int capacity;
    protected ArrayList<Character> people = new ArrayList<>();
    
    public String getName() {
        return this.name;
    }

    public void addPeople(Character person) throws CapacityException {
        if (people.size() + 1 > capacity) {
            throw new CapacityException("Превышение количества посетителей");
        }
        people.add(person);
    }
    public void removePeople(Character person) throws RemoveNonExistingPeopleException {
        if (!people.remove(person)) {
            throw new RemoveNonExistingPeopleException("Обнаружена ошибка: Удаление несуществующих людей");
        }
    }

    @Override
    public String toString() {
        return "Place is " + name;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null ||this.getClass() != obj.getClass()) {
            return false;
        }
        Place place = (Place) obj;
        return this.capacity == place.capacity && this.name.equals(place.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, capacity) + 52;
    }

}
