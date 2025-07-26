package Characters;
import Enums.Status;
import Interfaces.Joyfulable;
import Interfaces.Workable;
import Locations.Place;

public class Vinogradinka extends Workers implements Workable, Joyfulable {
    public Vinogradinka(Place currentPlace) {
        super("Виноградинка", Status.HAPPY, currentPlace);
    }


    @Override
    public void waxing() {
        System.out.println(this.name + "натирает воском дратву");
    }
    @Override
    public void liningSoles() {
        System.out.println(this.name + "подбивает подметки");
    }
    @Override
    public void shoePads() {
        System.out.println(this.name + "ставил набойки");
    }
    @Override
    public void measure() {
        System.out.println(this.name + "снимал мерку с ног заказчиков");
    }

    @Override
    public void joy() {
        System.out.println(this.name + " радуется");
    }

}
