@extends('adminlte::page')

@section('title', 'Estatus pedidos')

@section('content_header')
@stop

@section('content')
    <div class="card">

        <div class="card-body">

            <div class="card">
                <div class="card-header">
                    <h1>Estatus pedidos</h1>
                </div>
                <div class="card-body">

                    <!-- Ruta de estados de pedidos -->
                    <!-- Ruta de estados de pedidos -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header bg-info text-white">
                                    <h5 class="mb-0"><i class="fas fa-road"></i> Ruta de estados de pedidos</h5>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                                        <!-- Estado CREADO -->
                                        <div class="text-center">
                                            <span class="badge badge-primary" style="font-size: 14px; padding: 8px 15px;">
                                                <i class="fas fa-plus-circle"></i> CREADO
                                            </span>
                                            <div><small class="text-muted">Inicio</small></div>
                                        </div>

                                        <div class="text-center">
                                            <i class="fas fa-arrow-right text-muted" style="font-size: 24px;"></i>
                                        </div>

                                        <!-- Estado SELECCIONADO -->
                                        <div class="text-center">
                                            <span class="badge badge-info" style="font-size: 14px; padding: 8px 15px;">
                                                <i class="fas fa-check-circle"></i> SELECCIONADO
                                            </span>
                                            <div><small class="text-muted">Asignar repartidor</small></div>
                                        </div>

                                        <div class="text-center">
                                            <i class="fas fa-arrow-right text-muted" style="font-size: 24px;"></i>
                                        </div>

                                        <!-- Estado SURTIDO -->
                                        <div class="text-center">
                                            <span class="badge badge-warning" style="font-size: 14px; padding: 8px 15px;">
                                                <i class="fas fa-boxes"></i> SURTIDO
                                            </span>
                                            <div><small class="text-muted">Preparar pedido</small></div>
                                        </div>

                                        <div class="text-center">
                                            <i class="fas fa-arrow-right text-muted" style="font-size: 24px;"></i>
                                        </div>

                                        <!-- Estado REVISADO -->
                                        <div class="text-center">
                                            <span class="badge badge-secondary" style="font-size: 14px; padding: 8px 15px;">
                                                <i class="fas fa-search"></i> REVISADO
                                            </span>
                                            <div><small class="text-muted">Verificar pedido</small></div>
                                        </div>

                                        <div class="text-center">
                                            <i class="fas fa-arrow-right text-muted" style="font-size: 24px;"></i>
                                        </div>

                                        <!-- Estado EN RUTA -->
                                        <div class="text-center">
                                            <span class="badge badge-info"
                                                style="font-size: 14px; padding: 8px 15px; background-color: #17a2b8;">
                                                <i class="fas fa-truck"></i> EN RUTA
                                            </span>
                                            <div><small class="text-muted">En camino</small></div>
                                        </div>

                                        <div class="text-center">
                                            <i class="fas fa-arrow-right text-muted" style="font-size: 24px;"></i>
                                        </div>

                                        <!-- Estado ENTREGADO -->
                                        <div class="text-center">
                                            <span class="badge badge-success" style="font-size: 14px; padding: 8px 15px;">
                                                <i class="fas fa-check-double"></i> ENTREGADO
                                            </span>
                                            <div><small class="text-muted">Entregado al cliente</small></div>
                                        </div>

                                        <div class="text-center">
                                            <i class="fas fa-arrow-right text-muted" style="font-size: 24px;"></i>
                                        </div>

                                        <!-- Estado FINALIZADO -->
                                        <div class="text-center">
                                            <span class="badge badge-success"
                                                style="font-size: 14px; padding: 8px 15px; background-color: #28a745;">
                                                <i class="fas fa-flag-checkered"></i> FINALIZADO
                                            </span>
                                            <div><small class="text-muted">Pedido completado</small></div>
                                        </div>
                                    </div>

                                    <!-- Estados de cancelación -->
                                    <div class="mt-3 pt-3 border-top">
                                        <div class="d-flex justify-content-center align-items-center flex-wrap">
                                            <div class="text-center">
                                                <span class="badge badge-danger"
                                                    style="font-size: 14px; padding: 8px 15px;">
                                                    <i class="fas fa-times-circle"></i> CANCELADO
                                                </span>
                                                <div><small class="text-muted">Disponible en todos los estados excepto
                                                        ENTREGADO y FINALIZADO</small></div>
                                            </div>
                                        </div>
                                        <div class="text-center mt-2">
                                            <small class="text-muted">
                                                <i class="fas fa-arrow-left"></i> Se puede cancelar desde cualquier estado
                                                anterior
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <table id="pedidos" class="table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Estatus</th>
                                <th>Fecha ultimo movimiento</th>
                                <th>Vendedor</th>
                                <th>Cliente</th>
                                <th>Productos</th>
                                <th>Total</th>
                                <th>Operaciones</th>
                                <th>Repartidor</th>
                                <th>Ubicacion</th>
                                <th>Cancelar</th>
                                <th>Remisionar</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <br>
                </div>
            </div>
        </div>

    </div>

    <div class="modal fade" id="productos" tabindex="-1" role="dialog" aria-labelledby="productosCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-width" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productosLongTitle">
                        Detalle del pedido
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="productostabla" class="table">
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Cantidad</th>
                                <th>Nombre</th>
                                <th>Precio Unitario</th>
                                <th>Subtotal</th>
                                <th>Sucursal</th>
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

    <div class="modal fade" id="modalUbicacion" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="tituloUbicacion">Ubicación del cliente</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Cliente:</strong> <span id="nombreCliente"></span></p>
                            <p><strong>Dirección:</strong> <span id="direccionCliente"></span></p>

                            <div class="mt-3">
                                <a id="btnGoogleMaps" href="#" target="_blank" class="btn btn-success">
                                    <i class="fas fa-map-marked-alt"></i> Abrir en Google Maps
                                </a>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div id="mapaUbicacion" style="height: 250px; border-radius: 8px; border: 1px solid #ddd;">
                            </div>
                            <p class="text-muted text-center mt-1" style="font-size: 12px;">
                                <i class="fas fa-info-circle"></i> Mapa interactivo - haz clic en el botón para ampliar
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para seleccionar repartidor -->
    <div class="modal fade" id="modalRepartidor" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Seleccionar Repartidor</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="mensajeRepartidor">Selecciona el repartidor para este pedido:</p>
                    <div class="form-group">
                        <label for="selectRepartidor">Repartidor:</label>
                        <select id="selectRepartidor" class="form-control">
                            <option value="">Seleccione un repartidor...</option>
                            @foreach ($repartidores as $repartidor)
                                <option value="{{ $repartidor->id }}">{{ $repartidor->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <input type="hidden" id="pedidoIdRepartidor" value="">
                    <input type="hidden" id="nuevoEstatusRepartidor" value="SELECCIONADO">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="asignarRepartidor()">Asignar
                        Repartidor</button>
                </div>
            </div>
        </div>
    </div>

    @include('fondo')
@stop

@section('css')
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <style>
        .custom-width {
            max-width: 90% !important;
        }

        /* Estilos para la ruta de estados */
        .badge {
            font-size: 14px;
            padding: 8px 15px;
        }

        .badge i {
            margin-right: 5px;
        }

        .fa-arrow-right {
            color: #6c757d;
        }
    </style>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            var pedidos = @json($pedidos);
            var tipo = @json($type);

            $('#pedidos').DataTable({
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
                destroy: true,
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
                "data": pedidos,
                "columns": [{
                        "data": "id"
                    },
                    {
                        "data": "estatus",
                        "render": function(data, type, row) {
                            function getBadgeColor(estatus) {
                                var colores = {
                                    'CREADO': 'primary',
                                    'SELECCIONADO': 'info',
                                    'SURTIDO': 'warning',
                                    'REVISADO': 'secondary',
                                    'EN RUTA': 'info',
                                    'ENTREGADO': 'success',
                                    'CANCELADO': 'danger',
                                    'FINALIZADO': 'success'
                                };
                                return colores[estatus] || 'secondary';
                            }
                            return '<span class="badge badge-' + getBadgeColor(data) + '">' + data +
                                '</span>';
                        }
                    },
                    {
                        "data": "fecha"
                    },
                    {
                        "data": "vendedor_nombre"
                    },
                    {
                        "data": "cliente_nombre"
                    },
                    {
                        "data": "productos",
                        "render": function(data, type, row) {
                            return '<button onclick="ver(' + row.id +
                                ')" class="btn btn-primary btn-sm">Ver</button>';
                        }
                    },
                    {
                        "data": "total"
                    },
                    {
                        // OPERACIONES
                        "data": "id",
                        "render": function(data, type, row) {
                            var esVendedor = (tipo == "1" || tipo == "2" || tipo == "3");

                            function getBadgeColor(estatus) {
                                var colores = {
                                    'CREADO': 'primary',
                                    'SELECCIONADO': 'info',
                                    'SURTIDO': 'warning',
                                    'REVISADO': 'secondary',
                                    'EN RUTA': 'info',
                                    'ENTREGADO': 'success',
                                    'CANCELADO': 'danger',
                                    'FINALIZADO': 'success'
                                };
                                return colores[estatus] || 'secondary';
                            }

                            if (!esVendedor) {
                                return '<span class="badge badge-' + getBadgeColor(row.estatus) +
                                    '">' + row.estatus + '</span>';
                            }

                            // Si el estado es CANCELADO, no mostrar botones
                            if (row.estatus == 'CANCELADO') {
                                return '<span class="badge badge-danger">CANCELADO</span>';
                            }

                            switch (row.estatus) {
                                case "CREADO":
                                    return '<button onclick="cambiarEstado(' + row.id +
                                        ', \'SELECCIONADO\')" class="btn btn-danger btn-sm">SELECCIONAR</button>';
                                case "SELECCIONADO":
                                    return '<button onclick="cambiarEstado(' + row.id +
                                        ', \'SURTIDO\')" class="btn btn-warning btn-sm">SURTIR</button>';
                                case "SURTIDO":
                                    return '<button onclick="cambiarEstado(' + row.id +
                                        ', \'REVISADO\')" class="btn btn-info btn-sm">REVISAR</button>';
                                case "REVISADO":
                                    return '<span class="badge badge-secondary">REVISADO</span>';
                                case "EN RUTA":
                                    return '<span class="badge badge-info">EN RUTA</span>';
                                case "ENTREGADO":
                                    return '<span class="badge badge-success">ENTREGADO</span>';
                                case "FINALIZADO":
                                    return '<span class="badge badge-success">FINALIZADO</span>';
                                default:
                                    return '<span class="badge badge-' + getBadgeColor(row
                                        .estatus) + '">' + row.estatus + '</span>';
                            }
                        }
                    },
                    {
                        // REPARTIDOR
                        "data": "repartidor_nombre",
                        "render": function(data, type, row) {
                            // Verificar si el pedido está en estado REVISADO o superior
                            var estadosBloqueados = ['REVISADO', 'EN RUTA', 'ENTREGADO',
                                'CANCELADO', 'FINALIZADO'
                            ];
                            var estaBloqueado = estadosBloqueados.includes(row.estatus);

                            // Si tiene repartidor asignado
                            if (data && data != '') {
                                // Si está bloqueado, mostrar solo el nombre sin botón
                                if (estaBloqueado) {
                                    return '<span class="badge badge-success">' + data + '</span>';
                                } else {
                                    // Si no está bloqueado, mostrar botón para editar
                                    return '<button class="btn btn-success btn-sm" onclick="abrirModalRepartidor(' +
                                        row.id + ')">' + data +
                                        ' <i class="fas fa-edit"></i></button>';
                                }
                            } else {
                                // Si no tiene repartidor
                                // Si está bloqueado o es CANCELADO/FINALIZADO, mostrar mensaje
                                if (estaBloqueado || row.estatus == 'CANCELADO' || row.estatus ==
                                    'FINALIZADO') {
                                    return '<span class="text-muted">Sin asignar</span>';
                                } else {
                                    // Si no está bloqueado, mostrar botón ASIGNAR
                                    return '<button class="btn btn-warning btn-sm" onclick="abrirModalRepartidor(' +
                                        row.id + ')">ASIGNAR</button>';
                                }
                            }
                        }
                    },
                    {
                        // Ubicación
                        "data": "id",
                        "render": function(data, type, row) {
                            return '<button onclick="ver_ubicacion(' + row.cliente +
                                ')" class="btn btn-secondary btn-sm">Ver Ubicación</button>';
                        }
                    },
                    {
                        // CANCELAR
                        "data": "id",
                        "render": function(data, type, row) {
                            // Solo mostrar botón de cancelar si NO está en ENTREGADO o FINALIZADO
                            if (row.estatus != 'ENTREGADO' && row.estatus != 'FINALIZADO') {
                                return '<button onclick="cambiarEstado(' + row.id +
                                    ', \'CANCELADO\')" class="btn btn-warning btn-sm">CANCELAR</button>';
                            } else {
                                return '-';
                            }
                        }
                    },
                    {
                        // REMISIONAR
                        "data": "id",
                        "render": function(data, type, row) {
                            if (row.estatus == "ENTREGADO") {
                                return '<button onclick="remisionar_pedido(' + row.id +
                                    ')" class="btn btn-danger btn-sm">REMISIONAR</button>';
                            } else {
                                return '-';
                            }
                        }
                    }
                ]
            });
        });

        function ver(id) {
            $('#productosLongTitle').text('Detalle del pedido #' + id);
            $('#productos').modal('show');

            $.ajax({
                url: 'verproductospedidos',
                type: 'GET',
                data: {
                    id: id
                },
                dataType: 'json',
                success: function(data) {
                    $('#productostabla').DataTable({
                        destroy: true,
                        scrollX: true,
                        scrollCollapse: true,
                        language: {
                            url: "{{ asset('js/datatables/lang/Spanish.json') }}"
                        },
                        buttons: ['copy', 'excel', 'pdf', 'print'],
                        dom: 'Blfrtip',
                        processing: true,
                        paging: true,
                        lengthMenu: [
                            [10, 25, 50, -1],
                            [10, 25, 50, 'All']
                        ],
                        data: data.productos,
                        columns: [{
                                data: "Codigo"
                            },
                            {
                                data: "Cantidad"
                            },
                            {
                                data: "Nombre",
                                width: "350px"
                            },
                            {
                                data: "Precio Unitario"
                            },
                            {
                                data: "Subtotal"
                            },
                            {
                                data: "Sucursal"
                            }
                        ]
                    });
                }
            });
        }

        function cambiarEstado(id, nuevoEstatus) {
            // Si el nuevo estatus es CANCELADO, validar que no sea ENTREGADO o FINALIZADO
            if (nuevoEstatus == 'CANCELADO') {
                var rowData = $('#pedidos').DataTable().row(function(idx, data, node) {
                    return data.id == id;
                }).data();

                if (rowData) {
                    if (rowData.estatus == 'ENTREGADO') {
                        Swal.fire({
                            title: 'No se puede cancelar',
                            text: 'El pedido ya fue entregado al cliente. No se puede cancelar.',
                            icon: 'error',
                            confirmButtonText: 'Aceptar'
                        });
                        return;
                    }

                    if (rowData.estatus == 'FINALIZADO') {
                        Swal.fire({
                            title: 'No se puede cancelar',
                            text: 'El pedido ya está finalizado. No se puede cancelar.',
                            icon: 'error',
                            confirmButtonText: 'Aceptar'
                        });
                        return;
                    }
                }
            }

            var configuraciones = {
                'SELECCIONADO': {
                    titulo: '¿Seleccionar pedido?',
                    texto: 'El pedido pasará a estado SELECCIONADO. ¿Deseas asignar un repartidor?',
                    icono: 'question',
                    confirmText: 'Sí, seleccionar',
                    necesitaRepartidor: true
                },
                'SURTIDO': {
                    titulo: '¿Surtir pedido?',
                    texto: 'El pedido pasará a estado SURTIDO.',
                    icono: 'warning',
                    confirmText: 'Sí, surtir',
                    necesitaRepartidor: false
                },
                'REVISADO': {
                    titulo: '¿Revisar pedido?',
                    texto: 'El pedido pasará a estado REVISADO.',
                    icono: 'info',
                    confirmText: 'Sí, revisar',
                    necesitaRepartidor: false
                },
                'CANCELADO': {
                    titulo: '¿Cancelar pedido?',
                    texto: 'Esta acción no se puede revertir. El pedido pasará a estado CANCELADO.',
                    icono: 'warning',
                    confirmText: 'Sí, cancelar',
                    necesitaRepartidor: false
                }
            };

            var config = configuraciones[nuevoEstatus];

            if (!config) {
                Swal.fire('Error', 'Estado no válido', 'error');
                return;
            }

            if (config.necesitaRepartidor) {
                $('#pedidoIdRepartidor').val(id);
                $('#nuevoEstatusRepartidor').val(nuevoEstatus);
                $('#selectRepartidor').val('');
                $('#modalRepartidor').modal('show');
                return;
            }

            Swal.fire({
                title: config.titulo,
                text: config.texto,
                icon: config.icono,
                showCancelButton: true,
                confirmButtonText: config.confirmText,
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    realizarCambioEstado(id, nuevoEstatus, null);
                }
            });
        }

        function abrirModalRepartidor(id) {
            // Guardar el ID del pedido
            $('#pedidoIdRepartidor').val(id);

            // Obtener el estatus actual del pedido
            var rowData = $('#pedidos').DataTable().row(function(idx, data, node) {
                return data.id == id;
            }).data();

            if (!rowData) {
                Swal.fire('Error', 'No se encontró el pedido', 'error');
                return;
            }

            // Verificar si el estado está bloqueado
            var estadosBloqueados = ['REVISADO', 'EN RUTA', 'ENTREGADO', 'CANCELADO', 'FINALIZADO'];
            if (estadosBloqueados.includes(rowData.estatus)) {
                Swal.fire({
                    title: 'Acción no permitida',
                    text: 'No se puede modificar el repartidor porque el pedido está en estado ' + rowData.estatus,
                    icon: 'warning',
                    confirmButtonText: 'Aceptar'
                });
                return;
            }

            // Determinar el nuevo estatus según el estatus actual
            var nuevoEstatus = '';
            var tituloModal = '';
            var mensajeModal = '';

            switch (rowData.estatus) {
                case "CREADO":
                    nuevoEstatus = 'SELECCIONADO';
                    tituloModal = 'Seleccionar Repartidor';
                    mensajeModal = 'Selecciona el repartidor para este pedido:';
                    break;
                default:
                    nuevoEstatus = rowData.estatus;
                    tituloModal = 'Cambiar Repartidor';
                    if (rowData.repartidor_nombre) {
                        mensajeModal = 'El pedido actualmente tiene asignado a: <strong>' + rowData.repartidor_nombre +
                            '</strong>. Selecciona un nuevo repartidor:';
                    } else {
                        mensajeModal = 'Selecciona un repartidor para este pedido:';
                    }
                    break;
            }

            $('#nuevoEstatusRepartidor').val(nuevoEstatus);
            $('#modalRepartidor .modal-title').text(tituloModal);
            $('#mensajeRepartidor').html(mensajeModal);

            // Preseleccionar el repartidor actual si existe
            $('#selectRepartidor').val(rowData.repartidor_id || '');

            // Mostrar el modal
            $('#modalRepartidor').modal('show');
        }

        function asignarRepartidor() {
            var id = $('#pedidoIdRepartidor').val();
            var repartidorId = $('#selectRepartidor').val();
            var nuevoEstatus = $('#nuevoEstatusRepartidor').val() || 'SELECCIONADO';

            if (!repartidorId) {
                Swal.fire('Error', 'Por favor selecciona un repartidor', 'warning');
                return;
            }

            // Obtener el estado actual para verificar si está bloqueado
            var rowData = $('#pedidos').DataTable().row(function(idx, data, node) {
                return data.id == id;
            }).data();

            if (rowData) {
                var estadosBloqueados = ['REVISADO', 'EN RUTA', 'ENTREGADO', 'CANCELADO', 'FINALIZADO'];
                if (estadosBloqueados.includes(rowData.estatus)) {
                    Swal.fire({
                        title: 'Acción no permitida',
                        text: 'No se puede modificar el repartidor porque el pedido está en estado ' + rowData
                            .estatus,
                        icon: 'warning',
                        confirmButtonText: 'Aceptar'
                    });
                    return;
                }
            }

            // Cerrar el modal de repartidor
            $('#modalRepartidor').modal('hide');

            var mensaje = '';
            if (rowData && rowData.repartidor_nombre) {
                mensaje = 'Se reemplazará al repartidor ' + rowData.repartidor_nombre +
                    ' por el nuevo repartidor seleccionado.';
            } else {
                mensaje = 'El pedido pasará a estado ' + nuevoEstatus + ' con el repartidor seleccionado.';
            }

            Swal.fire({
                title: '¿Confirmar asignación?',
                text: mensaje,
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí, confirmar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    realizarCambioEstado(id, nuevoEstatus, repartidorId);
                }
            });
        }

        function realizarCambioEstado(id, nuevoEstatus, repartidorId) {
            $.ajax({
                url: 'cambiarestadopedido',
                type: 'POST',
                data: {
                    id: id,
                    nuevoEstatus: nuevoEstatus,
                    repartidor_id: repartidorId,
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    var mensaje = '';
                    var esCambioRepartidor = false;

                    // Verificar si solo se cambió el repartidor (el estado no cambió)
                    var rowData = $('#pedidos').DataTable().row(function(idx, data, node) {
                        return data.id == id;
                    }).data();

                    if (rowData && rowData.estatus == nuevoEstatus) {
                        esCambioRepartidor = true;
                        mensaje = 'Repartidor actualizado correctamente';
                    } else {
                        switch (nuevoEstatus) {
                            case "SELECCIONADO":
                                mensaje = 'Pedido seleccionado correctamente con repartidor asignado';
                                break;
                            case "SURTIDO":
                                mensaje = 'Pedido surtido correctamente';
                                break;
                            case "REVISADO":
                                mensaje = 'Pedido revisado correctamente';
                                break;
                            case "CANCELADO":
                                mensaje = 'Pedido cancelado correctamente';
                                break;
                            default:
                                mensaje = 'Pedido actualizado correctamente';
                                break;
                        }
                    }

                    Swal.fire('Correcto', mensaje, 'success');

                    // Recargar la página para actualizar los datos
                    location.reload();
                },
                error: function(xhr) {
                    Swal.fire('Error', 'No se pudo actualizar el pedido', 'error');
                }
            });
        }

        function verRepartidor(id) {
            var rowData = $('#pedidos').DataTable().row(function(idx, data, node) {
                return data.id == id;
            }).data();

            if (rowData) {
                Swal.fire({
                    title: 'Repartidor asignado',
                    text: 'El repartidor asignado a este pedido es: ' + rowData.repartidor_nombre,
                    icon: 'info',
                    confirmButtonText: 'Aceptar'
                });
            }
        }

        function cancelar_pedido(id) {
            Swal.fire({
                title: '¿Cancelar pedido?',
                text: 'Esta acción no se puede revertir.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, cancelar',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: 'cancelarpedido',
                        type: 'POST',
                        data: {
                            id: id,
                            _token: '{{ csrf_token() }}'
                        },
                        success: function() {
                            Swal.fire('Cancelado', 'Pedido cancelado correctamente', 'success');
                            location.reload();
                        },
                        error: function() {
                            Swal.fire('Error', 'No se pudo cancelar el pedido', 'error');
                        }
                    });
                }
            });
        }

        function remisionar_pedido(id) {
            Swal.fire({
                title: '¿Remisionar pedido?',
                text: 'Se generará la remisión del pedido.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí, remisionar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: 'remisionar-pedido',
                        type: 'POST',
                        data: {
                            id: id,
                            _token: '{{ csrf_token() }}'
                        },
                        success: function() {
                            Swal.fire('Listo', 'Pedido remisionado correctamente', 'success');
                            location.reload();
                        },
                        error: function() {
                            Swal.fire('Error', 'No se pudo remisionar el pedido', 'error');
                        }
                    });
                }
            });
        }

        function ver_ubicacion(id) {
            $('#mapaUbicacion').html(
                '<div class="text-center p-5"><i class="fas fa-spinner fa-spin fa-2x"></i><br>Cargando mapa...</div>');
            $('#mapaUbicacion').show();

            $.ajax({
                url: 'verubicacioncliente',
                type: 'GET',
                data: {
                    id: id
                },
                success: function(data) {
                    $('#tituloUbicacion').text('Ubicación del cliente #' + id);
                    $('#nombreCliente').text(data.cliente);
                    $('#direccionCliente').text(data.direccion);

                    var googleMapsUrl = '';
                    if (data.lat && data.lng) {
                        googleMapsUrl = 'https://www.google.com/maps?q=' + data.lat + ',' + data.lng;
                    } else {
                        googleMapsUrl = 'https://www.google.com/maps?q=' + encodeURIComponent(data.direccion);
                    }

                    $('#btnGoogleMaps').attr('href', googleMapsUrl);

                    if (data.lat && data.lng) {
                        cargarMapaMiniatura(data.lat, data.lng);
                    } else {
                        $('#mapaUbicacion').html(
                            '<div class="text-center p-5 text-muted"><i class="fas fa-map-marked-alt fa-2x"></i><br>No hay coordenadas disponibles</div>'
                        );
                    }

                    $('#modalUbicacion').modal('show');
                },
                error: function() {
                    Swal.fire('Error', 'No se pudo obtener la ubicación', 'error');
                }
            });
        }

        function cargarMapaMiniatura(lat, lng) {
            var apiKey = 'AIzaSyBl0IgYJqu-RST8MQ_iIPjHWWcazxsO0KA';
            var staticMapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
                lat + ',' + lng +
                '&zoom=15&size=400x250&markers=color:red%7C' + lat + ',' + lng +
                '&key=' + apiKey;

            $('#mapaUbicacion').html('<img src="' + staticMapUrl +
                '" class="img-fluid rounded" style="width:100%; height:100%; object-fit:cover;">');
        }
    </script>
@stop
