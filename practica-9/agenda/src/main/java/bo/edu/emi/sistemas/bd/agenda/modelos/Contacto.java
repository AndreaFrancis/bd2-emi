package bo.edu.emi.sistemas.bd.agenda.modelos;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "contacto")
public class Contacto implements Serializable  {
    @Id
    @GeneratedValue
    private Long id;

    @Basic
    private String nombre;

    @Basic
    private String numero;

    @Temporal(TemporalType.DATE)
    private Date cumpleanios;

    public Contacto() {
    }

    public Contacto(Long id, String nombre, String numero) {
        this.id = id;
        this.nombre = nombre;
        this.numero = numero;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Date getCumpleanios() {
        return cumpleanios;
    }

    public void setCumpleanios(Date cumpleanios) {
        this.cumpleanios = cumpleanios;
    }
}
