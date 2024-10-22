package mypokemons;

import mymoves.physical.Facade;
import mymoves.physical.LeechLife;
import mymoves.physical.WaterFall;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Wimpod extends Pokemon{

    public Wimpod(String name, int level) {
        super(name, level);

        super.setType(Type.BUG, Type.WATER);
        super.setStats(
                25, // hd
                35, // attack
                40, // defense
                20, // speed attack
                30, // speed defense
                80 // speed
        );
        WaterFall waterFall = new WaterFall();
        Facade facade = new Facade();
        LeechLife leechLife = new LeechLife();
        super.setMove(waterFall, facade, leechLife);
    }
}