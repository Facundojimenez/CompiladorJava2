package lyc.compiler.polacaInversa;

import java.util.ArrayList;

public class PolacaInversa {
    static private PolacaInversa instancia = null; //clase singleton
    private ArrayList<String> listaElementos;

    private PolacaInversa(){
        this.listaElementos = new ArrayList<String>();
    }

    //Inicialización de clase Singleton
    public static PolacaInversa getPolacaInversa(){
        if (instancia == null){
            instancia = new PolacaInversa();
        }
        return PolacaInversa.instancia;
    }

    public void insertar(String elemento){
        this.listaElementos.add(elemento);
    }
    public void reemplazar(int posicion, String valor){
        this.listaElementos.set(posicion, valor);
    }
    public int size(){
        return this.listaElementos.size();
    }

    @Override
    public String toString(){
        String out = "|";
        for (String listaElemento: this.listaElementos) {
            out += listaElemento + "|";
        }
        return out;
    }
}
