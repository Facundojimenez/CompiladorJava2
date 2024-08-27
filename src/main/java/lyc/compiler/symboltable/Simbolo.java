package lyc.compiler.symboltable;

public class Simbolo {
    String tipo;
    String valor;
    int longitud;

    public Simbolo(String tipo,String valor,int longitud){
        this.tipo = tipo;
        this.valor = valor;
        this.longitud = longitud;
    }
    public void setLongitud(int longitud) {
        this.longitud = longitud;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public void setValor(String valor) {
        this.valor = valor;
    }
    public int getLongitud() {
        return longitud;
    }
    public String getTipo() {
        return tipo;
    }
    public String getValor() {
        return valor;
    }
    @Override
    public String toString(){
        return "Tipo: "+ tipo + "\t\t" + " Valor: " + valor  + "\t\t" + " Longitud: "+ longitud;
    }
}