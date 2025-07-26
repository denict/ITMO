package Characters;
import Interfaces.Jokeable;
import Interfaces.Workable;
import Enums.Status;
import Locations.Place;

public class Chipollino extends Workers implements Workable, Jokeable {
    public Chipollino(Place currentPlace) {
        super("Чиполлино", Status.HAPPY, currentPlace);
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
        System.out.println(this.name + " ставил набойки");
    }
    @Override
    public void measure() {
        System.out.println(this.name + " снимал мерку с ног заказчиков");
    }

    @Override
    public void joke() {
        System.out.println(this.name + " не переставал шутить");
    }


}
