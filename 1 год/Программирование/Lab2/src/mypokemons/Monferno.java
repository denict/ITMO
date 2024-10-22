package mypokemons;

import mymoves.status.SlackOff;
//import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Monferno extends Chimchar{

    public Monferno(String name, int level) {
        super(name, level);

        super.setType(Type.FIRE, Type.FIGHTING);
        super.setStats(
                64, // hd
                78, // attack
                52, // defense
                78, // speed attack
                52, // speed defense
                81 // speed
        );
        SlackOff slackOff = new SlackOff();
        super.addMove(slackOff);
    }
}
