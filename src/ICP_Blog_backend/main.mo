import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import List "mo:base/List";
import Trie "mo:base/Trie";


actor{
  //estableciendo blog_id como nat
  public type blog_Id = Nat32;
  
  //asegurandose que empiece en 0
  private stable var next: blog_Id =0;

  //definir objeto tipo blog
  public type blog_Obj ={
    usuario: Text;
    contenido: Text;
    likes: Nat32;
    comentarios: List.List<Text>;
  };

  //creando tabla hash para almacenar los blogs
  private stable var blogAlmacen: Trie.Trie<blog_Id,blog_Obj> = Trie.empty();

  //Creando llave para el Trie
  private func key(x: blog_Id) : Trie.Key<blog_Id>
  {
    return {hash = x; key = x};
  };

  //crear objeto Blog + almacenamiento
  public func crearBlog(blog : blog_Obj) : async blog_Id{
    
    //Generar nuevo ID
    let blog_Id = next;
    next +=1;

    //almacenando un nuevo blog
    blogAlmacen := Trie.replace(
      blogAlmacen,
      key(blog_Id),
      Nat32.equal,
      ?blog,
    ).0;
    return blog_Id;
  };

  //Ver un blog
  public query func verBlogs(blog_Id: blog_Id): async ?blog_Obj{
    let resultado = Trie.find(blogAlmacen, key(blog_Id),Nat32.equal);
    return resultado;   
  }

  
};


