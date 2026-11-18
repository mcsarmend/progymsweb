@extends('adminlte::page')

@section('title', 'Crear Cuenta por Pagar')

@section('content_header')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Crear Cuenta por Pagar</h2>
        </div>
        <div class="card-body">

            <form id="crearcxp" method="POST">
                @csrf

                {{-- Tipo de persona (Proveedor / Acreedor) --}}
                <div class="form-group">
                    <label for="tipo_persona">Tipo de persona</label>
                    <select name="tipo_persona" id="tipo_persona" class="form-control" required>
                        <option value="">Seleccione...</option>
                        <option value="supplier">Proveedor</option>
                        <option value="creditor">Acreedor</option>
                    </select>
                </div>

                {{-- Datalist para buscar proveedores --}}
                <div class="form-group" id="proveedor_group" style="display: none;">
                    <label for="proveedor_nombre">Buscar Proveedor</label>
                    <input type="text" id="proveedor_nombre" name="proveedor_nombre" list="proveedorList"
                        class="form-control" placeholder="Escribe para buscar proveedor..." autocomplete="off">
                    <datalist id="proveedorList">
                        @foreach ($proveedores as $proveedor)
                            <option value="{{ $proveedor->nombre }}" data-id="{{ encrypt($proveedor->id) }}">
                        @endforeach
                    </datalist>
                    <input type="hidden" id="proveedor_id" name="proveedor_id" value="">
                    <small class="text-muted">Selecciona un proveedor de la lista</small>
                </div>

                {{-- Datalist para buscar acreedores --}}
                <div class="form-group" id="acreedor_group" style="display: none;">
                    <label for="acreedor_nombre">Buscar Acreedor</label>
                    <input type="text" id="acreedor_nombre" name="acreedor_nombre" list="acreedorList"
                        class="form-control" placeholder="Escribe para buscar acreedor..." autocomplete="off">
                    <datalist id="acreedorList">
                        @foreach ($acreedores as $acreedor)
                            <option value="{{ $acreedor->nombre }}" data-id="{{ encrypt($acreedor->id) }}">
                        @endforeach
                    </datalist>
                    <input type="hidden" id="acreedor_id" name="acreedor_id" value="">
                    <small class="text-muted">Selecciona un acreedor de la lista</small>
                </div>

                {{-- Monto --}}
                <div class="form-group">
                    <label for="monto">Monto</label>
                    <input type="number" name="monto" id="monto" class="form-control" placeholder="0.00"
                        step="0.01" required>
                </div>

                {{-- Fecha --}}
                <div class="form-group">
                    <label for="fecha">Fecha</label>
                    <input type="date" name="fecha" id="fecha" class="form-control" required>
                </div>

                {{-- Concepto --}}
                <div class="form-group">
                    <label for="concepto">Concepto</label>
                    <textarea name="concepto" id="concepto" class="form-control" rows="3" placeholder="Descripción del concepto..."
                        required></textarea>
                </div>

                {{-- Botón submit --}}
                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="{{ route('home') }}" class="btn btn-secondary">Cancelar</a>
            </form>

        </div>
    </div>
    @include('fondo')
@stop

@section('css')
    {{-- Puedes agregar estilos adicionales aquí --}}
@stop

