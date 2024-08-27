package lyc.compiler.symboltable;

import java.util.HashMap;

public class SymbolTable {
    static private SymbolTable instancia = null; //clase singleton
    private HashMap<String,Simbolo> tabla;

    private SymbolTable(){
        this.tabla = new HashMap<String,Simbolo>();
    }

    public static SymbolTable getSymbolTable(){
        if (instancia == null){
            instancia = new SymbolTable();
        }
        return SymbolTable.instancia;
    }

    public void add(String nombre,String tipo,String valor,int longitud, boolean esConstante){
        nombre = nombre.replace(" ","_");//para evitar problemas al pasar el codigo a ASM

        //En caso de que un token sea CTE de algun tipo, se le agrega el prefijo "_"
        if(esConstante){
            nombre = "_"+nombre;
        }

        //agregar si no existe
        if (!this.tabla.containsKey(nombre)){
            this.tabla.put(nombre,new Simbolo(tipo,valor,longitud));
        } 
        //manejar duplicados aqui
        //
    }
    
    @Override
    public String toString(){
        String out = "";
        for (String k : tabla.keySet()) {
            out+="Nombre: " + k + "\t\t" + tabla.get(k) + "\n";
        }
        return out;
    }



}
