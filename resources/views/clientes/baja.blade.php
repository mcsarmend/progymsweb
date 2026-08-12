@extends('adminlte::page')

@section('title', 'Crear Cuenta por Pagar')

@section('content_header')
@stop

@section('content')

    <div class="card">
        <div class="card-header">
            <h2>Crear Cuenta por Pagar</h2>
        </div>
        <div class="card-body">
            <form id="crearcxp" method="POST">
                @csrf

                ```
                {{-- Tipo de persona --}}
                <div class="form-group">
                    <label for="tipo_persona">Tipo de persona</label>
                    <select name="tipo_persona" id="tipo_persona" class="form-control" required>
                        <option value="">Seleccione...</option>
                        <option value="supplier">Proveedor</option>
                        <option value="creditor">Acreedor</option>
                    </select>
                </div>

                {{-- Proveedor --}}
                <div class="form-group" id="proveedor_group" style="display:none;">
                    <label for="proveedor_nombre">Buscar Proveedor</label>
                    <input type="text" id="proveedor_nombre" name="proveedor_nombre" list="proveedor-list"
                        class="form-control" placeholder="Escribe para buscar proveedor..." autocomplete="off">
                    <datalist id="proveedor-list">
                        @foreach ($proveedores as $proveedor)
                            <option value="{{ $proveedor->nombre }}"></option>
                        @endforeach
                    </datalist>
                    <input type="hidden" id="proveedor_id" name="proveedor_id" value="">
                    <small class="text-muted">Selecciona un proveedor de la lista</small>
                </div>

                {{-- Acreedor --}}
                <div class="form-group" id="acreedor_group" style="display:none;">
                    <label for="acreedor_nombre">Buscar Acreedor</label>
                    <input type="text" id="acreedor_nombre" name="acreedor_nombre" list="acreedor-list"
                        class="form-control" placeholder="Escribe para buscar acreedor..." autocomplete="off">
                    <datalist id="acreedor-list">
                        @foreach ($acreedores as $acreedor)
                            <option value="{{ $acreedor->nombre }}"></option>
                        @endforeach
                    </datalist>
                    <input type="hidden" id="acreedor_id" name="acreedor_id" value="">
                    <small class="text-muted">Selecciona un acreedor de la lista</small>
                </div>

                {{-- Monto --}}
                <div class="form-group">
                    <label for="monto">Monto</label>
                    <input type="number" name="monto" id="monto" class="form-control" placeholder="0.00"
                        step="0.01" min="0" required>
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

                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="{{ route('home') }}" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>
        ```

    </div>
    @include('fondo')
@stop

@section('css')
@stop

@section('js')

    <script>
        var proveedoresMap = {};
        @foreach ($proveedores as $proveedor)
            proveedoresMap[@json($proveedor->nombre)] = @json($proveedor->id);
        @endforeach

        var acreedoresMap = {};
        @foreach ($acreedores as $acreedor)
            acreedoresMap[@json($acreedor->nombre)] = @json($acreedor->id);
        @endforeach

        $(document).ready(function() {
            if (typeof drawTriangles === 'function') drawTriangles();
            if (typeof showUsersSections === 'function') showUsersSections();
            $('#fecha').val(new Date().toISOString().split('T')[0]);
        });

        $('#tipo_persona').on('change', function() {
            var tipo = $(this).val();
            $('#proveedor_group, #acreedor_group').hide();
            $('#proveedor_nombre, #acreedor_nombre').val('').prop('required', false);
            $('#proveedor_id, #acreedor_id').val('');

            if (tipo === 'supplier') {
                $('#proveedor_group').show();
                $('#proveedor_nombre').prop('required', true).focus();
            } else if (tipo === 'creditor') {
                $('#acreedor_group').show();
                $('#acreedor_nombre').prop('required', true).focus();
            }
        });

        $('#proveedor_nombre').on('input change', function() {
            var nombre = $(this).val().trim();
            $('#proveedor_id').val(proveedoresMap[nombre] || '');
        });

        $('#acreedor_nombre').on('input change', function() {
            var nombre = $(this).val().trim();
            $('#acreedor_id').val(acreedoresMap[nombre] || '');
        });

        $('#proveedor_nombre').on('blur', function() {
            var nombre = $(this).val().trim();
            if (nombre && !proveedoresMap[nombre]) {
                Swal.fire('Atención', 'Debes seleccionar un proveedor válido de la lista', 'warning');
                $(this).val('');
                $('#proveedor_id').val('');
            }
        });

        $('#acreedor_nombre').on('blur', function() {
            var nombre = $(this).val().trim();
            if (nombre && !acreedoresMap[nombre]) {
                Swal.fire('Atención', 'Debes seleccionar un acreedor válido de la lista', 'warning');
                $(this).val('');
                $('#acreedor_id').val('');
            }
        });

        $('#crearcxp').submit(function(e) {
            e.preventDefault();

            var tipo = $('#tipo_persona').val();
            if (!tipo) {
                Swal.fire('Atención', 'Debes seleccionar un tipo de persona', 'warning');
                return;
            }

            var personaId = '';
            var personaNombre = '';

            if (tipo === 'supplier') {
                personaId = $('#proveedor_id').val();
                personaNombre = $('#proveedor_nombre').val().trim();
                if (!personaId) {
                    Swal.fire('Atención', 'Debes seleccionar un proveedor válido', 'warning');
                    return;
                }
            } else if (tipo === 'creditor') {
                personaId = $('#acreedor_id').val();
                personaNombre = $('#acreedor_nombre').val().trim();
                if (!personaId) {
                    Swal.fire('Atención', 'Debes seleccionar un acreedor válido', 'warning');
                    return;
                }
            }

            $.ajax({
                url: '/crearcxpevento',
                type: 'POST',
                data: {
                    tipo_persona: tipo,
                    persona_id: personaId,
                    persona_nombre: personaNombre,
                    monto: $('#monto').val(),
                    fecha: $('#fecha').val(),
                    concepto: $('#concepto').val(),
                    _token: $('meta[name="csrf-token"]').attr('content')
                },
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire(
                        '¡Éxito!',
                        response.message || 'Cuenta por pagar creada correctamente',
                        'success'
                    ).then(function() {
                        $('#crearcxp')[0].reset();
                        $('#proveedor_group, #acreedor_group').hide();
                        $('#proveedor_id, #acreedor_id').val('');
                        $('#fecha').val(new Date().toISOString().split('T')[0]);
                    });
                },
                error: function(response) {
                    var mensaje = response.responseJSON?.message || 'Error al crear la cuenta';
                    Swal.fire('Error', mensaje, 'error');
                }
            });
        });
    </script>

@stop
