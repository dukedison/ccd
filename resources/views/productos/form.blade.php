{{ $Modo=='crear' ? 'Agregar producto':'Modificar producto' }}



<label for="Nombre">{{'Nombre'}}</label>
    <input type="text" name="Nombre" id="Nombre" 
    value="{{ isset($producto->nombre)?$producto->nombre:'' }}"
    >
    </br>

    <label for="Descripcion">{{'Descripcion'}}</label>
    <input type="text" name="Descripcion" id="Descripcion"
    value="{{ isset ($producto->descripcion)?$producto->descripcion:'' }}"
    >
    </br>

    <label for="Precio">{{'Precio'}}</label>
    <input type="text" name="Precio" id="Precio" 
    value="{{ isset ($producto->precio)?$producto->precio:'' }}"
    >
    </br>

    <label for="Foto">{{'Foto'}}</label>
    @if(isset($producto->foto))
    </br>
    <img src="{{ asset('storage').'/'.$producto->foto}}" alt="" width="200">
    </br>
    @endif
    <input type="file" name="Foto" id="Foto" value="">
    </br>

    <input type="submit" value="{{ $Modo=='crear' ? 'Agregar':'Modificar' }}">

    <a href="{{ url('productos') }}">Regresar</a>