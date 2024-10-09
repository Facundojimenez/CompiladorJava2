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
    private String rellenar(String str, int length) {
        return String.format("%"+ length + "s", str);
    }
    @Override
    public String toString(){
        //Armado de la tabla
        String numeracion = "|";
        String out = "|";
        int max;
        String elem, num;
        for (int i = 0; i < listaElementos.size(); i++) {
            elem = listaElementos.get(i);
            num = ""+(i+1);
            max = elem.length() > num.length() ? elem.length() : num.length();
            numeracion += rellenar(num, max) +"|";
            out += rellenar(elem, max)+ "|";
        }
        return numeracion+"\n"+out;
    }

}
