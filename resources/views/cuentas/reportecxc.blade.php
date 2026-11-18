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
            <!-- ============================================= -->
            <!-- RECUADRO DE TOTAL DEL SALDO RESTANTE          -->
            <!-- ============================================= -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="small-box bg-info">
                        <div class="inner">
                            <h3>${{ number_format($totalSaldoRestante ?? 0, 2) }}</h3>
                            <p>Total Saldo Restante</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <a href="#" class="small-box-footer">
                            <i class="fas fa-arrow-circle-right"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="small-box bg-success">
                        <div class="inner">
                            <h3>{{ $totalCuentas ?? 0 }}</h3>
                            <p>Total de Cuentas</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-file-invoice"></i>
                        </div>
                        <a href="#" class="small-box-footer">
                            <i class="fas fa-arrow-circle-right"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="small-box bg-warning">
                        <div class="inner">
                            <h3>{{ $cuentasPendientes ?? 0 }}</h3>
                            <p>Cuentas Pendientes</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <a href="#" class="small-box-footer">
                            <i class="fas fa-arrow-circle-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- ============================================= -->
            <!-- TABLA PRINCIPAL                               -->
            <!-- ============================================= -->
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
                <!-- ============================================= -->
                <!-- PIE DE TABLA CON TOTALES                      -->
                <!-- ============================================= -->
                <tfoot>
                    <tr style="background-color: #f8f9fa; font-weight: bold;">
                        <td colspan="5" class="text-right">TOTALES:</td>
                        <td>${{ number_format($totalMonto ?? 0, 2) }}</td>
                        <td>${{ number_format($totalSaldoRestante ?? 0, 2) }}</td>
                        <td colspan="2"></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>

    <!-- ============================================= -->
    <!-- MODALES                                        -->
    <!-- ============================================= -->

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

    <!-- Modal de Productos -->
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
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css">
    <style>
        .modal-dialog.custom-width {
            max-width: 55%;
        }

        #productostabla th:first-child,
        #productostabla td:first-child {
            min-width: 100px;
        }

        /* Estilos para los recuadros de totales */
        .small-box {
            border-radius: 0.25rem;
            box-shadow: 0 0 1px rgba(0, 0, 0, 0.125), 0 1px 3px rgba(0, 0, 0, 0.2);
            display: block;
            margin-bottom: 20px;
            position: relative;
        }

        .small-box .inner {
            padding: 10px;
        }

        .small-box .inner h3 {
            font-size: 2.2rem;
            font-weight: bold;
            margin: 0 0 10px 0;
            white-space: nowrap;
            padding: 0;
        }

        .small-box .inner p {
            font-size: 1rem;
            margin: 0;
        }

        .small-box .icon {
            color: rgba(0, 0, 0, 0.15);
            position: absolute;
            right: 10px;
            top: 10px;
            z-index: 0;
        }

        .small-box .icon i {
            font-size: 70px;
        }

        .small-box .small-box-footer {
            background-color: rgba(0, 0, 0, 0.1);
            color: rgba(255, 255, 255, 0.8);
            display: block;
            padding: 3px 0;
            position: relative;
            text-align: center;
            text-decoration: none;
            z-index: 10;
        }

        .small-box .small-box-footer:hover {
            background-color: rgba(0, 0, 0, 0.15);
            color: #fff;
        }

        .bg-info {
            background-color: #17a2b8 !important;
            color: #fff !important;
        }

        .bg-success {
            background-color: #28a745 !important;
            color: #fff !important;
        }

        .bg-warning {
            background-color: #ffc107 !important;
            color: #fff !important;
        }

        /* Estilos para el footer de la tabla */
        tfoot td {
            background-color: #f8f9fa !important;
            font-weight: bold !important;
        }
    </style>
@stop

@section('js')
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>

    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();

            // =============================================
            // TABLA PRINCIPAL DE CUENTAS POR COBRAR
            // =============================================
            $('#cxc_tabla').DataTable({
                language: {
                    url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-MX.json"
                },
                buttons: [{
                        extend: 'copy',
                        text: 'Copiar'
                    },
                    {
                        extend: 'excel',
                        text: 'Excel'
                    },
                    {
                        extend: 'pdf',
                        text: 'PDF'
                    },
                    {
                        extend: 'print',
                        text: 'Imprimir'
                    }
                ],
                dom: 'Blfrtip',
                order: [
                    [0, 'desc']
                ],
                pageLength: 25,
                responsive: true,
                lengthMenu: [
                    [10, 25, 50, 100, -1],
                    [10, 25, 50, 100, 'Todos']
                ],
                columnDefs: [{
                    orderable: false,
                    targets: [3, 8]
                }],
                // Esto permite que el footer se mantenga visible
                footerCallback: function(row, data, start, end, display) {
                    var api = this.api();
                    var intVal = function(i) {
                        return typeof i === 'string' ?
                            parseFloat(i.replace(/[\$,]/g, '')) || 0 :
                            typeof i === 'number' ? i : 0;
                    };

                    // Calcular total del saldo restante en la página actual
                    var totalSaldo = 0;
                    var totalMonto = 0;

                    for (var i = start; i < end; i++) {
                        var rowData = data[i];
                        // La columna 6 es Saldo Restante, la 5 es Importe total
                        var saldo = rowData[6] ? parseFloat(rowData[6].replace(/[$,]/g, '')) || 0 : 0;
                        var monto = rowData[5] ? parseFloat(rowData[5].replace(/[$,]/g, '')) || 0 : 0;
                        totalSaldo += saldo;
                        totalMonto += monto;
                    }

                    // Actualizar el footer
                    var footer = $(api.table().footer());
                    footer.find('td').eq(5).html('$' + totalMonto.toFixed(2));
                    footer.find('td').eq(6).html('$' + totalSaldo.toFixed(2));
                }
            });

            // =============================================
            // MANEJAR CLICK EN BOTÓN DE DETALLE
            // =============================================
            $(document).on('click', '.btn-detalle', function() {
                var clienteId = $(this).data('cliente-id');
                var cuentaId = $(this).data('cuenta-id');
                var fila = $(this).closest('tr');
                var celdas = fila.find('td');

                var clienteNombre = celdas.eq(1).text();
                var remision = celdas.eq(2).text();
                var fecha = celdas.eq(4).text();
                var monto = celdas.eq(5).text();
                var saldo = celdas.eq(6).text();
                var estado = celdas.eq(7).text();

                $('#nombreCliente').text(clienteNombre);
                $('#cuentaId').text('#' + cuentaId);
                $('#remisionId').text(remision);
                $('#fechaCuenta').text(fecha);
                $('#montoTotal').text(monto);
                $('#saldoRestante').text(saldo);
                $('#estadoCuenta').html(estado);

                $('#cuerpoPagos').empty();

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

            // =============================================
            // MANEJAR CLICK EN BOTÓN DE PRODUCTOS
            // =============================================
            $(document).on('click', '.btn-productos', function() {
                var remisionId = $(this).data('remision-id');

                $('#remisionProductos').text('#' + remisionId);
                $('#productosModal').modal('show');

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
                            "buttons": [{
                                    extend: 'copy',
                                    text: 'Copiar'
                                },
                                {
                                    extend: 'excel',
                                    text: 'Excel'
                                },
                                {
                                    extend: 'pdf',
                                    text: 'PDF'
                                },
                                {
                                    extend: 'print',
                                    text: 'Imprimir'
                                }
                            ],
                            dom: 'Blfrtip',
                            processing: true,
                            sort: true,
                            paging: true,
                            lengthMenu: [
                                [10, 25, 50, -1],
                                [10, 25, 50, 'Todos']
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
