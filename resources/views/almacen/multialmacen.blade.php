@extends('adminlte::page')

@section('title', 'Multialmacén')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Multialmacén</h1>
        </div>
        <div class="card-body">

            <div class="card">

                <div class="card-body">
                    <table id="productos" class="table">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Categoria</th>
                                <th>Existencias</th>
                                <th>Almacenes</th>
                                <th>Precios</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>





    <div class="modal fade" id="almacenes" tabindex="-1" role="dialog" aria-labelledby="almacenesCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="almacenesLongTitle">Detalle de almacenes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="almacenestabla" class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Almacen</th>
                                <th>Existencias</th>
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

    <div class="modal fade" id="precios" tabindex="-1" role="dialog" aria-labelledby="preciosCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="preciosLongTitle">Detalle de precios</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="preciostabla" class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tipo</th>
                                <th>Precio</th>
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

    @include('fondo')
@stop

@section('css')

@stop

@section('js')

    <script>
        $(document).ready(function() {
            var products = @json($products);
            $('#productos').DataTable({
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
                "data": products,
                "columns": [{
                        "data": "id"
                    },
                    {
                        "data": "nombre"
                    },
                    {
                        "data": "marca"
                    },
                    {
                        "data": "categoria"
                    },
                    {
                        "data": "existencias"
                    },
                    {
                        "data": "almacenes",
                        "render": function(data, type, row) {
                            return '<button onclick="veralmacenes(' + row.id +
                                ')" class="btn btn-primary">Ver</button>';
                        }
                    },
                    {
                        "data": "precios",
                        "render": function(data, type, row) {
                            return '<button onclick="verprecios(' + row.id +
                                ')" class="btn btn-primary">Ver</button>';
                        }
                    },
                ]
            });
            drawTriangles();
            showUsersSections();
        });


        function veralmacenes(id) {
            $('#almacenes').modal('show');

            $.ajax({
                url: 'detalleamacenes', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id_producto: id
                },
                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    $('#almacenestabla').DataTable({
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
                        "data": data,
                        "columns": [{
                                "data": "idproducto"
                            },
                            {
                                "data": "nombre"
                            },
                            {
                                "data": "existencias"
                            }
                        ]
                    });
                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud
                    console.error(error); // Muestra el error en la consola del navegador
                }
            });
        }

        function verprecios(id) {
            $('#precios').modal('show');

            $.ajax({
                url: 'detalleprecios', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id_producto: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    $('#preciostabla').DataTable({
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
                        "data": data,
                        "columns": [{
                                "data": "idproducto"
                            },
                            {
                                "data": "nombre"
                            },
                            {
                                "data": "price"
                            }
                        ]
                    });
                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud
                    console.error(error); // Muestra el error en la consola del navegador
                }
            });
        }
    </script>
@stop
