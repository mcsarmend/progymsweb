@extends('adminlte::page')

@section('title', 'Reportes de Lista de precios')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Reportes de Lista de precios</h1>
        </div>
        <div class="card-body">
            <div class="container">
                <div class="row">
                    <table class="table table-hover" id="table-products">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Producto</th>
                                <th>Marca</th>
                                <th>Categoria</th>
                                <th>Público</th>
                                <th>Frecuente</th>
                                <th>Mayoreo</th>
                                <th>Distribuidor</th>
                            </tr>
                        </thead>
                    </table>
                </div>
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

            var products = @json($products); // Esto convierte los productos en un array de JavaScript

            $('#table-products').DataTable({
                destroy: true,
                scrollX: true,
                scrollCollapse: true,
                "language": {
                    "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                "buttons": [

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
                    }
                ]
            });

        });
    </script>
@stop
