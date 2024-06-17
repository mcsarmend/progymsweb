@extends('adminlte::page')

@section('title', 'Editar Inventario')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Editar Inventario</h1>
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

                    <form id="enviareditaralmacenesform">
                        @csrf
                        <input id ="idproducto" name ="idproducto" class="form-control" readonly>
                        <input id ="idwarehouse" name ="idwarehouse" class="form-control" style="display: none">
                        <input id ="nombrealmacen" name ="nombrealmacen" class="form-control">
                        <input type="text" id = "existencias" name="existencias" class="form-control">
                        <br>
                        <div class="row">
                            <div class="col">
                                <input type="submit" value="Enviar" class="btn btn-success">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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
                    <button type="submit" class="btn btn-primary" data-dismiss="modal">Enviar</button>
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

        var products = @json($productos);
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
                    "data": "almacenes",
                    "render": function(data, type, row) {
                        return '<button onclick="editaralmacenes(' + row.id +
                            ')" class="btn btn-primary">Editar</button>';
                    }
                },
                {
                    "data": "precios",
                    "render": function(data, type, row) {
                        return '<button onclick="editarprecios(' + row.id +
                            ')" class="btn btn-primary">Editar</button>';
                    }
                },
            ]
        });

        function editaralmacenes(id) {
            $('#almacenes').modal('show');

            $.ajax({
                url: 'detalleamacenes', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id_producto: id
                },
                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {

                    $('#idproducto').val(data[0].idproducto);
                    $('#nombrealmacen').val(data[0].nombre);
                    $('#idwarehouse').val(data[0].id);
                    $('#existencias').val(data[0].existencias);


                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud
                    console.error(error); // Muestra el error en la consola del navegador
                }
            });
        }

        function editarprecios(id) {
            $('#precios').modal('show');

            $.ajax({
                url: 'detalleprecios', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id_producto: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {

                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud
                    console.error(error); // Muestra el error en la consola del navegador
                }
            });
        }



        $('#enviareditaralmacenesform').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/enviareditaralmacenes', // Ruta al controlador de Laravel
                type: 'POST',
                data: datosFormulario, // Enviar los datos del formulario
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );
                    setTimeout(function() {
                        window.location.reload();
                    }, 3000);
                    generarContrasena();
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
    </script>
@stop
