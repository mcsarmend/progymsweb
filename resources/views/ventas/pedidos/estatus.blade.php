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
                                <th>Vendedor</th>
                                <th>Cliente</th>
                                <th>Productos</th>
                                <th>Total</th>
                                <th>Operaciones</th>
                                <th>Almacenista</th>
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
                    <p><strong>Cliente:</strong> <span id="nombreCliente"></span></p>
                    <p><strong>Dirección:</strong> <span id="direccionCliente"></span></p>
                    <p><strong>Referencia:</strong> <span id="referenciaCliente"></span></p>

                    <div id="mapaUbicacion" style="height: 300px;"></div>
                </div>
            </div>
        </div>
    </div>


    @include('fondo')
@stop

@section('css')
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
                        "data": "vendedor"
                    },
                    {
                        "data": "cliente"
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

                            if (row.estatus == "CREADO" && (tipo == "1" || tipo == "2" || tipo ==
                                    "3")) {
                                return '<button onclick="seleccionar_pedido(' + row.id +
                                    ')" class="btn btn-danger">SELECCIONAR</button>';
                            } else {
                                return '-';
                            }

                        }
                    },
                    {
                        // ALMACENISTA
                        "data": "id",
                        "render": function(data, type, row) {

                            if (row.estatus == "SELECCIONADO" && (tipo == "5")) {
                                return '<button onclick="despachar_pedido(' + row.id +
                                    ')" class="btn btn-danger">SELECCIONAR</button>';
                            } else {
                                return '-';
                            }

                        }
                    },
                    {
                        // REPARTOS
                        "data": "id",
                        "render": function(data, type, row) {

                            if (row.estatus == "DESPACHADO" && (tipo == "5")) {
                                return '<button onclick="estatus_repartidor(' + row.id +
                                    ')" class="btn btn-danger">SELECCIONAR</button>';
                            } else {
                                return '-';
                            }

                        }
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


        function seleccionar_pedido(id) {
            Swal.fire({
                title: '¿Seleccionar pedido?',
                text: 'El pedido pasará a estado SELECCIONADO.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí, seleccionar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {

                    $.ajax({
                        url: 'seleccionarpedido',
                        type: 'POST',
                        data: {
                            id: id,
                            _token: '{{ csrf_token() }}'
                        },
                        success: function(response) {
                            Swal.fire('Correcto', 'Pedido seleccionado', 'success');
                            $('#pedidos').DataTable().ajax.reload(null, false);
                        },
                        error: function() {
                            Swal.fire('Error', 'No se pudo seleccionar el pedido', 'error');
                        }
                    });

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
                    $('#referenciaCliente').text(data.referencia);

                    $('#modalUbicacion').modal('show');

                    // Si manejas coordenadas
                    if (data.lat && data.lng) {
                        cargarMapa(data.lat, data.lng);
                    }
                },
                error: function() {
                    Swal.fire('Error', 'No se pudo obtener la ubicación', 'error');
                }
            });
        }


        function cargarMapa(lat, lng) {
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
