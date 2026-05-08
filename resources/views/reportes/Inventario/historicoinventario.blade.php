@extends('adminlte::page')

@section('title', 'Reporte Historico de Inventario')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Reporte Historico de Inventario</h1>
        </div>
        <div class="card-body">
            <form method="post" id="buscarproductoform" class="border p-3 rounded">
                <div class="row align-items-center g-2">

                    <div class="col-auto">
                        <label for="fechainicio" class="form-label mb-0">Fecha inicio:</label>
                    </div>
                    <div class="col-auto">
                        <input type="date" name="fechainicio" id="fechainicio" class="form-control" required>
                    </div>

                    <div class="col-auto">
                        <label for="fechafin" class="form-label mb-0">Fecha fin:</label>
                    </div>
                    <div class="col-auto">
                        <input type="date" name="fechafin" id="fechafin" class="form-control" required>
                    </div>

                    <div class="col-auto">
                        <button type="submit" class="btn btn-success">Generar reporte historico</button>
                    </div>

                </div>
            </form>



            <table id="historico" class="table table-striped">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Total Costos</th>
                        <th>Cantidad de productos</th>
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
                url: '/generarreportehistorico', // Ruta al controlador de Laravel
                type: 'GET',
                // data: datosFormulario, // Enviar los datos del formulario
                data: datosFormulario,

                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );

                    $('#historico').DataTable({
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
                        processing: true,
                        sort: true,
                        paging: true,
                        lengthMenu: [
                            [10, 25, 50, -1],
                            [10, 25, 50, 'All']
                        ],

                        "data": response.historico,
                        "columns": [{
                                "data": "fecha"
                            },

                            {
                                "data": "total_compra",
                                "render": function(data, type, row) {
                                    // Si el valor es nulo o vacío
                                    if (!data) return "$0.00";

                                    // Formato moneda MX
                                    return "$" + Number(data).toLocaleString('es-MX', {
                                        minimumFractionDigits: 2,
                                        maximumFractionDigits: 2
                                    });
                                }
                            },

                            {
                                "data": "total_productos",
                                "render": function(data, type, row) {
                                    if (!data) return "0";
                                    return Number(data).toLocaleString('es-MX');
                                }
                            },

                            {
                                "data": "id",
                                "render": function(data, type, row) {
                                    return '<button onclick="descargar(' + row.id +
                                        ')" class="btn btn-primary">Descargar</button>';
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

        function descargar(id) {



            $.ajax({
                url: 'verproductoshistorico', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    nombre =  "Historico "+ data.data[0].fecha + ".xlsx";
                    let json = JSON.parse(data.data[0].datos);
                    exportarexcel(json,nombre);
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



        function obtenerNumerosHastaGuion(text) {
            return text.split('-')[0];
        }
    </script>
@stop
