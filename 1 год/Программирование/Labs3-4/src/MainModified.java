import Characters.Chipollino;
import Characters.Client;
import Characters.MisterTomato;
import Characters.Vinogradinka;
import Enums.Status;
import Locations.Street;
import Locations.Workshop;
import Randoms.Names;
import Records.FriendsGroup;

import java.util.ArrayList;
import java.util.Random;

public class MainModified {
    public static void main(String[] args) {
        ArrayList<String> names = Names.getNames();
        Status[] statuses = Status.values();
        Random random = new Random();

        Street street = new Street();
        Workshop workshop = new Workshop("Мастерская", random.nextInt(5, 52));

        Chipollino chipollino = new Chipollino(workshop);
        workshop.addWorker(chipollino);
        chipollino.waxing();
        chipollino.liningSoles();
        chipollino.shoePads();
        chipollino.measure();
        System.out.println();

        chipollino.joke();
        chipollino.getStatus();
        System.out.println();

        Vinogradinka vinogradinka = new Vinogradinka(workshop);
        workshop.addWorker(vinogradinka);
        System.out.println();

        ArrayList<Client> clients = new ArrayList<Client>();

        for (int i = 0; i < random.nextInt(2, 10); i++) {
            int nameIndex = random.nextInt(names.size());
            int statusIndex = random.nextInt(statuses.length);
            Client client = new Client(names.get(nameIndex), Status.valueOf(statuses[statusIndex].name()), street); // сопоставление имени переменной в Enum
            client.getStatus();
            clients.add(client);
        }
        System.out.println();
        for (Client client : clients) {
            client.goInto(workshop);
        }
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
        for(int i = 0; i < random.nextInt(clients.size()); i++) {
            int friendIndex = random.nextInt(clients.size());
            if (!friendsGroup.checkFriend(clients.get(friendIndex)))
                friendsGroup.addFriend(clients.get(friendIndex));
        }

    }
}
