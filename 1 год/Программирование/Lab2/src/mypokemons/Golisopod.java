package mypokemons;

import mymoves.physical.LeechLife;
import mymoves.physical.WaterFall;
import mymoves.physical.Facade;
import mymoves.status.SwordsDance;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Golisopod extends Pokemon{

    public Golisopod(String name, int level) {
        super(name, level);

        super.setType(Type.BUG, Type.WATER);
        super.setStats(
                75, // hd
                125, // attack
                140, // defense
                60, // speed attack
                90, // speed defense
                40 // speed
        );
        WaterFall waterfall = new WaterFall();
        Facade facade = new Facade();
        LeechLife leechLife = new LeechLife();
        SwordsDance swordsDance = new SwordsDance();
        super.setMove(waterfall, facade, leechLife, swordsDance);
    }
}
