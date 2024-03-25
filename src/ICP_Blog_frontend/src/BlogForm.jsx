import { useState } from 'react';
import { ICP_Blog_backend } from 'declarations/ICP_Blog_backend';

function BlogForm() {
    const [blog, setBlog] = useState('');


    const handleSubmit = async (event) => {
      event.preventDefault();
      const usuario = event.target.elements.usuario.value;
      const contenido = event.target.elements.contenido.value;

      //Llamando back end luego asignarlo a una promesa
      ICP_Blog_backend.crearBlog(usuario,contenido).then((blog) =>{
        setBlog(blog);
      });
      return false;
    };
  
    return (
        <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="usuario">Usuario:</label>
          <input id="usuario" alt="Usuario" type="text"/>
        </div>
        <div>
          <label>
            Contenido: 
          </label>
         <textarea id="contenido" alt="Contenido"></textarea>
        </div>
        <button type="submit">Publicar</button>
      </form>
    );
  }
  
  export default BlogForm;