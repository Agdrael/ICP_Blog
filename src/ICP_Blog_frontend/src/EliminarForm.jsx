import { useState } from 'react';
import { ICP_Blog_backend } from 'declarations/ICP_Blog_backend';

function EliminarForm() {
    const [blog, setBlog] = useState('');
    const handleSubmit = async (event) => {
        event.preventDefault();
        const id = parseInt(event.target.elements.blogId.value, 10);
        //Llamando back end luego asignarlo a una promesa
        ICP_Blog_backend.eliminarBlog(id).then((blog) => {
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
                <button type="submit">Eliminar</button>
            </form>

        </div>
    );
}

export default EliminarForm;