@extends('adminlte::page')

@section('title', 'Reporte > Inventario > Imagen de inventario')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style ="font-size: 2rem">Reporte > Inventario > Existencias y Costos</h1>
                </div>
                <div class="card-body">
                    <table id=clientes class="table">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Telefono</th>
                                <th>Sucursal</th>
                                <th>Precio</th>
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
    <script>
        $(document).ready(function() {

            // $('#clientes').DataTable({
            //     destroy: true,
            //     scrollX: true,
            //     scrollCollapse: true,
            //     "language": {
            //         "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
            //     },
            //     "buttons": [
            //         'copy', 'excel', 'pdf', 'print'
            //     ],
            //     dom: 'Blfrtip',
            //     destroy: true,
            //     processing: true,
            //     sort: true,
            //     paging: true,
            //     lengthMenu: [
            //         [10, 25, 50, -1],
            //         [10, 25, 50, 'All']
            //     ], // Personalizar el menú de longitud de visualización

            //     // Configurar las opciones de exportación
            //     // Para PDF
            //     pdf: {
            //         orientation: 'landscape', // Orientación del PDF (landscape o portrait)
            //         pageSize: 'A4', // Tamaño del papel del PDF
            //         exportOptions: {
            //             columns: ':visible' // Exportar solo las columnas visibles
            //         }
            //     },
            //     // Para Excel
            //     excel: {
            //         exportOptions: {
            //             columns: ':visible' // Exportar solo las columnas visibles
            //         }
            //     },
            //     "data": clientes,
            //     "columns": [{
            //             "data": "nombre"
            //         },
            //         {
            //             "data": "telefono"
            //         },
            //         {
            //             "data": "sucursal"
            //         },
            //         {
            //             "data": "precio"
            //         }
            //     ]
            // });
            drawTriangles();
            showUsersSections();
        });
    </script>
@stop
