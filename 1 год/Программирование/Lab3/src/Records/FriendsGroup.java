package Records;

import java.util.ArrayList;
import Characters.Character;

public record FriendsGroup(ArrayList<Character> friends) {
    public FriendsGroup(){

        this(new ArrayList<Character>());
    }
    public void addFriend(Character friend) {
        this.friends.add(friend);
        System.out.println(friend.getName() + " добавлен в друзья.");
    }

    public void removeFriend(Character friend) {
        this.friends.remove(friend);
        System.out.println(friend.getName() + " удален из друзей.");
    }

    public boolean checkFriend(Character friend) {
        return this.friends.contains(friend);
    }

}
