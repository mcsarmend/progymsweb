@extends('adminlte::page')

@section('title', 'Baja acreedor')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Baja acreedor</h1>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style="font-size: 2rem">Eliminar cliente</h1>
                </div>
                <div class="card-body">
                    <form id="eliminar">
                        @csrf
                        <div class="row">
                            <div class="col-md-3">
                                <label for="cliente">Cliente:</label>
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="id" id="id" class="form-control" list="clientesList"
                                    autocomplete="off" required>
                                <datalist id="clientesList">
                                    @foreach ($creditors as $creditor)
                                        <option value="{{ $creditor->nombre }}" data-id="{{ encrypt($creditor->id) }}">
                                    @endforeach
                                </datalist>

                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-danger btn-block">
                                    <i class="fas fa-trash"></i> Eliminar
                                </button>
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

            // Inicializar Select2 con búsqueda (opcional pero recomendado)
            // Si usas Select2, descomenta esta línea:
            // $('#id').select2({
            //     placeholder: 'Buscar cliente...',
            //     allowClear: true
            // });
        });

        // Validar que el cliente seleccionado exista en el datalist
        $('#eliminar').submit(function(e) {
            e.preventDefault();

            var clienteNombre = $('#id').val().trim();

            if (!clienteNombre) {
                Swal.fire(
                    '¡Atención!',
                    'Por favor escriba o seleccione un cliente',
                    'warning'
                );
                return false;
            }

            // Buscar si el nombre existe en el datalist
            var clienteId = null;
            var clienteEncontrado = false;

            $('#clientesList option').each(function() {
                if ($(this).val().toLowerCase() === clienteNombre.toLowerCase()) {
                    clienteId = $(this).data('id');
                    clienteEncontrado = true;
                    return false; // Salir del each
                }
            });

            if (!clienteEncontrado) {
                Swal.fire(
                    '¡Atención!',
                    'El cliente "' + clienteNombre + '" no existe en el sistema',
                    'warning'
                );
                return false;
            }

            // Confirmar antes de eliminar
            Swal.fire({
                title: '¿Estás seguro?',
                text: "¡Esta acción no se puede revertir! El cliente '" + clienteNombre +
                    "' será eliminado permanentemente.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: '¡Sí, eliminar!',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Enviar el ID encriptado
                    var datosFormulario = {
                        id: clienteId,
                        _token: $('meta[name="csrf-token"]').attr('content')
                    };

                    // Realizar la solicitud AJAX
                    $.ajax({
                        url: '/eliminaracreedor',
                        type: 'POST',
                        data: datosFormulario,
                        success: function(response) {
                            Swal.fire(
                                '¡Eliminado!',
                                response.message ||
                                'El cliente ha sido eliminado correctamente',
                                'success'
                            );
                            setTimeout(function() {
                                window.location.reload();
                            }, 3000);
                        },
                        error: function(response) {
                            var mensaje = response.responseJSON?.message ||
                                'Error al eliminar el cliente';
                            Swal.fire(
                                '¡Error!',
                                mensaje,
                                'error'
                            );
                        }
                    });
                }
            });
        });

        // Opcional: Limpiar el campo cuando el usuario hace clic
        $('#id').on('focus', function() {
            $(this).select();
        });

        // Opcional: Si el usuario selecciona una opción del datalist, mostrar el nombre
        $('#id').on('input', function() {
            var valor = $(this).val();
            var encontrado = false;

            $('#clientesList option').each(function() {
                if ($(this).val().toLowerCase() === valor.toLowerCase()) {
                    encontrado = true;
                    return false;
                }
            });

            // Si no se encuentra, limpiar el estilo
            if (!encontrado && valor.length > 0) {
                $(this).css('border-color', '#dc3545');
            } else {
                $(this).css('border-color', '');
            }
        });
    </script>
@stop
