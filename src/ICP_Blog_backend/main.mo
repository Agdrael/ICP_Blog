import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import List "mo:base/List";
import Trie "mo:base/Trie";

actor Blog{
  //estableciendo blog_id como nat
  public type blog_Id = Nat32;
  
  //asegurandose que empiece en 0
  private stable var next: blog_Id =0;

  //Obejto blog
  public type blog_Obj ={
    usuario: Text;
    contenido: Text;
    likes: Nat32;
    comentarios: List.List<Text>;
  };

  //creando tabla hash para almacenar los blogs
  private stable var blogAlmacen: Trie.Trie<blog_Id,blog_Obj> = Trie.empty();

  //crear objeto Blog + almacenamiento
  public func crearBlog(usuario: Text, contenido: Text, likes: Nat32, comentarios: List.List<Text>) : async blog_Id{
    let blog_Id = next;
  };

  
};


