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
            console.log(blog);
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
                    {blog.map((blogItem, index) => (
                        <div key={index}>
                            <p>Usuario: {blogItem.usuario}</p>
                            <p>Contenido: {blogItem.contenido}</p>
                            <p>Likes: {blogItem.likes}</p>

                            {/* Generar cada comentario */}
                            <div>
                                {blogItem.comentarios && blogItem.comentarios.map((comentario, comentarioIndex) => (
                                    <p key={comentarioIndex}>Comentario {comentarioIndex + 1}: {comentario}+","</p>
                                ))}
                            </div>
                        </div>
                    ))}
                </div>
            )}




        </div>
    );
}

export default MostrarForm;