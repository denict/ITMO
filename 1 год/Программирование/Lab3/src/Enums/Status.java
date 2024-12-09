package Enums;

import java.util.ArrayList;

public enum Status {
    SAD("грустный"),
    HAPPY("счастливый"),
    FUNNY("веселый"),
    BRAVE("смелый"),
    GOOD("хороший"),
    DEPRESIVE("депресивный"),
    BAD("плохой");


    private String status;

    Status(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return status;
    }

    public static ArrayList<String> getStatuses() {
        ArrayList<String> statuses = new ArrayList<>();
        for (Status status : Status.values()) {
            statuses.add(status.toString());
        }
        return statuses;
    }
}
