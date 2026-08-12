@extends('adminlte::page')

@section('title', 'Reporte de Cuentas por Cobrar')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3>Listado de Cuentas por Cobrar</h3>
        </div>
        <div class="card-body">
            <table class="table table-hover" id="cxc_tabla">
                <thead>
                    <tr>
                        <th>ID CxC</th>
                        <th>Cliente</th>
                        <th>Remisión</th>
                        <th>Productos</th>
                        <th>Fecha</th>
                        <th>Importe total</th>
                        <th>Saldo Restante</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($cuentasPorCobrar as $cuenta)
                        <tr>
                            <td>{{ $cuenta->id }}</td>
                            <td>{{ $cuenta->cliente_nombre ?? ($cuenta->cliente->nombre ?? 'N/A') }}</td>
                            <td>{{ $cuenta->remision_id ?? 'N/A' }}</td>
                            <td>
                                <button class="btn btn-info btn-sm btn-productos" data-toggle="modal"
                                    data-target="#productosModal" data-remision-id="{{ $cuenta->remision_id }}">
                                    <i class="fas fa-boxes"></i> Ver Productos
                                </button>
                            </td>
                            <td>{{ $cuenta->fecha ?? $cuenta->created_at->format('d/m/Y') }}</td>
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
                                <button class="btn btn-primary btn-sm btn-detalle"
                                    data-cliente-id="{{ $cuenta->cliente_id }}" data-cuenta-id="{{ $cuenta->id }}"
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
                    <h5 class="modal-title" id="detalleModalLabel">Detalle de Cuenta por Cobrar</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Cliente: <span id="nombreCliente"></span></h6>
                            <h6>Cuenta ID: <span id="cuentaId"></span></h6>
                            <h6>Remisión: <span id="remisionId"></span></h6>
                            <h6>Fecha: <span id="fechaCuenta"></span></h6>
                        </div>
                        <div class="col-md-6">
                            <h6>Monto Total: <span id="montoTotal" class="text-primary"></span></h6>
                            <h6>Saldo Restante: <span id="saldoRestante" class="text-warning"></span></h6>
                            <h6>Estado: <span id="estadoCuenta"></span></h6>
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
                                    <th>Remisión Relacionada</th>
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

    <!-- Modal de Productos (reutilizando el mismo estilo que tu otro modal) -->
    <div class="modal fade" id="productosModal" tabindex="-1" role="dialog" aria-labelledby="productosCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-width" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productosLongTitle">Detalle de productos de la remisión</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h6>Remisión: <span id="remisionProductos"></span></h6>
                    <hr>
                    <table id="productostabla" class="table">
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Cantidad</th>
                                <th>Nombre</th>
                                <th>Precio Unitario</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
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
@stop

@section('js')
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();

            // Inicializar DataTable para la tabla principal
            $('#cxc_tabla').DataTable({
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
                var clienteId = $(this).data('cliente-id');
                var cuentaId = $(this).data('cuenta-id');
                var fila = $(this).closest('tr');
                var celdas = fila.find('td');

                // Obtener datos de la fila seleccionada
                var clienteNombre = celdas.eq(1).text();
                var remision = celdas.eq(2).text();
                var fecha = celdas.eq(4).text();
                var monto = celdas.eq(5).text();
                var saldo = celdas.eq(6).text();
                var estado = celdas.eq(7).text();

                // Mostrar datos en el modal
                $('#nombreCliente').text(clienteNombre);
                $('#cuentaId').text('#' + cuentaId);
                $('#remisionId').text(remision);
                $('#fechaCuenta').text(fecha);
                $('#montoTotal').text(monto);
                $('#saldoRestante').text(saldo);
                $('#estadoCuenta').html(estado);

                // Limpiar tabla de pagos
                $('#cuerpoPagos').empty();

                // Obtener y mostrar los pagos de esta cuenta específica
                $.get('/obtener-pagos/' + cuentaId, function(pagos) {
                    if (pagos.length === 0) {
                        $('#cuerpoPagos').append(`
                            <tr>
                                <td colspan="5" class="text-center text-muted">
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
                                    <td>${pago.remision_id}</td>
                                </tr>
                            `);
                        });
                    }
                }).fail(function() {
                    $('#cuerpoPagos').append(`
                        <tr>
                            <td colspan="5" class="text-center text-danger">
                                Error al cargar los pagos
                            </td>
                        </tr>
                    `);
                });
            });

            // Manejar el click en el botón de productos (reutilizando la misma función que en tu otro blade)
            $(document).on('click', '.btn-productos', function() {
                var remisionId = $(this).data('remision-id');

                // Mostrar el número de remisión en el modal
                $('#remisionProductos').text('#' + remisionId);

                // Mostrar el modal
                $('#productosModal').modal('show');

                // Hacer la petición AJAX a la ruta existente
                $.ajax({
                    url: 'verproductosremision',
                    type: 'GET',
                    data: {
                        id: remisionId
                    },
                    dataType: 'json',
                    success: function(data) {
                        $('#productostabla').DataTable({
                            destroy: true,
                            scrollX: true,
                            scrollCollapse: true,
                            "language": {
                                "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                            },
                            "buttons": [
                                'copy', 'excel', 'pdf', 'print'
                            ],
                            dom: 'Blfrtip',
                            processing: true,
                            sort: true,
                            paging: true,
                            lengthMenu: [
                                [10, 25, 50, -1],
                                [10, 25, 50, 'All']
                            ],
                            pdf: {
                                orientation: 'landscape',
                                pageSize: 'A4',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            },
                            excel: {
                                exportOptions: {
                                    columns: ':visible'
                                }
                            },
                            "data": data.productos,
                            "columns": [{
                                    "data": "Codigo"
                                },
                                {
                                    "data": "Cantidad"
                                },
                                {
                                    "data": "Nombre"
                                },
                                {
                                    "data": "Precio Unitario"
                                },
                                {
                                    "data": "Subtotal"
                                }
                            ]
                        });
                    },
                    error: function(error) {
                        console.error('Error al obtener productos:', error);
                        Swal.fire('Error', 'No se pudieron obtener los productos', 'error');
                    }
                });
            });
        });
    </script>
@stop
