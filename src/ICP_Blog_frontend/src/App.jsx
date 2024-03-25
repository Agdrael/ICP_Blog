import { useState } from 'react';
import { ICP_Blog_backend } from 'declarations/ICP_Blog_backend';
import BlogForm from './BlogForm';

function App() {
  return (
    <div>
      <h1>Crear nuevo blog</h1>
      <BlogForm />
      <h2>Form creados</h2>
    </div>
  );
}

export default App;
