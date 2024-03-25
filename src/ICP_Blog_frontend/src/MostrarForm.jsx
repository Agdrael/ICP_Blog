import { useState } from 'react';
import { ICP_Blog_backend } from 'declarations/ICP_Blog_backend';

function MostrarForm() {
    const [blog, setBlog] = useState('');
    const handleSubmit = async (event) => {
        event.preventDefault();
        const id = parseInt(event.target.elements.blogId.value, 10);
        //Llamando back end luego asignarlo a una promesa
        ICP_Blog_backend.cambioVerBlogs(id).then((blog) => {
            setBlog(blog);
            console.log("Usuario:", blog.usuario); // Agregar console.log para imprimir el usuario
            console.log("Contenido:", blog.contenido); // Agregar console.log para imprimir el contenido
            console.log("Likes:", blog.likes); // Agregar console.log para imprimir los likes
       
        });
        return false;
    };


    return (

        <div>
            <form action="#" onSubmit={handleSubmit}>
                <div>
                    <label htmlFor="blogId">Id del blog:</label>
                    <input id="blogId" type='number' />
                </div>
                <button type="submit">Buscar</button>
            </form>

            {blog && (
                <div>
                    <pre>{JSON.stringify(blog, null, 2)}</pre>
                </div>
            )}

        </div>
    );
}

export default MostrarForm;