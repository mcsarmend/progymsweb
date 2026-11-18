@extends('adminlte::page')

@section('title', 'Baja Inventario')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Baja Inventario</h1>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style="font-size: 2rem">Baja Producto</h1>
                </div>
                <div class="card-body">
                    <form id="eliminar">
                        @csrf
                        <div class="row">
                            <div class="col">
                                <label for="producto">Producto:</label>
                            </div>
                            <div class="col">
                                <input type="text" id="producto_nombre" name="producto_nombre" list="productos-list"
                                    class="form-control" placeholder="Escribe el nombre del producto...">
                                <datalist id="productos-list">
                                    @foreach ($productos as $producto)
                                        <option value="{{ $producto->nombre }}" data-id="{{ encrypt($producto->id) }}">
                                    @endforeach
                                </datalist>
                                <!-- Campo oculto para enviar el ID -->
                                <input type="hidden" name="id" id="id_producto">
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

            // Capturar la selección del datalist
            $('#producto_nombre').on('input', function() {
                var valor = $(this).val();
                // Buscar en el datalist si el valor coincide
                var option = $('#productos-list option[value="' + valor + '"]');
                if (option.length) {
                    // Si existe, asignar el ID al campo oculto
                    $('#id_producto').val(option.data('id'));
                } else {
                    // Si no existe, limpiar el campo oculto
                    $('#id_producto').val('');
                }
            });

            // También limpiar si el campo se vacía
            $('#producto_nombre').on('blur', function() {
                var valor = $(this).val();
                var option = $('#productos-list option[value="' + valor + '"]');
                if (!option.length) {
                    $('#id_producto').val('');
                    // Opcional: mostrar un mensaje o limpiar el campo
                    // $(this).val('');
                }
            });
        });

        $('#eliminar').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Verificar que se haya seleccionado un producto válido
            var idProducto = $('#id_producto').val();
            if (!idProducto) {
                Swal.fire(
                    'Error',
                    'Por favor selecciona un producto válido de la lista',
                    'error'
                );
                return false;
            }

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/eliminarproducto', // Ruta al controlador de Laravel
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
                        "Existe un error: " + (response.responseJSON?.message || response
                            .statusText),
                        'error'
                    );
                }
            });
        });
    </script>
@stop
