package Randoms;

import java.util.ArrayList;

public enum Names {
    PISMAK("Алексей Евгеньевич"),
    OSTAPENKO("Ольга Денисовна"),
    ZELNITSKAYA("Екатерина Юрьевна"),
    POLYAKOV("Владимир Иванович"),
    GAVRILOV("Антон Валерьевич"),
    MARTYNOVA("Дарья Олеговна"),
    ZHIRKOVA("Галина Петровна"),
    PRAVDIN("Константин Владимирович"),
    SAVCHENKO("Татьяна Владимировна"),
    VATUTIN("Александр Дмитриевич"),
    KLIMENKOV("Сергей Викторович"),
    BALAKSHIN("Павел Валерьевич");

    private String name;
    Names() {};
    Names(String name) {
        this.name = name;
    }
    @Override
    public String toString() {
        return name;
    }
    public static ArrayList<String> getNames() {
        ArrayList<String> names = new ArrayList<>();
        for (Names name : Names.values()) {
            names.add(name.name);
        }
        return names;
    }
}
