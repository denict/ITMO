package Characters;
import Enums.Status;
import Interfaces.Workable;
import Locations.Place;


public class Workers extends Character implements Workable {
    public Workers(String name, Status status, Place currentPlace) {
        super(name, status, currentPlace);

    }

    @Override
    public void waxing() {
        System.out.println(this.name + " натирает воском дратву");

    }

    @Override
    public void liningSoles() {
        System.out.println(this.name + " подбивает подметки");

    }

    @Override
    public void shoePads() {
        System.out.println(this.name + " ставит набойки");
    }

    @Override
    public void measure() {
        System.out.println(this.name + " измеряет");

    }

}
