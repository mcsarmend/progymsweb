@extends('adminlte::page')

@section('title', 'Reportes de Movimientos traspasos')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Reportes de Movimientos traspasos</h1>
        </div>
        <div class="card-body">
            <form id="reporte">
                <div class="row">
                    <div class="col">
                        <label for="date-start"></label>
                        <input type="date" name= "dateStart" class="form-control" required>
                    </div>
                    <div class="col">
                        <label for="date-end"></label>
                        <input type="date" name= "dateEnd" class="form-control" required>
                    </div>
                    <div class="col">
                        <label for=""></label>
                        <button type="submit" class="btn btn-primary form-control">Generar Reporte</button>
                    </div>


                </div>
                <br>


            </form>

            <table id="traspasos" class="table table-striped">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Movimiento</th>
                        <th>Autor</th>
                        <th>Documento</th>
                        <th>Productos</th>
                        <th>Imprimir</th>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
        });

        $('#reporte').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/generarreportetraspasos', // Ruta al controlador de Laravel
                type: 'GET',
                // data: datosFormulario, // Enviar los datos del formulario
                data: datosFormulario,

                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );

                    $('#traspasos').DataTable({
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
                        "data": response.traspasos,
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
                            {
                                "data": "productos",
                                "render": function(data, type, row) {
                                    return '<button onclick="generarpdf(' + row.id +
                                        ')" class="btn btn-primary">Imprimir</button>';
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
                            }
                        ]
                    });
                }
            });
        }




        function generarpdf(id) {
            var info = '';
            $.ajax({
                url: 'verproductosmovimiento', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    info = data.movimiento;


                    var {
                        jsPDF
                    } = window.jspdf;
                    var doc = new jsPDF({
                        orientation: "portrait",
                        unit: "mm",
                        format: [297, 210],
                    });
                    var opciones = {
                        timeZone: "America/Mexico_City",
                        hour12: false,
                    };
                    var documento = info.documento;
                    var time = info.fecha;
                    let productos = JSON.parse(info.productos);

                    // Agregar contenido al PDF
                    doc.setFontSize(12);
                    doc.setFont("helvetica", "bold");
                    doc.text("GRUPO PROGYMS", 30, 10);
                    doc.text(`Documento: ${documento}`, 10, 22);
                    doc.text(`Fecha: ${time}`, 10, 27);
                    doc.text(`RFC: ASG160718HS6`, 10, 31);
                    doc.text('Teléfono: 55 6834 1113', 10, 35);


                    const tableData = productos.map(producto => [
                        producto.Codigo,
                        producto.Cantidad,
                        producto.Nombre,
                        producto["Costo Unitario"],
                        producto["Costo Subtotal"]
                    ]);

                    // Crear la tabla
                    doc.autoTable({
                        startY: 45, // Posición después de los textos iniciales
                        head: [
                            ['Código', 'Cantidad', 'Descripción', 'P. Unitario', 'Subtotal']
                        ],
                        body: tableData,
                        styles: {
                            fontSize: 8,
                            cellPadding: 2,
                            overflow: 'linebreak'
                        },
                        columnStyles: {
                            0: {
                                cellWidth: 25
                            }, // Código
                            1: {
                                cellWidth: 20
                            }, // Cantidad
                            2: {
                                cellWidth: 80
                            }, // Descripción
                            3: {
                                cellWidth: 25
                            }, // P. Unitario
                            4: {
                                cellWidth: 25
                            } // Subtotal
                        },
                        margin: {
                            left: 10
                        },
                        headStyles: {
                            fillColor: [200, 200, 200],
                            textColor: 0,
                            fontStyle: 'bold'
                        },
                        bodyStyles: {
                            fillColor: [255, 255, 255],
                            textColor: 0
                        }
                    });


                    doc.save(`traspaso_${documento}.pdf`);
                    Swal.fire("traspaso impreso!", "", "success");
                }
            });


        }
    </script>
@stop
