package mypokemons;

import mymoves.physical.AquaTail;
import mymoves.physical.PinMissile;
import mymoves.physical.PoisonSting;
import mymoves.special.AcidSpray;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Qwilfish extends Pokemon{

    public Qwilfish(String name, int level) {
        super(name, level);

        super.setType(Type.WATER, Type.POISON);
        super.setStats(
              65, // hd
                 95, // attack
                 85, // defense
                 55, // speed attack
                 55, // speed defense
                 85 // speed
                );
        PinMissile pinMissile = new PinMissile();
        AcidSpray acidSpray = new AcidSpray();
        AquaTail aquaTail = new AquaTail();
        PoisonSting poisonSting = new PoisonSting();
        super.setMove(pinMissile, acidSpray, aquaTail, poisonSting);
    }
}
