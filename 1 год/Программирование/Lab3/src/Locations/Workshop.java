package Locations;
import Characters.Workers;
import Exceptions.WorkerNotFoundException;
import Interfaces.Workable;
import java.util.ArrayList;
import java.util.Objects;

public class Workshop extends Place{
    
    Workers[] workers;

    public Workshop(String name, int capacity) {
        this.name = name;
        this.capacity = capacity;
        workers = new Workers[capacity];
    }

    public void addWorker(Workers worker) {
        try {
            for (int i = 0; i < workers.length; i++) {
                if (workers[i] == null) {
                    workers[i] = worker;
                    break;
                }
            }
            System.out.println("Рабочий " + worker.getName() + " начал работу в " + this.name + ".");
        }
        catch (ArrayIndexOutOfBoundsException e) { //unchecked Exception
            System.out.println(e.getMessage());
        }
    }

    public void removeWorker(Workers worker) throws WorkerNotFoundException {
        boolean isRemoved = false;
        for (int i = 0; i < workers.length; i++) {
            if (workers[i].equals(worker)) {
                workers[i] = null;
                isRemoved = true;
                System.out.println("Рабочий " + worker.getName() + " закончил работу в " + this.name + ".");
                break;
            }
        }
        if (!isRemoved) throw new WorkerNotFoundException("Такого работника нет");
    }

    @Override
    public String toString() {

        return "Workshop is " + name;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null || this.getClass() != obj.getClass()) {
            return false;
        }
        Workshop workshop = (Workshop) obj;
        return this.capacity == workshop.capacity &&  this.name.equals(workshop.name)
                && this.workers.equals(workshop.workers);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, capacity, workers) + 52;
    }

}
