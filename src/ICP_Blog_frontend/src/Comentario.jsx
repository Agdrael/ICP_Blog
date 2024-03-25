import { useState } from 'react';
import { ICP_Blog_backend } from 'declarations/ICP_Blog_backend';

function Comentario() {
    const [blog, setBlog] = useState('');
    const handleSubmit = async (event) => {
        event.preventDefault();
        const id = parseInt(event.target.elements.blogId.value, 10);
        const comentario = event.target.elements.comentario.value;

        //Llamando back end luego asignarlo a una promesa
        ICP_Blog_backend.agregarComentario(id, comentario).then((blog) => {
            setBlog(blog);
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
                <div>
                    <label>Contenido:</label>
                    <textarea id="comentario" alt="comentario"></textarea>
                </div>
                <button type="submit">Agregar comentario</button>
            </form>

        </div>
    );
}

export default Comentario;