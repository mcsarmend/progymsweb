@extends('adminlte::page')

@section('title', 'Abono Cuentas por Pagar')

@section('content_header')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Abono a Cuenta por Pagar</h2>
        </div>
        <div class="card-body">

            <!-- FORMULARIO 1: Buscar y mostrar información -->
            <form id="formBuscarCxp">
                <div class="row mb-4">
                    <div class="col-md-9">
                        <div class="input-group">
                            <input type="text" class="form-control form-control-lg" id="buscar_cuenta"
                                placeholder="Ingrese ID de la cuenta por pagar">
                            <button class="btn btn-primary" type="button" id="btn-buscar-cuenta">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <hr>

            <!-- Información de la cuenta -->
            <h2>Información de la Cuenta por Pagar</h2>
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="cuenta_id">ID Cuenta:</label>
                        <input type="text" class="form-control" id="cuenta_id" name="cuenta_id" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="tipo_persona">Tipo:</label>
                        <input type="text" class="form-control" id="tipo_persona" name="tipo_persona" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="persona">Proveedor/Acreedor:</label>
                        <input type="text" class="form-control" id="persona" name="persona" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="fecha">Fecha:</label>
                        <input type="date" class="form-control" id="fecha" name="fecha" readonly>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="total">Monto Total:</label>
                        <input type="text" class="form-control" id="total" name="total" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="restante">Saldo Restante:</label>
                        <input type="text" class="form-control" id="restante" name="restante" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="estado">Estado:</label>
                        <input type="text" class="form-control" id="estado" name="estado" readonly>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="concepto">Concepto:</label>
                        <input type="text" class="form-control" id="concepto" name="concepto" readonly>
                    </div>
                </div>
            </div>

            <hr>

            <!-- FORMULARIO 2: Abono -->
            <form id="formAbonoCxp">
                <h3>Información para el Abono</h3>
                <div class="row mt-4">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="monto">Cantidad a Abonar:</label>
                            <input type="number" class="form-control" id="monto" name="monto" step="0.01"
                                min="0.01" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="metodo_pago">Método de pago:</label>
                            <select name="metodo_pago" id="metodo_pago" class="form-control" required>
                                <option value="">Seleccione...</option>
                                <option value="efectivo">Efectivo</option>
                                <option value="transferencia">Transferencia</option>
                                <option value="terminal">Terminal</option>
                                <option value="clip">Clip</option>
                                <option value="mercado_pago">Mercado Pago</option>
                                <option value="vales">Vales</option>
                                <option value="cheque">Cheque</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="fecha_pago">Fecha de Pago:</label>
                            <input type="date" class="form-control" id="fecha_pago" name="fecha_pago" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-success btn-lg mt-4" id="btn-abonar">
                            <i class="fas fa-money-bill-wave"></i> Abonar a Cuenta
                        </button>
                    </div>
                </div>
            </form>

        </div>
    </div>
    @include('fondo')
@stop

