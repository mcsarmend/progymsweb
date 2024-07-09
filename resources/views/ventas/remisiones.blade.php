@extends('adminlte::page')

@section('title', 'Remisiones')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Remisiones</h2>
        </div>
        <div class="card-body">
            <table id="remisiones" class="table">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Fecha</th>
                        <th>Nota</th>
                        <th>Forma de pago</th>
                        <th>Almacen</th>
                        <th>Vendedor</th>
                        <th>Productos</th>
                        <th>Total</th>
                        <th>Estatus</th>
                        <th>Cancelar</th>

                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
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


    @include('fondo')
@stop

@section('css')
    <style>
        .modal-dialog.custom-width {
            max-width: 40%;
            /* Ajusta este valor según tus necesidades */
        }
    </style>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            var remisiones = @json($remisiones);
            $('#remisiones').DataTable({
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
                "data": remisiones,
                "columns": [{
                        "data": "id"
                    },
                    {
                        "data": "fecha"
                    },
                    {
                        "data": "nota"
                    },
                    {
                        "data": "forma_pago"
                    },
                    {
                        "data": "almacen"
                    },
                    {
                        "data": "vendedor"
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
                        "data": "estatus"
                    },
                    {
                        "data": "cancelar",
                        "render": function(data, type, row) {

                            if (row.estatus == "cancelada") {
                                return '-';
                            } else {

                                return '<button onclick="cancelar_remision(' + row.id +
                                    ')" class="btn btn-danger">Cancelar</button>';
                            }

                        }
                    },

                ]
            });
        });


        function ver(id) {
            $('#productos').modal('show');


            $.ajax({
                url: 'verproductosremision', // URL a la que se hace la solicitud
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
                                "data": "Precio Unitario"
                            },
                            {
                                "data": "Subtotal"
                            },
                        ]
                    });
                }
            });
        }

        function cancelar_remision(id) {

            Swal.fire({
                title: "¿Estas seguro?",
                text: "¡Esta acción no se puede revertir!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "¡Si, cancelar remisión!"
            }).then((result) => {
                if (result.isConfirmed) {

                    $.ajax({
                        url: 'cancelarremision', // URL a la que se hace la solicitud
                        type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                        data: {
                            id: id
                        },
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        dataType: 'json', // Tipo de datos esperados en la respuesta
                        success: function(data) {
                            Swal.fire({
                                title: "¡Cancelada!",
                                text: "La remisón ha sido cancelada.",
                                icon: "success"
                            });

                            setTimeout(function() {
                                window.location.reload();
                            }, 3000);
                        }
                    });
                }
            });

        }
    </script>
@stop
