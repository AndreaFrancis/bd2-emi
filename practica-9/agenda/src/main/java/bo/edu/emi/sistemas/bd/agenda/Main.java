package bo.edu.emi.sistemas.bd.agenda;

import bo.edu.emi.sistemas.bd.agenda.modelos.Contacto;
import bo.edu.emi.sistemas.bd.agenda.repositorios.RepositorioContactos;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        RepositorioContactos rep = new RepositorioContactos();
        Contacto andrea = new Contacto();
        andrea.setNombre("Arnol");

        //rep.guardar(andrea);

        //System.out.print(andrea.getId());

        List<Contacto>  contactos = rep.listar();
        for (Contacto c : contactos) {
            System.out.print("Nombre: "+ c.getNombre());
        }
    }
}
