@extends('adminlte::page')

@section('title', 'Editar Categoria')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Editar Categoria</h1>

        </div>
        <div class="card-body">
            <form id="editarcategoria" class="mt-3">
                @csrf

                <!-- FILA 1: Nuevo Nombre -->
                <div class="form-group row align-items-center mb-4">
                    <label for="nombre" class="col-sm-3 col-form-label text-right">
                        Nuevo nombre categoria:
                    </label>
                    <div class="col-sm-6">
                        <input type="text" id="nombre" name="nombre" class="form-control" required>
                    </div>
                </div>

                <!-- FILA 2: Categoria -->
                <div class="form-group row align-items-center mb-4">
                    <label for="categoria" class="col-sm-3 col-form-label text-right">
                        Categoria:
                    </label>
                    <div class="col-sm-6">
                        <input type="text" id="categoria" name="categoria" list="categoria-list" class="form-control">
                        <datalist id="categoria-list">
                            @foreach ($categorias as $categoria)
                                <option value="{{ $categoria->id }}-{{ $categoria->nombre }}">
                            @endforeach
                        </datalist>
                    </div>
                </div>

                <!-- BOTÓN -->
                <div class="form-group row">
                    <div class="col-sm-9 text-right">
                        <input type="submit" value="Actualizar" class="btn btn-success px-4">
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
        $('#editarcategoria').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/editarcategoria', // Ruta al controlador de Laravel
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
