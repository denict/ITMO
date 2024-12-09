package Characters;

import Enums.Status;
import Interfaces.Cryable;
import Locations.Place;

public class MisterTomato extends Character implements Cryable {
    public MisterTomato(Place currentPlace) {
        super("Кавалер Помидор", Status.SAD, currentPlace);
        this.name = "Кавалер Помидор";
        this.status = Status.SAD;
    }

    @Override
    public void cry() {
        System.out.println(this.name + " плачет");
    }





}
