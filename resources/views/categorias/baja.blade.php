@extends('adminlte::page')

@section('title', 'Baja categorias')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Baja categorias</h1>

        </div>
        <div class="card-body">
            <form id="eliminarcategorias">
                @csrf
                <div class="col text-center">
                    <label for="categorias">Categorias:</label>
                </div>

                <div class="col d-flex justify-content-center">
                    <input type="text" id="categorias" name="categorias" list="categorias-list" class="form-control w-50">
                    <datalist id="categorias-list">
                        @foreach ($categorias as $categorias)
                            <option value="{{ $categorias->id }}-{{ $categorias->nombre }}">
                        @endforeach
                    </datalist>
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
        $('#eliminarcategorias').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/eliminarcategoria', // Ruta al controlador de Laravel
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
