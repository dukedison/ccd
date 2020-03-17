
@if(Session::has('Mensaje')){{
    Session::get('Mensaje')
}}
@endif
<a href="{{ url('productos/create') }}">Agregar Producto</a>

<table class="table table-light">
    <thead class="thead-light">
        <tr>
            <th>#</th>
            <th>Foto</th>
            <th>Nombre</th>
            <th>Descripcion</th>
            <th>Precio</th>
            <th>Acciones</th>
        </tr>
    </thead>

    <tbody>
        @foreach($productos as $producto)
        <tr>
            <td>{{$loop->iteration}}</td>
            <td>
            <img src="{{ asset('storage').'/'.$producto->foto}}" alt="" width="200">
            </td>
            <td>{{$producto->nombre}}</td>
            <td>{{$producto->descripcion}}</td>
            <td>{{$producto->precio}}</td>
            <td>
                
            <a href="{{ url('/productos/'.$producto->idProducto.'/edit') }}">
            Editar
            </a>

            <form method="post" action="{{ url('/productos/'.$producto->idProducto) }}" >
            {{ csrf_field() }}
            {{ method_field('DELETE') }}
            <button type="submit" onclick="return confirm('¿Borrar?');">Borrar</button>
            </form>
            </td>
        </tr>
        @endforeach
    </tbody>
</table>