@extends('adminlte::page')

@section('title', 'Multialmacén')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">

            <div class="card">
                <div class="card-header">
                    <h1>Multialmacén</h1>
                </div>
                <div class="card-body">

                    <br>
                    <table id="productos" class="table">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Categoria</th>
                                <th>Público</th>
                                <th>Frecuente</th>
                                <th>Mayoreo</th>
                                <th>Distribuidor</th>
                                <th>Existencias Totales</th>
                                <th>Almacèn Principal</th>
                                <th>Viveros</th>
                                <th>TownCenter</th>
                                <th>Coacalco</th>
                                <th>Villas</th>
                                <th>Naucalpan</th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>






    @include('fondo')
@stop

@section('css')

@stop

@section('js')
    <script src="https://cdn.datatables.net/fixedheader/3.2.0/js/dataTables.fixedHeader.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.2.0/css/fixedHeader.dataTables.min.css">
    <script>
        $(document).ready(function() {
            var products = @json($products);
            $('#productos').DataTable({
                destroy: true,
                scrollX: true,
                fixedHeader: true,
                scrollY: '700px',
                scrollCollapse: true,
                "language": {
                    "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                "buttons": [
                    'copy', 'excel', 'pdf', 'print'
                ],
                dom: 'Blfrtip',
                createdRow: function(row, data, dataIndex) {
                    $(row).css('font-size', '12px');
                    $(row).addClass(dataIndex % 2 === 0 ? 'bg-white' : 'bg-secondary text-white');
                },
                pageLength: 50,
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
                        "data": "codigo"
                    },
                    {
                        "data": "producto"
                    },
                    {
                        "data": "marca"
                    },
                    {
                        "data": "categoria"
                    },
                    {
                        "data": "publico",
                        "render": function(data, type, row) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "frecuente",
                        "render": function(data, type, row) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "mayoreo",
                        "render": function(data, type, row) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "distribuidor",
                        "render": function(data, type, row) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "totales"
                    },
                    {
                        "data": "almacen_principal"
                    },
                    {
                        "data": "viveros"
                    },
                    {
                        "data": "towncenter"
                    },
                    {
                        "data": "coacalco"
                    },
                    {
                        "data": "villas"
                    },
                    {
                        "data": "naucalpan"
                    }

                ]
            });
            drawTriangles();
            showUsersSections();
        });
    </script>
@stop
