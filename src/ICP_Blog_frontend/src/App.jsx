import BlogForm from './BlogForm';
import MostrarForm from './MostrarForm';
import ActualizarForm from './ActualizarFrom';
import EliminarForm from './EliminarForm';
import Like from './likeform';
import Comentario from './Comentario';

function App() {
  return (
    <div>
      <h2>Crear nuevo blog</h2>
      <BlogForm />
      <h2>Buscar blog</h2>
      <MostrarForm />
      <h2>Actualizar blog</h2>
      <ActualizarForm />
      <h2>Eliminar blog</h2>
      <EliminarForm />
      <h2>Dar Like</h2>
      <Like />
      <h2>Agregar comentario</h2>
      <Comentario />
    </div>
  );
}

export default App;
