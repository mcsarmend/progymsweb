@extends('adminlte::page')

@section('title', 'Baja Cliente')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Baja Cliente</h1>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style ="font-size: 2rem">Eliminar cliente</h1>
                </div>
                <div class="card-body">
                    <form id="eliminar">
                        @csrf
                        <div class="row">
                            <div class="col">
                                <label for="almacen">Cliente:</label>
                            </div>
                            <div class="col">
                                <select name="id" id="id" class="form-control">
                                    @foreach ($clients as $client)
                                        <option value="{{ encrypt($client->id) }}">{{ $client->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>

                        </div>
                        <br>
                        <div class="row">
                            <div class="col">
                                <input type="submit" value="Eliminar" class="btn btn-danger">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
    @include('fondo')
@stop

@section('css')

@stop

@section('js')
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
        });
        $('#eliminar').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/eliminarcliente', // Ruta al controlador de Laravel
                type: 'POST',
                // data: datosFormulario, // Enviar los datos del formulario
                data: {
                    nombre: datosFormulario.nombre,
                    sucursal: parseInt(datosFormulario.sucursal),
                    telefono: datosFormulario.nombre,
                    precio: parseInt(datosFormulario.nombre)
                }
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );
                    setTimeout(function() {
                        window.location.reload();
                    }, 3000);
                    generarContrasena();
                },
                error: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        "Existe un error: " + response.message,
                        'error'
                    )
                }
            });
        });
    </script>
@stop
