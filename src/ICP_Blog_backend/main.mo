import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import List "mo:base/List";
import Trie "mo:base/Trie";
import Error "mo:base/Error";
import Nat "mo:base/Nat";

actor {
  //estableciendo blog_id como nat
  public type blog_Id = Nat32;

  //asegurandose que empiece en 0
  private stable var next : blog_Id = 0;

  //definir objeto tipo blog
  public type blog_Obj = {
    usuario : Text;
    contenido : Text;
    likes : Nat32;
    comentarios : List.List<Text>;
  };

  //creando tabla hash para almacenar los blogs
  private stable var blogAlmacen : Trie.Trie<blog_Id, blog_Obj> = Trie.empty();

  //Creando llave para el Trie
  private func key(x : blog_Id) : Trie.Key<blog_Id> {
    return { hash = x; key = x };
  };

  //Creando tipo error
  public type ups = {
    msg : Text;
  };

  //crear objeto Blog + almacenamiento desde 0. solo para testing

  public func crearBlog(blog : blog_Obj) : async blog_Id {

    //Generar nuevo ID
    let blog_Id = next;
    next += 1;

    //almacenando un nuevo blog
    blogAlmacen := Trie.replace(
      blogAlmacen,
      key(blog_Id),
      Nat32.equal,
      ?blog,
    ).0;
    return blog_Id;
  };

  //Blog de usuarios normales
  public func blogNormal(usuario : Text, contenido : Text) : async blog_Id {
    let blog = {
      usuario = usuario;
      contenido = contenido;
      //casting para que no exista problema de conversion de Nat32 ya que 0 es Nat
      likes = Nat32.fromNat(0);
      comentarios = List.nil<Text>();
    };

    let blogId = await crearBlog(blog);
    return blogId;
  };

  public func cambioVerBlogs(numero : Nat) : async ?blog_Obj {
    let conversion = Nat32.fromNat(numero);
    await verBlogs(conversion);
  };

  //Ver un blog
  public query func verBlogs(blog_Id : blog_Id) : async ?blog_Obj {
    let resultado = Trie.find(blogAlmacen, key(blog_Id), Nat32.equal);
    return resultado;
  };

  //actualizar un blog
  public func actualizarContenido(blogId : blog_Id, nuevoContenido : Text) : async ?ups {
    // Buscar el blog en el almacén
    let blog = await verBlogs(blogId);

    // Si el blog no existe, retornar un error
    switch (blog) {
      case (null) {
        return ?{ msg = "Blog no encontrado" };
      };

      case (?blogObj) {
        // Crear un nuevo objeto blog con el contenido actualizado
        let blogActualizado = {
          usuario = blogObj.usuario;
          contenido = nuevoContenido;
          likes = blogObj.likes;
          comentarios = blogObj.comentarios;
        };

        // Reemplazar el blog en el almacén con el nuevo contenido
        blogAlmacen := Trie.replace(
          blogAlmacen,
          key(blogId),
          Nat32.equal,
          ?blogActualizado,
        ).0;

        // Retornar un mensaje de éxito
        return ?{ msg = "Contenido del blog actualizado" };
      };

    };
  };

  //eliminar un blog
  public func eliminarBlog(blogId : blog_Id) : async ?ups {
    let resultado = Trie.remove(blogAlmacen, key(blogId), Nat32.equal);
    //.0 es el nuevo resultado, .1 sera el eliminado y en caso de no existir = null
    switch (resultado.1) {
      case (null) {
        return ?{ msg = "Blog no encontrado" };
      };

      case (_) {
        blogAlmacen := resultado.0;
        return ?{ msg = "Blog eliminado" };
      };
    };
  };

  //dar un like a un blog
  public func like(blog_Id : blog_Id) : async ?blog_Obj {
    await actualizarLikes(blog_Id);
  };

  private func actualizarLikes(blogId : blog_Id) : async ?blog_Obj {
    let blog = await verBlogs(blogId);
    //sitch para recibir nulo u objeto
    switch (blog) {
      case (null) {
        throw Error.reject("Blog no encontrado");
      };

      case (?blogObjt) {
        let nuevoLike = blogObjt.likes +1;
        // no se puede hacer esto: blogObjt.likes = nuevoLike;
        // se debe crear un nuevo objeto con las nuevas propiedades
        let ObjBlogActualizado = {
          usuario = blogObjt.usuario;
          contenido = blogObjt.contenido;
          likes = nuevoLike;
          comentarios = blogObjt.comentarios;
        };

        //remplazando los valores actualizados
        blogAlmacen := Trie.replace(
          blogAlmacen,
          key(blogId),
          Nat32.equal,
          ?ObjBlogActualizado,
        ).0;

        return ?ObjBlogActualizado;
      };
    };
  };

  // agregar un comentario a un blog
  public func agregarComentario(blogId : blog_Id, comentario : Text) : async ?ups {

    // Buscar el blog en el almacén
    let blog = await verBlogs(blogId);

    // Si el blog no existe, retornar un error
    switch (blog) {
      case (null) {
        return ?{ msg = "Blog no encontrado" };
      };

      case (?blogObj) {

        // Crear una lista con el nuevo comentario
        let nuevoComentarioLista = List.push(comentario, blogObj.comentarios);

        // Crear un nuevo objeto blog con la lista de comentarios actualizada
        let blogActualizado = {
          usuario = blogObj.usuario;
          contenido = blogObj.contenido;
          likes = blogObj.likes;
          comentarios = nuevoComentarioLista;
        };

        // Reemplazar el blog en el almacén con el nuevo contenido
        blogAlmacen := Trie.replace(
          blogAlmacen,
          key(blogId),
          Nat32.equal,
          ?blogActualizado,
        ).0;

        // Retornar un mensaje de éxito
        return ?{ msg = "Comentario agregado al blog" };
      };

    };
  };

};
