package lyc.compiler.symboltable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

    public boolean exists(String nombre){
        nombre = nombre.replace(" ","_");
        return tabla.containsKey(nombre);
    }

    public void add(String nombre,String tipo,String valor,int longitud, boolean esConstante){
        nombre = nombre.replace(" ","_");//para evitar problemas al pasar el codigo a ASM

        //En caso de que un token sea CTE de algun tipo, se le agrega un "_"
        if(esConstante){
            nombre = "_"+nombre;
        }

        //agregar si no existe
        if (!this.tabla.containsKey(nombre)){
            this.tabla.put(nombre,new Simbolo(tipo,valor,longitud, false));
            return;
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

        ArrayList<String> simbolosSinUtilizar = this.getUnusedSymbols();

        if(!simbolosSinUtilizar.isEmpty()){
            out += "\n\nWARNING -> Simbolos sin utilizar: \n";
            for(String elem : getUnusedSymbols()){
                out += elem + ", ";
            }

        }

        return out;
    }

    public ArrayList<String> getUnusedSymbols (){
        ArrayList<String> unusedSymbolsList = new ArrayList<String>();
        for (Map.Entry<String, Simbolo> entry : tabla.entrySet()) {
            String key = entry.getKey();
            Simbolo simbolo = entry.getValue();

            if(simbolo.valor == null && !simbolo.utilizado){
                unusedSymbolsList.add(key);
            }
        }
        return unusedSymbolsList;
    }

    public Simbolo getSymbol(String nombre){
        return tabla.get(nombre);
    }

    public void emptySymbolTableContent(){
        tabla.clear();
    }

    public void markSymbolAsUsed(String nombre){
        Simbolo elemento = tabla.get(nombre);
        elemento.utilizado = true;
        tabla.replace(nombre, elemento);
    }

}
