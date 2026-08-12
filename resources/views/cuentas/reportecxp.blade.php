@extends('adminlte::page')

@section('title', 'Reporte de Cuentas por Pagar')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3>Listado de Cuentas por Pagar</h3>
        </div>
        <div class="card-body">
            <table class="table table-hover" id="cxp_tabla">
                <thead>
                    <tr>
                        <th>ID CXP</th>
                        <th>Proveedor/Acreedor</th>
                        <th>Tipo</th>
                        <th>Fecha</th>
                        <th>Importe total</th>
                        <th>Saldo Restante</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($cuentasPorPagar as $cuenta)
                        <tr>
                            <td>{{ $cuenta->id }}</td>
                            <td>
                                @if ($cuenta->proveedor_id)
                                    {{ $cuenta->proveedor_nombre ?? 'Proveedor eliminado' }}
                                @elseif($cuenta->acreedor_id)
                                    {{ $cuenta->acreedor_nombre ?? 'Acreedor eliminado' }}
                                @else
                                    N/A
                                @endif
                            </td>
                            <td>
                                @if ($cuenta->proveedor_id)
                                    <span class="badge badge-primary">Proveedor</span>
                                @elseif($cuenta->acreedor_id)
                                    <span class="badge badge-info">Acreedor</span>
                                @else
                                    <span class="badge badge-secondary">N/A</span>
                                @endif
                            </td>
                            <td>{{ \Carbon\Carbon::parse($cuenta->fecha)->format('d/m/Y') }}</td>
                            <td>${{ number_format($cuenta->monto, 2) }}</td>
                            <td>${{ number_format($cuenta->saldo_restante, 2) }}</td>
                            <td>
                                @php
                                    $estadoLower = strtolower($cuenta->estado);
                                    $badgeClass = match ($estadoLower) {
                                        'pendiente' => 'warning',
                                        'pagada', 'pagado' => 'success',
                                        'parcial' => 'info',
                                        'vencida' => 'danger',
                                        'cancelada' => 'secondary',
                                        default => 'secondary',
                                    };
                                @endphp
                                <span class="badge badge-{{ $badgeClass }}">
                                    {{ ucfirst($cuenta->estado) }}
                                </span>
                            </td>
                            <td>
                                <button class="btn btn-primary btn-sm btn-detalle" data-cuenta-id="{{ $cuenta->id }}"
                                    data-toggle="modal" data-target="#detalleModal">
                                    <i class="fas fa-eye"></i> Ver Detalle
                                </button>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal de Detalle de Cuenta -->
    <div class="modal fade" id="detalleModal" tabindex="-1" role="dialog" aria-labelledby="detalleModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detalleModalLabel">Detalle de Cuenta por Pagar</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>ID Cuenta: <span id="cuentaId"></span></h6>
                            <h6>Tipo: <span id="tipoPersona"></span></h6>
                            <h6>Proveedor/Acreedor: <span id="nombrePersona"></span></h6>
                            <h6>Fecha: <span id="fechaCuenta"></span></h6>
                        </div>
                        <div class="col-md-6">
                            <h6>Monto Total: <span id="montoTotal" class="text-primary"></span></h6>
                            <h6>Saldo Restante: <span id="saldoRestante" class="text-warning"></span></h6>
                            <h6>Estado: <span id="estadoCuenta"></span></h6>
                            <h6>Concepto: <span id="conceptoCuenta"></span></h6>
                        </div>
                    </div>
                    <hr>
                    <div class="table-responsive">
                        <h6>Pagos Realizados:</h6>
                        <table class="table table-sm" id="tablaPagos">
                            <thead>
                                <tr>
                                    <th>ID Pago</th>
                                    <th>Fecha</th>
                                    <th>Monto</th>
                                    <th>Método</th>
                                </tr>
                            </thead>
                            <tbody id="cuerpoPagos">
                                <!-- Aquí se cargarán los pagos -->
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    @include('fondo')
@stop

@section('css')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <style>
        .badge {
            font-size: 12px;
            padding: 5px 10px;
        }

        .btn-detalle {
            padding: 4px 8px;
            font-size: 12px;
        }
    </style>
@stop

@section('js')
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();

            // Inicializar DataTable para la tabla principal
            $('#cxp_tabla').DataTable({
                language: {
                    url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-MX.json"
                },
                order: [
                    [0, 'desc']
                ],
                pageLength: 25,
                responsive: true
            });

            // Manejar el click en el botón de detalle
            $(document).on('click', '.btn-detalle', function() {
                var cuentaId = $(this).data('cuenta-id');
                var fila = $(this).closest('tr');
                var celdas = fila.find('td');

                // Obtener datos de la fila seleccionada
                var personaNombre = celdas.eq(1).text().trim();
                var tipo = celdas.eq(2).text().trim();
                var fecha = celdas.eq(3).text();
                var monto = celdas.eq(4).text();
                var saldo = celdas.eq(5).text();
                var estado = celdas.eq(6).text();

                // Mostrar datos en el modal
                $('#cuentaId').text('#' + cuentaId);
                $('#tipoPersona').text(tipo);
                $('#nombrePersona').text(personaNombre);
                $('#fechaCuenta').text(fecha);
                $('#montoTotal').text(monto);
                $('#saldoRestante').text(saldo);
                $('#estadoCuenta').html(estado);
                $('#conceptoCuenta').text(''); // Limpiar concepto

                // Limpiar tabla de pagos
                $('#cuerpoPagos').empty();

                // Obtener y mostrar los pagos de esta cuenta específica
                $.ajax({
                    url: '/obtener-pagos-cxp/' + cuentaId,
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            var pagos = response.data;
                            if (pagos.length === 0) {
                                $('#cuerpoPagos').append(`
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">
                                            No hay pagos registrados para esta cuenta
                                        </td>
                                    </tr>
                                `);
                            } else {
                                pagos.forEach(function(pago) {
                                    $('#cuerpoPagos').append(`
                                        <tr>
                                            <td>${pago.id}</td>
                                            <td>${pago.fecha}</td>
                                            <td>$${parseFloat(pago.monto).toFixed(2)}</td>
                                            <td>${pago.metodo_pago}</td>
                                        </tr>
                                    `);
                                });
                            }
                        } else {
                            $('#cuerpoPagos').append(`
                                <tr>
                                    <td colspan="4" class="text-center text-danger">
                                        ${response.message || 'Error al cargar los pagos'}
                                    </td>
                                </tr>
                            `);
                        }
                    },
                    error: function(xhr) {
                        $('#cuerpoPagos').append(`
                            <tr>
                                <td colspan="4" class="text-center text-danger">
                                    Error al cargar los pagos
                                </td>
                            </tr>
                        `);
                    }
                });

                // Obtener el concepto de la cuenta (si existe en la fila)
                // Si no está en la tabla, podrías hacer otra petición AJAX
                // Por ahora lo dejamos vacío
            });
        });
    </script>
@stop
