package bo.edu.emi.sistemas.bd.agenda.repositorios;

import bo.edu.emi.sistemas.bd.agenda.modelos.Contacto;
import bo.edu.emi.sistemas.bd.agenda.utilitarios.Conexion;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class RepositorioContactos {
    public Contacto guardar(Contacto c) {
        Session session = Conexion.getSesion().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(c);
            tx.commit();
        }
        catch (RuntimeException e) {
            tx.rollback();
            throw e;
        }
        finally {
            session.close();
        }

        return c;
    };

    public List<Contacto> listar() {
        Session session = Conexion.getSesion().getCurrentSession();
        session.beginTransaction();

        List<Contacto> result = (List<Contacto>)session.createQuery("from Contacto").list();
        session.getTransaction().commit();

        return result;
    }
}
