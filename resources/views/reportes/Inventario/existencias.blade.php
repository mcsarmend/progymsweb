@extends('adminlte::page')

@section('title', 'Existencias y Costos')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">

            <div class="card">
                <div class="card-header">
                    <h1>Precios y existencias</h1>
                </div>
                <div class="card-body">

                    <form method="POST" id="existencias_form">
                        @csrf
                        <div class="row justify-content-center align-items-center text-center">
                            <div class="col-auto">
                                <label for="">Almacen:</label>
                                <select class="form-control" name="almacen" id="almacen" required>
                                    <option class="form-control" value="0">Todos</option>
                                    @foreach ($almacenes as $almacen)
                                        <option class="form-control" value="{{ $almacen->id }}">{{ $almacen->nombre }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="submit" class="btn btn-success">Descargar</button>
                            </div>

                        </div>
                    </form>
                    <br>

                    <div class="col-12 col-md-6 mb-3 mx-auto">
                        <div class="card bg-primary text-white shadow h-100">
                            <div class="card-body text-center">
                                <h3><i class=""></i> Total Costos</h3>
                                <h1 id="total_costos" class="display-4" style="color: #00ffa6;">$0.00</h1>
                            </div>
                        </div>
                    </div>
                    <table id="productos" class="table">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Categoria</th>
                                <th>Costo</th>
                                <th>Costo Promedio</th>
                                <th>Público</th>
                                <th>Frecuente</th>
                                <th>Mayoreo</th>
                                <th>Distribuidor</th>
                                <th>Platinum</th>
                                <th>Existencias Totales</th>
                                <th>Bodega</th>
                                <th>TownCenter</th>
                                <th>Coacalco</th>
                                <th>Naucalpan</th>
                                <th>Tienda Piso</th>
                                <th>Pedidos</th>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.2.0/js/dataTables.fixedHeader.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.2.0/css/fixedHeader.dataTables.min.css">

    <script>
        $(document).ready(function() {
            var products = @json($products);
            var total_costos = @json($total_costos);
            $('#total_costos').text(
                '$' + Number(total_costos).toLocaleString('es-MX', {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                })
            );

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

                ],
                dom: 'Blfrtip',
                createdRow: function(row, data, dataIndex) {
                    $(row).css('font-size', '17px');
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

                "data": products,
                "columns": [{
                        "data": "codigo"
                    },
                    {
                        "data": "producto",
                        "width": "350px"
                    },
                    {
                        "data": "marca"
                    },
                    {
                        "data": "categoria"
                    },
                    {
                        "data": "costo"
                    },
                    {
                        "data": "costo_promedio"
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
                        "data": "platinum",
                        "render": function(data, type, row) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "totales"
                    },
                    {
                        "data": "bodega"
                    },
                    {
                        "data": "towncenter"
                    },
                    {
                        "data": "coacalco"
                    },
                    {
                        "data": "naucalpan"
                    },
                    {
                        "data": "tienda_piso"
                    },
                    {
                        "data": "pedidos"
                    }

                ],
                order: [
                    [2, 'asc']
                ]
            });
            drawTriangles();
            showUsersSections();
        });

        $('#existencias_form').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            const idsucursal = $('#almacen').val();

            const data = {
                sucursal: idsucursal
            };

            $.ajax({
                url: 'reportesoloexistencias', // URL a la que se hace la solicitud
                type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                data: data,
                dataType: 'json', // Tipo de datos esperados en la respuesta
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(data) {

                    products = data.products;

                    var ahora = new Date();
                    var fecha = ahora.toISOString().slice(0, 10); // 2025-11-13
                    var hora = ahora.toTimeString().slice(0, 8); // 11:42:10

                    var resultado = fecha + ' ' + hora;
                    var nombre = $('#almacen option:selected').text() + resultado + ".xlsx";
                    exportarexcel(products, nombre);
                    generarPDF(data.products);


                },
                error: function(xhr, status, error) {

                    Swal.fire({
                        title: 'Error:',
                        text: xhr.responseJSON.error,
                        icon: 'warning'
                    });
                }
            });


        });

        function generarPDF(data) {
            const {
                jsPDF
            } = window.jspdf;
            const doc = new jsPDF();

            const columnasPermitidas = ["codigo", "producto", "marca", "categoria", "existencias"];

            const dataFiltrada = data.map(item => {
                let obj = {};
                columnasPermitidas.forEach(col => {
                    obj[col] = item[col];
                });
                return obj;
            });

            // Encabezados desde las claves del JSON
            const headers = Object.keys(dataFiltrada[0]);

            // Filas desde los valores
            const rows = dataFiltrada.map(item => Object.values(item));

            doc.autoTable({
                head: [headers],
                body: rows
            });
            var ahora = new Date();
            var fecha = ahora.toISOString().slice(0, 10); // 2025-11-13
            var hora = ahora.toTimeString().slice(0, 8); // 11:42:10

            var resultado = fecha + ' ' + hora;
            var nombre = $('#almacen option:selected').text() + resultado + ".pdf";
            doc.save(nombre);
        }
    </script>
@stop
