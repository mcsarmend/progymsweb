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
        <div class="modal-dialog modal-dialog-centered custom-width " role="document">
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
                                <th>Codigo</th>
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

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

                            <!-- Botón para abrir en Google Maps -->
                            <div class="mt-3">
                                <a id="btnGoogleMaps" href="#" target="_blank" class="btn btn-success">
                                    <i class="fas fa-map-marked-alt"></i> Abrir en Google Maps
                                </a>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Mapa en miniatura -->
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
                    <p>Selecciona el repartidor para este pedido:</p>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="asignarRepartidor()">Asignar Repartidor</button>
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
                ], // Personalizar el menú de longitud de visualización

                // Configurar las opciones de exportación
                // Para PDF
                pdf: {
                    orientation: 'landscape', // Orientación del PDF (landscape o portrait)
                    pageSize: 'A4', // Tamaño del papel del PDF
                    exportOptions: {
                        columns: ':visible' // Exportar solo las columnas visibles
                    }
                },
                // Para Excel
                excel: {
                    exportOptions: {
                        columns: ':visible' // Exportar solo las columnas visibles
                    }
                },
                "data": pedidos,
                "columns": [{
                        "data": "id"
                    },
                    {
                        "data": "estatus"
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
                                ')" class="btn btn-primary">Ver</button>';
                        }
                    },

                    {
                        "data": "total"
                    },
                    {
                        // OPERACIONES
                        "data": "id",
                        "render": function(data, type, row) {
                            // Verificar el tipo de usuario
                            var esVendedor = (tipo == "1" || tipo == "2" || tipo == "3");

                            // Función para obtener el color según el estatus
                            function getBadgeColor(estatus) {
                                var colores = {
                                    'CREADO': 'primary',
                                    'SELECCIONADO': 'info',
                                    'SURTIDO': 'warning',
                                    'ENTREGADO': 'success',
                                    'CANCELADO': 'danger',
                                    'PENDIENTE': 'warning',
                                    'EN RUTA': 'info',
                                    'FINALIZADO': 'success'
                                };
                                return colores[estatus] || 'secondary';
                            }

                            // Si no es vendedor, mostrar el estatus
                            if (!esVendedor) {
                                return '<span class="badge badge-' + getBadgeColor(row.estatus) +
                                    '">' + row.estatus + '</span>';
                            }

                            // Mostrar diferentes botones según el estatus
                            switch (row.estatus) {
                                case "CREADO":
                                    return '<button onclick="cambiarEstado(' + row.id +
                                        ')" class="btn btn-danger btn-sm">SELECCIONAR</button>';
                                    break;

                                case "SELECCIONADO":
                                    return '<button onclick="cambiarEstado(' + row.id +
                                        ')" class="btn btn-warning btn-sm">SURTIR</button>';
                                    break;

                                case "SURTIDO":
                                    return '<span class="badge badge-info">EN RUTA</span>';
                                    break;

                                case "ENTREGADO":
                                    return '<button onclick="remisionar_pedido(' + row.id +
                                        ')" class="btn btn-success btn-sm">REMISIONAR</button>';
                                    break;

                                default:
                                    // Para cualquier otro estatus, mostrar el estatus como badge
                                    return '<span class="badge badge-' + getBadgeColor(row
                                        .estatus) + '">' + row.estatus + '</span>';
                            }
                        }
                    },
                    {
                        // REPARTIDOR
                        "data": "repartidor_nombre"
                    },
                    {
                        // Ubicación
                        "data": "id",
                        "render": function(data, type, row) {
                            return '<button onclick="ver_ubicacion(' + row.cliente +
                                ')" class="btn btn-secondary">Ver Ubicación</button>';
                        }
                    },
                    {
                        // CANCELAR
                        "data": "id",
                        "render": function(data, type, row) {
                            if (row.estatus == "CREADO") {
                                return '<button onclick="cancelar_pedido(' + row.id +
                                    ')" class="btn btn-warning">CANCELAR</button>';
                            } else {
                                return '-';
                            }
                        }
                    },
                    {
                        // REMISIONAR
                        "data": "id",
                        "render": function(data, type, row) {


                            if (row.estatus == "ENTREGADO" && (type == "1" || type == "2" || type ==
                                    "3")) {
                                return '<button onclick="remisionar_pedido(' + row.id +
                                    ')" class="btn btn-danger">SELECCIONAR</button>';
                            } else {
                                return '-';
                            }

                        }
                    },



                ]
            });
        });



        function ver(id) {

            // Cambiar título del modal
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
                            }
                        ]
                    });
                }
            });
        }


        function cambiarEstado(id) {
            // Primero obtenemos el estatus actual del pedido
            var rowData = $('#pedidos').DataTable().row(function(idx, data, node) {
                return data.id == id;
            }).data();

            if (!rowData) {
                Swal.fire('Error', 'No se encontró el pedido', 'error');
                return;
            }

            var estatusActual = rowData.estatus;
            var titulo = '';
            var texto = '';
            var icono = 'question';
            var confirmText = '';
            var nuevoEstatus = '';

            // Configurar según el estatus actual
            switch (estatusActual) {
                case "CREADO":
                    // Para CREADO, abrimos el modal de selección de repartidor
                    abrirModalRepartidor(id);
                    return; // Salimos de la función

                case "SELECCIONADO":
                    titulo = '¿Surtir pedido?';
                    texto = 'El pedido pasará a estado DESPACHADO.';
                    confirmText = 'Sí, surtir';
                    nuevoEstatus = 'DESPACHADO';
                    icono = 'warning';
                    break;

                case "ENTREGADO":
                    titulo = '¿Remisionar pedido?';
                    texto = 'Se generará la remisión del pedido.';
                    confirmText = 'Sí, remisionar';
                    nuevoEstatus = 'REMISIONADO';
                    icono = 'success';
                    break;

                default:
                    Swal.fire('Info', 'No hay operaciones disponibles para este pedido', 'info');
                    return;
            }

            // Mostrar SweetAlert para los otros casos
            Swal.fire({
                title: titulo,
                text: texto,
                icon: icono,
                showCancelButton: true,
                confirmButtonText: confirmText,
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    realizarCambioEstado(id, nuevoEstatus, null);
                }
            });
        }

        function abrirModalRepartidor(id) {
            // Guardar el ID del pedido en el campo oculto
            $('#pedidoIdRepartidor').val(id);
            // Limpiar selección anterior
            $('#selectRepartidor').val('');
            // Mostrar el modal
            $('#modalRepartidor').modal('show');
        }

        function asignarRepartidor() {
            var id = $('#pedidoIdRepartidor').val();
            var repartidorId = $('#selectRepartidor').val();

            if (!repartidorId) {
                Swal.fire('Error', 'Por favor selecciona un repartidor', 'warning');
                return;
            }

            // Cerrar el modal de repartidor
            $('#modalRepartidor').modal('hide');

            // Mostrar confirmación
            Swal.fire({
                title: '¿Seleccionar pedido?',
                text: 'El pedido pasará a estado SELECCIONADO con el repartidor seleccionado.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí, seleccionar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Realizar el cambio de estado con el repartidor
                    realizarCambioEstado(id, 'SELECCIONADO', repartidorId);
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
                    repartidor_id: repartidorId, // Enviar el repartidor si existe
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    var mensaje = '';
                    switch (nuevoEstatus) {
                        case "SELECCIONADO":
                            mensaje = 'Pedido seleccionado correctamente con repartidor asignado';
                            break;
                        case "SURTIDO":
                            mensaje = 'Pedido surtido correctamente';
                            break;
                        case "ENTREGADO":
                            mensaje = 'Pedido entregado correctamente';
                            break;
                        case "REMISIONADO":
                            mensaje = 'Pedido remisionado correctamente';
                            break;
                    }
                    Swal.fire('Correcto', mensaje, 'success');
                    // Recargar la página para actualizar los datos
                    location.reload();
                },
                error: function(xhr) {
                    var mensaje = '';
                    switch (nuevoEstatus) {
                        case "SELECCIONADO":
                            mensaje = 'No se pudo seleccionar el pedido';
                            break;
                        case "SURTIDO":
                            mensaje = 'No se pudo surtir el pedido';
                            break;
                        case "ENTREGADO":
                            mensaje = 'No se pudo entregar el pedido';
                            break;
                        case "REMISIONADO":
                            mensaje = 'No se pudo remisionar el pedido';
                            break;
                    }
                    Swal.fire('Error', mensaje, 'error');
                }
            });
        }

        function despachar_pedido(id) {
            Swal.fire({
                title: '¿Despachar pedido?',
                text: 'El pedido pasará a DESPACHADO.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, despachar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {

                    $.ajax({
                        url: 'despacharpedido',
                        type: 'POST',
                        data: {
                            id: id,
                            _token: '{{ csrf_token() }}'
                        },
                        success: function() {
                            Swal.fire('Correcto', 'Pedido despachado correctamente', 'success');
                            $('#pedidos').DataTable().ajax.reload(null, false);
                        },
                        error: function() {
                            Swal.fire('Error', 'No se pudo despachar el pedido', 'error');
                        }
                    });

                }
            });
        }


        function estatus_repartidor(id) {
            Swal.fire({
                title: '¿Marcar como entregado?',
                text: 'El pedido se marcará como ENTREGADO.',
                icon: 'info',
                showCancelButton: true,
                confirmButtonText: 'Sí, entregar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {

                    $.ajax({
                        url: 'entregarpedido',
                        type: 'POST',
                        data: {
                            id: id,
                            _token: '{{ csrf_token() }}'
                        },
                        success: function() {
                            Swal.fire('Entregado', 'Pedido entregado correctamente', 'success');
                            $('#pedidos').DataTable().ajax.reload(null, false);
                        },
                        error: function() {
                            Swal.fire('Error', 'No se pudo marcar como entregado', 'error');
                        }
                    });

                }
            });
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
                            $('#pedidos').DataTable().ajax.reload(null, false);
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
                            $('#pedidos').DataTable().ajax.reload(null, false);
                        },
                        error: function() {
                            Swal.fire('Error', 'No se pudo remisionar el pedido', 'error');
                        }
                    });

                }
            });
        }


        function ver_ubicacion(id) {
            // Mostrar loading en el mapa
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

                    // Construir URL de Google Maps
                    var googleMapsUrl = '';
                    if (data.lat && data.lng) {
                        googleMapsUrl = 'https://www.google.com/maps?q=' + data.lat + ',' + data.lng;
                    } else {
                        googleMapsUrl = 'https://www.google.com/maps?q=' + encodeURIComponent(data.direccion);
                    }

                    $('#btnGoogleMaps').attr('href', googleMapsUrl);

                    // Cargar el mapa en miniatura si hay coordenadas
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
            // Usar Google Maps Static API para una imagen en miniatura
            // Necesitas una API Key de Google
            var apiKey = 'AIzaSyBl0IgYJqu-RST8MQ_iIPjHWWcazxsO0KA'; // Reemplaza con tu API Key

            // Opción 1: Imagen estática (más rápido, no necesita cargar la librería completa)
            var staticMapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
                lat + ',' + lng +
                '&zoom=15&size=400x250&markers=color:red%7C' + lat + ',' + lng +
                '&key=' + apiKey;

            $('#mapaUbicacion').html('<img src="' + staticMapUrl +
                '" class="img-fluid rounded" style="width:100%; height:100%; object-fit:cover;">');
        }

        function cargarMapa(lat, lng) {
            // Asegurarse de que el mapa esté visible
            $('#mapaUbicacion').show();

            const map = new google.maps.Map(document.getElementById("mapaUbicacion"), {
                zoom: 16,
                center: {
                    lat: parseFloat(lat),
                    lng: parseFloat(lng)
                }
            });

            new google.maps.Marker({
                position: {
                    lat: parseFloat(lat),
                    lng: parseFloat(lng)
                },
                map: map
            });
        }


        //
    </script>
@stop