@section('css')
    <style>
        .readonly-field {
            background-color: #e9ecef;
        }
    </style>
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
            $('#fecha_pago').val(new Date().toISOString().split('T')[0]);

            // ============================================
            // FORMULARIO 1: Buscar cuenta por pagar
            // ============================================
            $('#btn-buscar-cuenta').click(function() {
                event.preventDefault();
                const cuentaId = $('#buscar_cuenta').val().trim();

                if (!cuentaId) {
                    Swal.fire('Error', 'Por favor ingrese un ID de cuenta válido', 'error');
                    return;
                }

                Swal.fire({
                    title: 'Buscando cuenta por pagar',
                    html: 'Por favor espere...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                $.ajax({
                    url: '/obtener-cxp/' + cuentaId,
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        Swal.close();

                        if (response.success) {
                            var data = response.data;

                            // Llenar campos principales
                            $('#cuenta_id').val(data.id);
                            $('#fecha').val(data.fecha);
                            $('#total').val('$' + parseFloat(data.monto).toFixed(2));
                            $('#restante').val('$' + parseFloat(data.saldo_restante).toFixed(
                                2));
                            $('#estado').val(data.estado);
                            $('#concepto').val(data.concepto || 'Sin concepto');
                            $('#tipo_persona').val(data.tipo_persona || '');
                            $('#persona').val(data.nombre_persona || '');

                            // Validar si la cuenta está pagada
                            if (data.estado === 'Pagada' || data.estado === 'Cancelada') {
                                Swal.fire('Atención', 'Esta cuenta ya está ' + data.estado
                                    .toLowerCase(),
                                    'warning');
                                $('#monto').prop('disabled', true);
                                $('#metodo_pago').prop('disabled', true);
                                $('#btn-abonar').prop('disabled', true);
                            } else {
                                // Establecer el monto máximo a abonar
                                $('#monto').attr('max', data.saldo_restante);
                                $('#monto').prop('disabled', false);
                                $('#metodo_pago').prop('disabled', false);
                                $('#btn-abonar').prop('disabled', false);
                            }

                            Swal.fire('Éxito', 'Cuenta cargada correctamente', 'success');

                        } else {
                            Swal.fire('Error', response.message || 'No se encontró la cuenta',
                                'error');
                            limpiarCampos();
                        }
                    },
                    error: function(xhr) {
                        Swal.close();
                        let errorMsg = 'Error al buscar la cuenta';
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMsg = xhr.responseJSON.message;
                        }
                        Swal.fire('Error', errorMsg, 'error');
                        limpiarCampos();
                    }
                });
            });

            // Buscar al presionar Enter
            $('#buscar_cuenta').keypress(function(e) {
                if (e.which == 13) {
                    e.preventDefault();
                    $('#btn-buscar-cuenta').click();
                }
            });

            // Función para limpiar campos
            function limpiarCampos() {
                $('#cuenta_id').val('');
                $('#tipo_persona').val('');
                $('#persona').val('');
                $('#fecha').val('');
                $('#total').val('');
                $('#restante').val('');
                $('#estado').val('');
                $('#concepto').val('');
                $('#monto').val('');
                $('#metodo_pago').val('');
                $('#fecha_pago').val(new Date().toISOString().split('T')[0]);
                $('#monto').prop('disabled', true);
                $('#metodo_pago').prop('disabled', true);
                $('#btn-abonar').prop('disabled', true);
            }

            // Deshabilitar campos de abono inicialmente
            $('#monto').prop('disabled', true);
            $('#metodo_pago').prop('disabled', true);
            $('#btn-abonar').prop('disabled', true);

            // ============================================
            // FORMULARIO 2: Envío del abono
            // ============================================
            $('#formAbonoCxp').submit(function(e) {
                e.preventDefault();

                // Validar que se haya cargado una cuenta
                var cuentaId = $('#cuenta_id').val();
                if (!cuentaId) {
                    Swal.fire('Error', 'Primero debe buscar una cuenta por pagar', 'error');
                    return;
                }

                // Validar que el monto sea mayor a 0
                var monto = parseFloat($('#monto').val());
                if (!monto || monto <= 0) {
                    Swal.fire('Error', 'Debe ingresar un monto válido mayor a 0', 'error');
                    return;
                }

                // Validar que no exceda el saldo
                var restante = parseFloat($('#restante').val().replace('$', '').replace(',', ''));
                if (monto > restante) {
                    Swal.fire('Error', 'El monto no puede exceder el saldo restante', 'error');
                    return;
                }

                // Preparar datos para enviar
                var datosFormulario = {
                    cuenta_id: cuentaId,
                    monto: monto,
                    metodo_pago: $('#metodo_pago').val(),
                    fecha_pago: $('#fecha_pago').val(),
                    _token: $('meta[name="csrf-token"]').attr('content')
                };

                Swal.fire({
                    title: 'Procesando abono',
                    html: 'Por favor espere...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                $.ajax({
                    url: '/abonocxpevento',
                    type: 'POST',
                    data: datosFormulario,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        Swal.close();
                        Swal.fire(
                            '¡Éxito!',
                            response.message || 'Abono registrado correctamente',
                            'success'
                        ).then(() => {
                            // Limpiar formulario
                            limpiarCampos();
                            $('#buscar_cuenta').val('');
                            Swal.fire('Info', 'La cuenta se ha actualizado', 'info');
                        });
                    },
                    error: function(response) {
                        Swal.close();
                        var mensaje = response.responseJSON?.message ||
                            'Error al registrar el abono';
                        Swal.fire(
                            'Error',
                            mensaje,
                            'error'
                        );
                    }
                });
            });
        });
    </script>
@stop