@section('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>

    <script>
        var contadorFilas = 1;
        var sum = 0;

        $(document).ready(function() {
            drawTriangles();
            showUsersSections();

            // Establecer fecha actual por defecto
            $('#fecha').val(new Date().toISOString().split('T')[0]);
        });

        // Cuando cambie el tipo de persona, mostrar el datalist correspondiente
        $('#tipo_persona').on('change', function() {
            var tipo = $(this).val();

            // Ocultar ambos grupos primero
            $('#proveedor_group').hide();
            $('#acreedor_group').hide();

            // Limpiar los inputs
            $('#proveedor_nombre').val('');
            $('#proveedor_id').val('');
            $('#acreedor_nombre').val('');
            $('#acreedor_id').val('');

            // Mostrar el grupo correspondiente
            if (tipo === 'supplier') {
                $('#proveedor_group').show();
                $('#proveedor_nombre').prop('required', true);
                $('#acreedor_nombre').prop('required', false);
            } else if (tipo === 'creditor') {
                $('#acreedor_group').show();
                $('#acreedor_nombre').prop('required', true);
                $('#proveedor_nombre').prop('required', false);
            }
        });

        // Función para obtener el ID desde el datalist usando data-id
        function getProveedorIdByNombre(nombre) {
            var id = null;
            $('#proveedorList option').each(function() {
                if ($(this).val() === nombre) {
                    id = $(this).data('id');
                    return false;
                }
            });
            return id;
        }

        function getAcreedorIdByNombre(nombre) {
            var id = null;
            $('#acreedorList option').each(function() {
                if ($(this).val() === nombre) {
                    id = $(this).data('id');
                    return false;
                }
            });
            return id;
        }

        // Cuando se selecciona un proveedor, guardar el ID oculto desde data-id
        $('#proveedor_nombre').on('input', function() {
            var nombre = $(this).val();
            var id = getProveedorIdByNombre(nombre);
            if (id) {
                $('#proveedor_id').val(id);
            } else {
                $('#proveedor_id').val('');
            }
        });

        // Validar selección de proveedor al perder el foco
        $('#proveedor_nombre').on('blur', function() {
            var nombre = $(this).val();
            var id = $('#proveedor_id').val();

            if ($(this).prop('required') && nombre) {
                if (!id) {
                    // Verificar si el nombre existe en el datalist
                    var existe = false;
                    $('#proveedorList option').each(function() {
                        if ($(this).val() === nombre) {
                            existe = true;
                            return false;
                        }
                    });

                    if (!existe) {
                        Swal.fire('Atención', 'Debes seleccionar un proveedor válido de la lista', 'warning');
                        $(this).val('');
                        $('#proveedor_id').val('');
                    }
                }
            }
        });

        // Cuando se selecciona un acreedor, guardar el ID oculto desde data-id
        $('#acreedor_nombre').on('input', function() {
            var nombre = $(this).val();
            var id = getAcreedorIdByNombre(nombre);
            if (id) {
                $('#acreedor_id').val(id);
            } else {
                $('#acreedor_id').val('');
            }
        });

        // Validar selección de acreedor al perder el foco
        $('#acreedor_nombre').on('blur', function() {
            var nombre = $(this).val();
            var id = $('#acreedor_id').val();

            if ($(this).prop('required') && nombre) {
                if (!id) {
                    var existe = false;
                    $('#acreedorList option').each(function() {
                        if ($(this).val() === nombre) {
                            existe = true;
                            return false;
                        }
                    });

                    if (!existe) {
                        Swal.fire('Atención', 'Debes seleccionar un acreedor válido de la lista', 'warning');
                        $(this).val('');
                        $('#acreedor_id').val('');
                    }
                }
            }
        });

        // Envío del formulario por AJAX
        $('#crearcxp').submit(function(e) {
            e.preventDefault();

            // Validar que se haya seleccionado un tipo
            var tipo = $('#tipo_persona').val();
            if (!tipo) {
                Swal.fire('Atención', 'Debes seleccionar un tipo de persona', 'warning');
                return;
            }

            // Obtener el ID del proveedor o acreedor seleccionado
            var personaId = null;
            var personaNombre = null;

            if (tipo === 'supplier') {
                personaId = $('#proveedor_id').val();
                personaNombre = $('#proveedor_nombre').val();

                if (!personaId) {
                    Swal.fire('Atención', 'Debes seleccionar un proveedor válido', 'warning');
                    return;
                }
            } else if (tipo === 'creditor') {
                personaId = $('#acreedor_id').val();
                personaNombre = $('#acreedor_nombre').val();

                if (!personaId) {
                    Swal.fire('Atención', 'Debes seleccionar un acreedor válido', 'warning');
                    return;
                }
            }

            // Preparar datos para enviar
            var datosFormulario = {
                tipo_persona: tipo,
                persona_id: personaId,
                persona_nombre: personaNombre,
                monto: $('#monto').val(),
                fecha: $('#fecha').val(),
                concepto: $('#concepto').val(),
                _token: $('meta[name="csrf-token"]').attr('content')
            };

            $.ajax({
                url: '/crearcxpevento',
                type: 'POST',
                data: datosFormulario,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire(
                        '¡Éxito!',
                        response.message || 'Cuenta por pagar creada correctamente',
                        'success'
                    ).then(() => {
                        // Limpiar formulario
                        $('#crearcxp')[0].reset();
                        $('#proveedor_group').hide();
                        $('#acreedor_group').hide();
                        $('#proveedor_id').val('');
                        $('#acreedor_id').val('');
                        $('#fecha').val(new Date().toISOString().split('T')[0]);
                    });
                },
                error: function(response) {
                    var mensaje = response.responseJSON?.message || 'Error al crear la cuenta';
                    Swal.fire(
                        'Error',
                        mensaje,
                        'error'
                    );
                }
            });
        });
    </script>
@stop
