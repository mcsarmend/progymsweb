@extends('adminlte::page')

@section('title', 'Resumen de Ventas')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Resumen de Ventas</h1>
        </div>
        <div class="card-body">
            <form method="post" id="reporteresumenventas" class="border p-3 rounded">

                <div class="row align-items-center g-2">

                    <!-- Fecha Inicio -->
                    <div class="col-md-2 text-end">
                        <label for="fechainicio" class="col-form-label">Fecha inicio:</label>
                    </div>
                    <div class="col-md-2">
                        <input type="date" name="fechainicio" id="fechainicio" class="form-control">
                    </div>

                    <!-- Fecha Fin -->
                    <div class="col-md-2 text-end">
                        <label for="fechafin" class="col-form-label">Fecha fin:</label>
                    </div>
                    <div class="col-md-2">
                        <input type="date" name="fechafin" id="fechafin" class="form-control">
                    </div>

                    <!-- Sucursal -->
                    <div class="col-md-1 text-end">
                        <label for="sucursal" class="col-form-label">Sucursal:</label>
                    </div>
                    <div class="col-md-2">
                        <select name="sucursal" id="sucursal" class="form-control">
                            <option class="form-control" value="0">Todas</option>
                            @foreach ($almacenes as $almacen)
                                <option value="{{ $almacen->id }}">{{ $almacen->nombre }}</option>
                            @endforeach
                        </select>
                    </div>

                    <!-- Botón Buscar -->
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-success w-100 py-2">
                            <i class="fas fa-search"></i> Buscar
                        </button>
                    </div>

                    <!-- Botón Descargar PDF -->
                    <div class="col-md-1">
                        <button type="button" id="btnDescargarPDF" class="btn btn-danger w-100 py-2">
                            <i class="fas fa-file-pdf"></i> PDF
                        </button>
                    </div>

                </div>

            </form>


            <!-- DASHBOARD DE RESUMEN DE VENTAS -->
            <hr>

            <!-- FILA: TOTAL VENDIDO + CANTIDAD DE REMISIONES -->
            <div class="row mb-4 text-center">

                <!-- TOTAL VENDIDO -->
                <div class="col-md-6 mb-3">
                    <div class="card bg-primary text-white shadow h-100">
                        <div class="card-body">
                            <h3><i class="fas fa-dollar-sign"></i> Total Vendido</h3>
                            <h1 id="total_vendido" class="display-4">$0.00</h1>
                        </div>
                    </div>
                </div>

                <!-- CANTIDAD DE REMISIONES -->
                <div class="col-md-6 mb-3">
                    <div class="card bg-info text-white shadow h-100">
                        <div class="card-body">
                            <h3><i class="fas fa-receipt"></i> Cantidad de Remisiones</h3>
                            <h1 id="cantidad_remisiones" class="display-4">0</h1>
                        </div>
                    </div>
                </div>

            </div>

            <!-- FILA 2: MÉTODOS DE PAGO -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4><i class="fas fa-credit-card"></i> Métodos de Pago</h4>
                        </div>
                        <div class="card-body">
                            <div id="grafica_metodos_pago" style="height: 400px;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- FILA 3: GRAFICA VENTAS POR DIA -->
            <div class="row">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4><i class="fas fa-chart-bar"></i> Ventas por Día</h4>
                        </div>
                        <div class="card-body">
                            <div id="grafica_ventas_dia" style="height: 400px;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- FILA 4: GRAFICA VENTAS POR TIPO DE PRECIO -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4><i class="fas fa-tags"></i> Ventas por Tipo de Precio</h4>
                        </div>
                        <div class="card-body">
                            <div id="grafica_tipos_precio" style="height: 400px;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- FILA 5: GRAFICA REPARTO VS MOSTRADOR -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4><i class="fas fa-store"></i> Reparto vs Venta Mostrador</h4>
                        </div>
                        <div class="card-body">
                            <div id="grafica_tipos_remision" style="height: 400px;"></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    @include('fondo')
@stop

@section('css')

@stop

