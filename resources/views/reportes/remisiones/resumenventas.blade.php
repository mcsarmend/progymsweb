@extends('adminlte::page')

@section('title', 'Reporte Producto Movimiento')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Reporte Producto Movimiento</h1>
        </div>
        <div class="card-body">
            <form method="post" id="buscarproductoform">

                <div class="row">
                    <div class="col">
                        <div class="btn btn-primary" onclick="buscarProducto()">Indicar Producto</div>
                    </div>
                </div>
                <div class="col"><label for="producto">Producto:</label></div>
                <div class="col">
                    <input type="text" name="producto" id="producto" class="form-control">
                </div>

                <div class="row">
                    <button type="submit" class="btn btn-success">Buscar producto</button>
                </div>
            </form>


            <table id="compras" class="table table-striped">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Movimiento</th>
                        <th>Autor</th>
                        <th>Documento</th>
                        <th>Productos</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

    </div>


    <div class="modal fade" id="productos" tabindex="-1" role="dialog" aria-labelledby="productosCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-width " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productosLongTitle">Detalle de productos</h5>
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
                                <th>Producto</th>
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
            drawTriangles();
            showUsersSections();
        });

        $('#buscarproductoform').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/buscarproductomovimiento', // Ruta al controlador de Laravel
                type: 'GET',
                // data: datosFormulario, // Enviar los datos del formulario
                data: datosFormulario,

                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );

                    $('#compras').DataTable({
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
                        "data": response.compras,
                        "columns": [{
                                "data": "fecha"
                            },
                            {
                                "data": "movimiento"
                            },
                            {
                                "data": "autor"
                            },
                            {
                                "data": "documento"
                            },

                            {
                                "data": null,
                                "render": function(data, type, row) {
                                    let unit = parseFloat(row["Costo Unitario"]);
                                    let compra = parseFloat(row["Costo en Compra"]);

                                    if (compra < unit) {
                                        return "Bajó";
                                    } else if (compra > unit) {
                                        return "Subió";
                                    } else {
                                        return "No aplica";
                                    }
                                }
                            }


                        ]
                    });
                },
                error: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        "Existe un error: " + response.message,
                        'error'
                    )
                }
            });
        });

        function ver(id) {
            $('#productos').modal('show');


            $.ajax({
                url: 'verproductosmovimiento', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
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
                                "data": "Costo Unitario"
                            },
                            {
                                "data": "Costo en Compra"
                            },
                            {
                                "data": null,
                                "render": function(data, type, row) {
                                    // row["Costo Unitario"] → viene como string
                                    // row["Costo en Compra"] → viene como string
                                    let unit = parseFloat(row["Costo Unitario"]);
                                    let compra = parseFloat(row["Costo en Compra"]);

                                    return unit !== compra ? "Sí" : "No";
                                }
                            }

                        ]
                    });
                }
            });
        }
    </script>
@stop
