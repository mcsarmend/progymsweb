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
            <form method="post" id="buscarproductoform" class="border p-3 rounded">

                <!-- FILA NUEVA: FECHAS -->
                <div class="row align-items-center mb-3">
                    <div class="col-md-2">
                        <label for="fechainicio" class="form-label">Fecha inicio:</label>
                    </div>
                    <div class="col-md-4">
                        <input type="date" name="fechainicio" id="fechainicio" class="form-control" required>
                    </div>

                    <div class="col-md-2">
                        <label for="fechafin" class="form-label">Fecha fin:</label>
                    </div>
                    <div class="col-md-4">
                        <input type="date" name="fechafin" id="fechafin" class="form-control" required>
                    </div>
                </div>

                <!-- FILA ORIGINAL -->
                <div class="row align-items-center mb-3">
                    <div class="col-md-2">
                        <button type="button" class="btn btn-primary w-100" onclick="buscarProducto()">Indicar
                            Producto</button>
                    </div>
                    <div class="col-md-1">
                        <label for="producto" class="form-label">Producto:</label>
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="producto" id="producto" class="form-control" required>
                    </div>
                    <div class="col-md-1">
                        <label for="nombreproducto" class="form-label">Nombre:</label>
                    </div>
                    <div class="col-md-4">
                        <input type="text" name="nombreproducto" id="nombreproducto" class="form-control" disabled>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-success w-100 py-2">Buscar Producto</button>
                    </div>
                </div>

            </form>



            <table id="movimientos" class="table table-striped">
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

                    $('#movimientos').DataTable({
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
                        "data": response.movimientos,
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
                                "data": "productos",
                                "render": function(data, type, row) {
                                    return '<button onclick="ver(' + row.id +
                                        ')" class="btn btn-primary">Ver</button>';
                                }
                            },



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
                            }
                        ]
                    });
                }
            });
        }

        function buscarProducto() {
            // obtener HTML directamente (generateOptions devuelve cadena)
            var optionsHtml = generateOptions();

            Swal.fire({
                title: 'Productos',
                html: `
            <label for="inputWithDatalist">Selecciona un producto:</label>
            <input list="datalistOptions" id="inputWithDatalist" class="form-control col-sm-14" placeholder="Escribe para buscar...">
            <datalist id="datalistOptions">
               ${optionsHtml}
            </datalist>
            <br>
        `,
                focusConfirm: false,
                preConfirm: () => {
                    const producto = document.getElementById('inputWithDatalist').value;
                    if (!producto) {
                        Swal.showValidationMessage('Por favor selecciona un producto');
                        return false;
                    }
                    return {
                        producto: producto
                    };
                },
                showCancelButton: true,
                confirmButtonText: 'Siguiente',
                cancelButtonText: 'Cerrar'
            }).then((result) => {
                if (result.isConfirmed && result.value) {
                    const seleccionado = result.value.producto;
                    const idproducto = obtenerNumerosHastaGuion(seleccionado);
                    $('#producto').val(idproducto);
                    // nombre: todo después del primer '-' si existe, si no, mostrar toda la cadena menos el id
                    const partes = seleccionado.split('-');
                    if (partes.length > 1) {
                        partes.shift(); // quitar id
                        $('#nombreproducto').val(partes.join('-').trim());
                    } else {
                        // si no hay guion, quitar posible id inicial (números) y mostrar resto
                        $('#nombreproducto').val(seleccionado.replace(/^\d+\s*-?\s*/, '').trim());
                    }
                }
            });
        }

        function generateOptions() {
            var options = @json($productos);
            var dataList = '';
            options.forEach(function(item) {
                dataList += `<option value="${item.id}-${item.nombre}">`;
            });
            return dataList;
        }


        function obtenerNumerosHastaGuion(text) {
            return text.split('-')[0];
        }
    </script>
@stop
