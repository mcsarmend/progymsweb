@extends('adminlte::page')

@section('title', 'Reportes de Movimientos Compras')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Reportes de Movimientos Compras</h1>
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

            <table id="compras" class="table table-striped">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Movimiento</th>
                        <th>Autor</th>
                        <th>Documento</th>
                        <th>Costo Total</th>
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
                                <th>Costo Anterior</th>
                                <th>Costo en Compra</th>
                                <th>Cambio Costo</th>
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
        .custom-width {
            max-width: 95% !important;
            width: 60% !important;
        }
    </style>

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
                url: '/generarreportecompras', // Ruta al controlador de Laravel
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
                        "buttons": ['copy', 'excel', 'pdf', 'print'],
                        dom: 'Blfrtip',
                        processing: true,
                        sort: true,
                        paging: true,
                        lengthMenu: [
                            [10, 25, 50, -1],
                            [10, 25, 50, 'All']
                        ],
                        pdf: {
                            orientation: 'landscape',
                            pageSize: 'A4',
                            exportOptions: {
                                columns: ':visible'
                            }
                        },
                        excel: {
                            exportOptions: {
                                columns: ':visible'
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

                            // 🔽 Nueva columna: Total costo de la fila (Cantidad × Costo Unitario)
                            {
                                "data": "productos",
                                "title": "Total costo",
                                "render": function(data, type, row) {
                                    let productos = data;

                                    // Si viene como string JSON, parsear
                                    if (typeof productos === 'string') {
                                        try {
                                            productos = JSON.parse(productos);
                                        } catch (e) {
                                            productos = [];
                                        }
                                    }
                                    if (!Array.isArray(productos)) return '$0.00';

                                    let total = 0;
                                    productos.forEach(function(p) {
                                        const cantidad = parseFloat(p[
                                            'Cantidad']) || 0;
                                        const costo = parseFloat(p[
                                            'Costo en Compra']) || 0;
                                        total += cantidad * costo;
                                    });

                                    // Para ordenar/filtrar/exportar correctamente, regresar el número puro
                                    if (type === 'sort' || type === 'type' || type ===
                                        'export')
                                        return total;

                                    return total.toLocaleString('es-MX', {
                                        style: 'currency',
                                        currency: 'MXN'
                                    });
                                }
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
                        ],

                        // 🔽 Gran total de todas las filas filtradas
                        "initComplete": function() {
                            calcularGranTotal(this.api());
                        },
                        "drawCallback": function() {
                            calcularGranTotal(this.api());
                        }
                    });

                    function calcularGranTotal(api) {
                        let total = 0;
                        api.rows({
                            search: 'applied'
                        }).every(function() {
                            let productos = this.data().productos;
                            if (typeof productos === 'string') {
                                try {
                                    productos = JSON.parse(productos);
                                } catch (e) {
                                    productos = [];
                                }
                            }
                            if (!Array.isArray(productos)) return;
                            productos.forEach(function(p) {
                                const cantidad = parseFloat(p['Cantidad']) || 0;
                                const costo = parseFloat(p['Costo en Compra']) || 0;
                                total += cantidad * costo;
                            });
                        });

                        $('#totalCompras').text(
                            total.toLocaleString('es-MX', {
                                style: 'currency',
                                currency: 'MXN'
                            })
                        );
                    }
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
                }
            });
        }


        function generarpdf(id) {

            $.ajax({
                url: 'verproductosmovimiento',
                type: 'GET',
                data: {
                    id: id
                },
                dataType: 'json',
                success: function(data) {
                    let info = data.movimiento;
                    const almacenesMap = {
                        "01": "Almacén Principal",
                        "02": "Viveros",
                        "03": "Town Center",
                        "04": "Coacalco",
                        "06": "Villas de la Hacienda",
                        "07": "Naucalpan",
                        "08": "Bodega",
                        "09": "Tienda",
                        "10": "Pedidos"
                    };
                    var {
                        jsPDF
                    } = window.jspdf;

                    var doc = new jsPDF({
                        orientation: "portrait",
                        unit: "mm",
                        format: [297, 210],
                    });

                    let documento = info.documento;
                    let ultimos2 = documento.slice(-2);
                    let sucursal = almacenesMap[ultimos2] ?? ultimos2;
                    let time = info.fecha;
                    let productos = JSON.parse(info.productos);

                    // ============================
                    //         ENCABEZADO
                    // ============================

                    doc.setFont("helvetica", "bold");

                    doc.setFontSize(14);
                    doc.text("GRUPO PROGYMS", 105, 8, {
                        align: "center"
                    });

                    doc.setFontSize(11);
                    doc.text(`Movimiento: ${data.mov}`, 105, 14, {
                        align: "center"
                    });

                    let leftX = 10;
                    let rightX = 110;
                    let y = 22;

                    doc.setFontSize(10);

                    doc.text(`Fecha: ${time}`, leftX, y);
                    doc.text(`Documento: ${documento}`, rightX, y);

                    y += 5;
                    doc.text(`Sucursal: ${sucursal}`, leftX, y);
                    doc.text(`RFC: ASG160718HS6`, rightX, y);

                    y += 5;
                    doc.text(`Realizó: ${data.autor ?? "N/A"}`, leftX, y);
                    doc.text(`Tel: 55 6834 1113`, rightX, y);

                    let nextY = y + 4;

                    // ============================
                    //            TABLA
                    // ============================

                    // Calcular subtotal por producto y total general
                    let granTotal = 0;

                    const tableData = productos.map(p => {
                        const cantidad = parseFloat(p.Cantidad) || 0;
                        const costo = parseFloat(p["Costo en Compra"]) || 0;
                        const subtotal = cantidad * costo;

                        granTotal += subtotal;

                        return [
                            p.Codigo,
                            cantidad,
                            p.Nombre,
                            subtotal.toLocaleString('es-MX', {
                                style: 'currency',
                                currency: 'MXN'
                            })
                        ];
                    });

                    // Fila de total al final
                    const totalRow = [
                        '',
                        '',
                        'TOTAL',
                        granTotal.toLocaleString('es-MX', {
                            style: 'currency',
                            currency: 'MXN'
                        })
                    ];

                    doc.autoTable({
                        startY: nextY + 4,
                        head: [
                            ['Código', 'Cantidad', 'Descripción', 'Subtotal']
                        ],
                        body: tableData,
                        foot: [totalRow],
                        styles: {
                            fontSize: 10,
                            fontStyle: 'bold',
                            overflow: 'linebreak',
                            cellPadding: 2
                        },
                        columnStyles: {
                            0: {
                                cellWidth: 25,
                                halign: 'left'
                            },
                            1: {
                                cellWidth: 20,
                                halign: 'center'
                            },
                            2: {
                                cellWidth: 105,
                                halign: 'left'
                            },
                            3: {
                                cellWidth: 40,
                                halign: 'right'
                            }
                        },
                        margin: {
                            left: 10
                        },
                        headStyles: {
                            fillColor: [200, 200, 200],
                            textColor: 0,
                            fontStyle: 'bold'
                        },
                        footStyles: {
                            fillColor: [230, 230, 230],
                            textColor: 0,
                            fontStyle: 'bold',
                            halign: 'right'
                        }
                    });

                    // ============================
                    //       imprimir PDF
                    // ============================

                    const pdfBlob = doc.output('blob');
                    const pdfUrl = URL.createObjectURL(pdfBlob);

                    const printWindow = window.open(pdfUrl);

                    printWindow.onload = function() {
                        printWindow.print();
                    };

                    Swal.fire("Movimiento impreso", "", "success");
                },
                error: function() {
                    Swal.fire("Error", "No se pudo generar el PDF", "error");
                }
            });
        }
    </script>
@stop
