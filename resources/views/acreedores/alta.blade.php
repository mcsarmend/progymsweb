@extends('adminlte::page')

@section('title', 'Alta acreedor')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Alta acreedor</h1>

        </div>
        <div class="card-body">
            <form id="crearacreedor">
                @csrf
                <div class="row">
                    <div class="col">
                        <label for="acreedor">Nombre acreedor:</label>
                    </div>
                    <div class="col">
                        <input type="text" id="acreedor" name="acreedor" class="form-control" required> <br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col">
                        <label for="telefono">Telefono:</label>
                    </div>
                    <div class="col">
                        <input type="number" id="telefono" name="telefono" class="form-control" required> <br><br>
                    </div>
                </div>

                <br>
                <div class="row">
                    <div class="col">
                        <input type="submit" value="Crear" class="btn btn-success">
                    </div>
                </div>


            </form>
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
        $('#crearacreedor').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/crearacreedor', // Ruta al controlador de Laravel
                type: 'POST',
                data: datosFormulario, // Enviar los datos del formulario
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