@section('js')
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>

    <script>
        // Variable global para almacenar los datos del último reporte
        var ultimoReporte = null;

        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            Highcharts.setOptions({
                lang: {
                    decimalPoint: '.',
                    thousandsSep: ','
                }
            });
        });

        $('#reporteresumenventas').submit(function(e) {
            e.preventDefault();

            var datosFormulario = $(this).serialize();

            $.ajax({
                url: '/reporteresumenventas',
                type: 'POST',
                data: datosFormulario,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    // Guardar datos para el PDF
                    ultimoReporte = response;

                    // Guardar también los filtros usados
                    ultimoReporte.filtros = {
                        fechainicio: $('#fechainicio').val(),
                        fechafin: $('#fechafin').val(),
                        sucursal: $('#sucursal option:selected').text()
                    };

                    // ACTUALIZAR TARJETAS DEL DASHBOARD
                    $('#total_vendido').text('$' + Number(response.total_vendido).toLocaleString(
                        'es-MX'));
                    $('#cantidad_remisiones').text(response.cantidad_remisiones);

                    // GRAFICA DE METODOS DE PAGO
                    let categorias = Object.keys(response.metodos);
                    let cantidades = categorias.map(k => Number(response.metodos[k].cantidad));
                    let totales = categorias.map(k => Number(response.metodos[k].total));

                    Highcharts.chart('grafica_metodos_pago', {
                        chart: {
                            type: 'column'
                        },
                        title: {
                            text: 'Métodos de Pago: Cantidad y Total Vendido'
                        },
                        xAxis: {
                            categories: categorias,
                            title: {
                                text: 'Métodos de Pago'
                            }
                        },
                        yAxis: [{
                                title: {
                                    text: 'Cantidad de Remisiones'
                                }
                            },
                            {
                                title: {
                                    text: 'Total Vendido ($)'
                                },
                                opposite: true
                            }
                        ],
                        series: [{
                                name: 'Cantidad',
                                data: cantidades,
                                tooltip: {
                                    valueSuffix: ' remisiones'
                                }
                            },
                            {
                                name: 'Total Vendido',
                                type: 'column',
                                yAxis: 1,
                                data: totales,
                                tooltip: {
                                    valuePrefix: '$'
                                }
                            }
                        ]
                    });

                    // GRAFICO VENTAS POR DIA
                    let fechas = Object.keys(response.cantidadesPorDia);
                    let cantidades_dia = fechas.map(f => Number(response.cantidadesPorDia[f].cantidad));
                    let totales_dia = fechas.map(f => Number(response.cantidadesPorDia[f].total));

                    Highcharts.chart('grafica_ventas_dia', {
                        chart: {
                            type: 'column'
                        },
                        title: {
                            text: 'Ventas por Día'
                        },
                        xAxis: {
                            categories: fechas,
                            title: {
                                text: 'Fecha'
                            }
                        },
                        yAxis: [{
                                title: {
                                    text: 'Cantidad de Remisiones'
                                }
                            },
                            {
                                title: {
                                    text: 'Total Vendido ($)'
                                },
                                opposite: true
                            }
                        ],
                        series: [{
                                name: 'Cantidad',
                                data: cantidades_dia,
                                tooltip: {
                                    valueSuffix: ' remisiones'
                                }
                            },
                            {
                                name: 'Total Vendido',
                                type: 'column',
                                yAxis: 1,
                                data: totales_dia,
                                tooltip: {
                                    valuePrefix: '$'
                                }
                            }
                        ]
                    });

                    // GRAFICO TIPOS DE PRECIO
                    let tipos = Object.keys(response.tipos_precio);
                    let cantidades_tipo = tipos.map(t => Number(response.tipos_precio[t].cantidad));
                    let totales_tipo = tipos.map(t => Number(response.tipos_precio[t].total));
                    let colores = Highcharts.getOptions().colors;

                    Highcharts.chart('grafica_tipos_precio', {
                        chart: {
                            type: 'column'
                        },
                        title: {
                            text: 'Ventas por Tipo de Precio'
                        },
                        xAxis: {
                            categories: tipos,
                            title: {
                                text: 'Tipo de Precio'
                            }
                        },
                        yAxis: [{
                                title: {
                                    text: 'Cantidad'
                                }
                            },
                            {
                                title: {
                                    text: 'Total Vendido ($)'
                                },
                                opposite: true
                            }
                        ],
                        series: [{
                                name: 'Cantidad',
                                data: cantidades_tipo,
                                tooltip: {
                                    valueSuffix: ' remisiones'
                                },
                                color: colores[0]
                            },
                            {
                                name: 'Total Vendido',
                                type: 'column',
                                yAxis: 1,
                                data: totales_tipo,
                                tooltip: {
                                    valuePrefix: '$'
                                },
                                color: colores[1]
                            }
                        ]
                    });

                    // GRAFICO TIPOS DE REMISION
                    let tiposRemision = Object.keys(response.tipos_remision);
                    let cantidadesRemision = tiposRemision.map(key => Number(response.tipos_remision[
                        key].cantidad));
                    let totalesRemision = tiposRemision.map(key => Number(response.tipos_remision[key]
                        .total));

                    Highcharts.chart('grafica_tipos_remision', {
                        chart: {
                            type: 'column'
                        },
                        title: {
                            text: 'Ventas por Tipo de Remisión'
                        },
                        xAxis: {
                            categories: tiposRemision,
                            title: {
                                text: 'Tipo de Remisión'
                            }
                        },
                        yAxis: [{
                                title: {
                                    text: 'Cantidad de Remisiones'
                                }
                            },
                            {
                                title: {
                                    text: 'Total Vendido ($)'
                                },
                                opposite: true
                            }
                        ],
                        series: [{
                                name: 'Cantidad',
                                data: cantidadesRemision,
                                tooltip: {
                                    valueSuffix: ' remisiones'
                                },
                                colorByPoint: true
                            },
                            {
                                name: 'Total Vendido',
                                type: 'column',
                                yAxis: 1,
                                data: totalesRemision,
                                tooltip: {
                                    valuePrefix: '$'
                                },
                                colorByPoint: true
                            }
                        ]
                    });

                    Swal.fire('¡Reporte Listo!', response.message, 'success');
                },
                error: function(response) {
                    Swal.fire('Error', "Error al generar el reporte", 'error');
                }
            });
        });

        // Botón para descargar PDF
        $('#btnDescargarPDF').on('click', function() {
            if (!ultimoReporte) {
                Swal.fire('Sin datos', 'Primero debes buscar un reporte', 'warning');
                return;
            }

            generarPDF(ultimoReporte);
        });

        function generarPDF(data) {
            try {
                const {
                    jsPDF
                } = window.jspdf;
                // FORMATO VERTICAL (portrait)
                const doc = new jsPDF('portrait', 'mm', 'a4');

                const user = @json(auth()->user()->name ?? 'Usuario');
                const ahora = new Date();
                const fecha = ahora.toLocaleDateString('es-MX');
                const hora = ahora.toTimeString().slice(0, 8);

                const pageWidth = doc.internal.pageSize.getWidth();
                const pageHeight = doc.internal.pageSize.getHeight();

                // ============ ENCABEZADO ============
                doc.setFontSize(16);
                doc.setTextColor(0, 0, 128);
                doc.text('RESUMEN DE VENTAS', pageWidth / 2, 20, {
                    align: 'center'
                });

                doc.setDrawColor(0, 0, 128);
                doc.setLineWidth(0.3);
                doc.line(15, 25, pageWidth - 15, 25);

                // ============ FILTROS APLICADOS ============
                let yPos = 33;
                doc.setFontSize(9);
                doc.setTextColor(0, 0, 0);

                const filtros = data.filtros || {};

                doc.setFont('helvetica', 'bold');
                doc.text('Filtros aplicados:', 20, yPos);
                yPos += 6;

                doc.setFont('helvetica', 'normal');
                doc.text(`Fecha Inicio: ${filtros.fechainicio || 'N/A'}`, 20, yPos);
                yPos += 5;
                doc.text(`Fecha Fin: ${filtros.fechafin || 'N/A'}`, 20, yPos);
                yPos += 5;
                doc.text(`Sucursal: ${filtros.sucursal || 'Todas'}`, 20, yPos);
                yPos += 5;
                doc.text(`Fecha de generación: ${fecha} ${hora}`, 20, yPos);
                yPos += 5;
                doc.text(`Descargado por: ${user}`, 20, yPos);
                yPos += 8;

                // Línea separadora
                doc.setDrawColor(0, 0, 128);
                doc.setLineWidth(0.2);
                doc.line(15, yPos, pageWidth - 15, yPos);
                yPos += 6;

                // ============ TOTALES ============
                doc.setFontSize(11);
                doc.setTextColor(0, 0, 0);
                doc.setFont('helvetica', 'bold');
                doc.text('RESUMEN GENERAL:', 20, yPos);
                yPos += 6;

                doc.setFont('helvetica', 'normal');
                doc.setFontSize(10);
                doc.text(`Total Vendido: $${Number(data.total_vendido).toLocaleString('es-MX')}`, 25, yPos);
                yPos += 5;
                doc.text(`Cantidad de Remisiones: ${data.cantidad_remisiones}`, 25, yPos);
                yPos += 10;

                // Línea separadora
                doc.setDrawColor(200, 200, 200);
                doc.setLineWidth(0.2);
                doc.line(15, yPos, pageWidth - 15, yPos);
                yPos += 6;

                // ============ 1. MÉTODOS DE PAGO ============
                // Verificar si hay espacio
                if (yPos > 220) {
                    doc.addPage();
                    yPos = 20;
                }

                doc.setFontSize(10);
                doc.setFont('helvetica', 'bold');
                doc.setTextColor(0, 0, 128);
                doc.text('1. MÉTODOS DE PAGO', 20, yPos);
                yPos += 5;

                const metodosData = Object.keys(data.metodos).map(key => ({
                    metodo: key,
                    cantidad: data.metodos[key].cantidad,
                    total: data.metodos[key].total
                }));

                const metodosHeaders = ['Método de Pago', 'Cantidad', 'Total Vendido'];
                const metodosRows = metodosData.map(item => [
                    item.metodo,
                    item.cantidad,
                    `$${Number(item.total).toLocaleString('es-MX')}`
                ]);

                doc.autoTable({
                    head: [metodosHeaders],
                    body: metodosRows,
                    startY: yPos,
                    styles: {
                        fontSize: 7,
                        cellPadding: 1.5
                    },
                    headStyles: {
                        fillColor: [0, 0, 128],
                        textColor: [255, 255, 255],
                        fontSize: 8,
                        fontStyle: 'bold'
                    },
                    columnStyles: {
                        0: {
                            cellWidth: 70
                        },
                        1: {
                            cellWidth: 40
                        },
                        2: {
                            cellWidth: 55
                        }
                    },
                    margin: {
                        left: 20,
                        right: 20
                    }
                });

                yPos = doc.lastAutoTable.finalY + 6;

                // ============ 2. VENTAS POR DÍA ============
                // Verificar si hay espacio
                if (yPos > 220) {
                    doc.addPage();
                    yPos = 20;
                }

                doc.setFontSize(10);
                doc.setFont('helvetica', 'bold');
                doc.setTextColor(0, 0, 128);
                doc.text('2. VENTAS POR DÍA', 20, yPos);
                yPos += 5;

                const diaData = Object.keys(data.cantidadesPorDia).map(key => ({
                    fecha: key,
                    cantidad: data.cantidadesPorDia[key].cantidad,
                    total: data.cantidadesPorDia[key].total
                }));

                const diaHeaders = ['Fecha', 'Cantidad', 'Total Vendido'];
                const diaRows = diaData.map(item => [
                    item.fecha,
                    item.cantidad,
                    `$${Number(item.total).toLocaleString('es-MX')}`
                ]);

                doc.autoTable({
                    head: [diaHeaders],
                    body: diaRows,
                    startY: yPos,
                    styles: {
                        fontSize: 7,
                        cellPadding: 1.5
                    },
                    headStyles: {
                        fillColor: [0, 0, 128],
                        textColor: [255, 255, 255],
                        fontSize: 8,
                        fontStyle: 'bold'
                    },
                    columnStyles: {
                        0: {
                            cellWidth: 50
                        },
                        1: {
                            cellWidth: 40
                        },
                        2: {
                            cellWidth: 55
                        }
                    },
                    margin: {
                        left: 20,
                        right: 20
                    }
                });

                yPos = doc.lastAutoTable.finalY + 6;

                // ============ 3. VENTAS POR TIPO DE PRECIO ============
                // Verificar si hay espacio
                if (yPos > 220) {
                    doc.addPage();
                    yPos = 20;
                }

                doc.setFontSize(10);
                doc.setFont('helvetica', 'bold');
                doc.setTextColor(0, 0, 128);
                doc.text('3. VENTAS POR TIPO DE PRECIO', 20, yPos);
                yPos += 5;

                const tipoData = Object.keys(data.tipos_precio).map(key => ({
                    tipo: key,
                    cantidad: data.tipos_precio[key].cantidad,
                    total: data.tipos_precio[key].total
                }));

                const tipoHeaders = ['Tipo de Precio', 'Cantidad', 'Total Vendido'];
                const tipoRows = tipoData.map(item => [
                    item.tipo,
                    item.cantidad,
                    `$${Number(item.total).toLocaleString('es-MX')}`
                ]);

                doc.autoTable({
                    head: [tipoHeaders],
                    body: tipoRows,
                    startY: yPos,
                    styles: {
                        fontSize: 7,
                        cellPadding: 1.5
                    },
                    headStyles: {
                        fillColor: [0, 0, 128],
                        textColor: [255, 255, 255],
                        fontSize: 8,
                        fontStyle: 'bold'
                    },
                    columnStyles: {
                        0: {
                            cellWidth: 70
                        },
                        1: {
                            cellWidth: 40
                        },
                        2: {
                            cellWidth: 55
                        }
                    },
                    margin: {
                        left: 20,
                        right: 20
                    }
                });

                yPos = doc.lastAutoTable.finalY + 6;

                // ============ 4. TIPOS DE REMISIÓN ============
                // Verificar si hay espacio
                if (yPos > 220) {
                    doc.addPage();
                    yPos = 20;
                }

                doc.setFontSize(10);
                doc.setFont('helvetica', 'bold');
                doc.setTextColor(0, 0, 128);
                doc.text('4. VENTAS POR TIPO DE REMISIÓN', 20, yPos);
                yPos += 5;

                const remisionData = Object.keys(data.tipos_remision).map(key => ({
                    tipo: key,
                    cantidad: data.tipos_remision[key].cantidad,
                    total: data.tipos_remision[key].total
                }));

                const remisionHeaders = ['Tipo de Remisión', 'Cantidad', 'Total Vendido'];
                const remisionRows = remisionData.map(item => [
                    item.tipo,
                    item.cantidad,
                    `$${Number(item.total).toLocaleString('es-MX')}`
                ]);

                doc.autoTable({
                    head: [remisionHeaders],
                    body: remisionRows,
                    startY: yPos,
                    styles: {
                        fontSize: 7,
                        cellPadding: 1.5
                    },
                    headStyles: {
                        fillColor: [0, 0, 128],
                        textColor: [255, 255, 255],
                        fontSize: 8,
                        fontStyle: 'bold'
                    },
                    columnStyles: {
                        0: {
                            cellWidth: 70
                        },
                        1: {
                            cellWidth: 40
                        },
                        2: {
                            cellWidth: 55
                        }
                    },
                    margin: {
                        left: 20,
                        right: 20
                    }
                });

                // ============ PIE DE PÁGINA ============
                const totalPages = doc.internal.getNumberOfPages();
                for (let i = 1; i <= totalPages; i++) {
                    doc.setPage(i);
                    doc.setFontSize(7);
                    doc.setTextColor(100, 100, 100);
                    const footerText = `Página ${i} de ${totalPages} | Generado: ${fecha} ${hora}`;
                    doc.text(footerText, pageWidth / 2, pageHeight - 8, {
                        align: 'center'
                    });

                    doc.setDrawColor(200, 200, 200);
                    doc.setLineWidth(0.2);
                    doc.line(15, pageHeight - 11, pageWidth - 15, pageHeight - 11);
                }

                // Guardar PDF
                const filename = `resumen_ventas_${fecha.replace(/\//g, '-')}.pdf`;
                doc.save(filename);

                Swal.fire({
                    icon: 'success',
                    title: 'PDF generado correctamente',
                    text: 'El reporte se ha descargado exitosamente'
                });

            } catch (error) {
                console.error('Error en generarPDF:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error al generar PDF',
                    text: error.message || 'Error desconocido'
                });
            }
        }
    </script>
@stop
