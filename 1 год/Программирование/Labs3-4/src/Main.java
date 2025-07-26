import Characters.Chipollino;
import Characters.MisterTomato;
import Characters.Vinogradinka;
import Characters.Client;
import Locations.Street;
import Locations.Workshop;
import Records.FriendsGroup;
import Enums.Status;


public class Main {
    public static void main(String[] args) {

        Street street = new Street();

        Workshop workshop = new Workshop("Мастерская", 52);
        Chipollino chipollino = new Chipollino(workshop);
        workshop.addWorker(chipollino);
        System.out.println();

        chipollino.waxing();
        chipollino.liningSoles();
        chipollino.shoePads();
        chipollino.measure();

        chipollino.joke();
        chipollino.getStatus();
        System.out.println();

        Vinogradinka vinogradinka = new Vinogradinka(workshop);
        workshop.addWorker(vinogradinka);
        System.out.println();

        Client client1 = new Client("Алексей Евгеньевич", Status.FUNNY, street); //, street);
        Client client2 = new Client("Бобрусь", Status.HAPPY, street);//, street);
        Client client3 = new Client("Антон Вальерьевич", Status.GOOD, street);//, street);
        System.out.println();

        client1.goInto(workshop);
        client2.goInto(workshop);
        client3.goInto(workshop);
        System.out.println();

        vinogradinka.joy();
        vinogradinka.getStatus();
        System.out.println();

        MisterTomato misterTomato = new MisterTomato(workshop);
        misterTomato.getStatus();
        misterTomato.cry();
        chipollino.setStatus(Status.BRAVE);
        chipollino.getStatus();
        System.out.println();

        FriendsGroup friendsGroup = new FriendsGroup();
        friendsGroup.addFriend(chipollino);
        friendsGroup.addFriend(client1);
        friendsGroup.addFriend(client2);
        friendsGroup.addFriend(client3);
        System.out.println();

    }
}

