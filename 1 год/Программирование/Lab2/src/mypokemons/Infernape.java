package mypokemons;

import mymoves.status.CalmMind;
//import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Infernape extends Monferno{

    public Infernape(String name, int level) {
        super(name, level);

        super.setType(Type.FIRE, Type.FIGHTING);
        super.setStats(
                76, // hd
                104, // attack
                71, // defense
                104, // speed attack
                71, // speed defense
                108 // speed
        );

        CalmMind calmMind = new CalmMind();
        super.addMove(calmMind);
    }
}
