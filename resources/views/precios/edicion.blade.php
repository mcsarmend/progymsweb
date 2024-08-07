@extends('adminlte::page')

@section('title', 'Edición Precio')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style ="font-size: 2rem">Editar Precio</h1>
                </div>
                <div class="card-body">
                    <form id="editar">
                        @csrf
                        <div class="row">
                            <div class="col">
                                <label for="usuario">Precio:</label>
                            </div>
                            <div class="col">
                                <select name="id" id="id_actualizar" class="form-control">
                                    @foreach ($prices as $price)
                                        <option value="{{ encrypt($price->id) }}">{{ $price->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>

                        </div>


                        <br>
                        <div class="row">
                            <div class="col">
                                <label for="nombre">Nuevo nombre:</label>
                            </div>
                            <div class="col">
                                <input type="text" id="nombre" name="nombre" class="form-control">
                                <br>
                            </div>
                        </div>



                        <div class="row">
                            <div class="col">
                                <input type="submit" value="Actualizar" class="btn btn-primary">
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

        $('#editar').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/editarprecio', // Ruta al controlador de Laravel
                type: 'POST',
                // data: datosFormulario, // Enviar los datos del formulario
                data: datosFormulario,
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
