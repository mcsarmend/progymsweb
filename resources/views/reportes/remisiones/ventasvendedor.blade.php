@extends('adminlte::page')

@section('title', 'Reporte de Ventas por Vendedor')

@section('content_header')
@stop

@section('content')

    <div class="card">
        <div class="card-header">
            <h1>Resumen de Ventas por Vendedor</h1>
        </div>

        <div class="card-body">

            {{-- ================= FORMULARIO ================= --}}
            <form id="formReporte" class="row g-3">

                <div class="col-md-6">
                    <label>Vendedor</label>
                    <input list="listavendedores" id="vendedor" name="vendedor" class="form-control" required>
                    <datalist id="listavendedores">
                        @foreach ($vendedores as $c)
                            <option value="{{ $c->id }} - {{ $c->name }}"></option>
                        @endforeach
                    </datalist>
                </div>

                <div class="col-md-3">
                    <label>Fecha Inicio</label>
                    <input type="date" name="fechainicio" class="form-control" required>
                </div>

                <div class="col-md-3">
                    <label>Fecha Fin</label>
                    <input type="date" name="fechafin" class="form-control" required>
                </div>

                <div class="col-md-12 mt-3">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> Generar Reporte
                    </button>
                    <button type="button" id="btnDescargarPDF" class="btn btn-danger">
                        <i class="fas fa-file-pdf"></i> Descargar PDF
                    </button>
                </div>

            </form>

            <hr>

            {{-- ================= NOMBRE DEL VENDEDOR ================= --}}
            <div id="cabeceraVendedor" class="mt-3" style="display:none;">
                <h3>Vendedor: <span id="nombreVendedor" class="text-primary"></span></h3>
            </div>

            {{-- ================= CARDS DE RESUMEN ================= --}}
            <div id="resumen" class="row mt-4" style="display:none;">

                {{-- TOTAL VENTAS --}}
                <div class="col-md-3">
                    <div class="small-box bg-success">
                        <div class="inner">
                            <h3 id="totalVentas">$0</h3>
                            <p>Total Ventas</p>
                        </div>
                        <div class="icon"><i class="fas fa-dollar-sign"></i></div>
                    </div>
                </div>

                {{-- TOTAL CANTIDAD --}}
                <div class="col-md-3">
                    <div class="small-box bg-info">
                        <div class="inner">
                            <h3 id="totalCantidad">0</h3>
                            <p>Total Remisiones</p>
                        </div>
                        <div class="icon"><i class="fas fa-file-invoice"></i></div>
                    </div>
                </div>

                {{-- VENTAS MOSTRADOR (sin reparto) --}}
                <div class="col-md-3">
                    <div class="small-box bg-primary">
                        <div class="inner">
                            <h3 id="ventasMostrador">$0</h3>
                            <p>Ventas Mostrador (<span id="cantVentasMostrador">0</span>)</p>
                        </div>
                        <div class="icon"><i class="fas fa-store"></i></div>
                    </div>
                </div>

                {{-- VENTAS REPARTO --}}
                <div class="col-md-3">
                    <div class="small-box bg-warning">
                        <div class="inner">
                            <h3 id="ventasReparto">$0</h3>
                            <p>Ventas Reparto (<span id="cantVentasReparto">0</span>)</p>
                        </div>
                        <div class="icon"><i class="fas fa-truck"></i></div>
                    </div>
                </div>

                {{-- TICKET PROMEDIO --}}
                <div class="col-md-3">
                    <div class="small-box bg-secondary">
                        <div class="inner">
                            <h3 id="ticketPromedio">$0</h3>
                            <p>Ticket Promedio</p>
                        </div>
                        <div class="icon"><i class="fas fa-chart-line"></i></div>
                    </div>
                </div>

                {{-- % MOSTRADOR --}}
                <div class="col-md-3">
                    <div class="small-box bg-dark">
                        <div class="inner">
                            <h3 id="porcMostrador">0%</h3>
                            <p>% Mostrador</p>
                        </div>
                        <div class="icon"><i class="fas fa-percentage"></i></div>
                    </div>
                </div>

                {{-- % REPARTO --}}
                <div class="col-md-3">
                    <div class="small-box bg-danger">
                        <div class="inner">
                            <h3 id="porcReparto">0%</h3>
                            <p>% Reparto</p>
                        </div>
                        <div class="icon"><i class="fas fa-percentage"></i></div>
                    </div>
                </div>

            </div>

            {{-- ================= GRÁFICAS ================= --}}
            <div id="graficas" style="display:none;">
                <div class="row mt-4">
                    <div class="col-md-6">
                        <h4>Ventas por Día</h4>
                        <div id="graficaPorDia" style="height: 350px;"></div>
                    </div>

                </div>
            </div>

            <hr>

        </div>
    </div>

    @include('fondo')
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
        });

        function obtenerNumerosHastaGuion(texto) {
            return texto.split('-')[0].trim();
        }

        function formatoMoneda(num) {
            return '$' + parseFloat(num || 0).toLocaleString('es-MX', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });
        }

        $('#formReporte').on('submit', function(e) {
            e.preventDefault();

            let datos = $(this).serialize();
            let idvendedor = obtenerNumerosHastaGuion($('#vendedor').val());
            datos += "&idvendedor=" + idvendedor;

            $.ajax({
                url: '/generarreporteventasvendedor',
                method: "POST",
                data: datos,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(res) {

                    // Guardar datos para el PDF
                    ultimoReporte = res;

                    // Guardar también los filtros usados
                    ultimoReporte.filtros = {
                        vendedor: $('#vendedor').val(),
                        fechainicio: $('input[name="fechainicio"]').val(),
                        fechafin: $('input[name="fechafin"]').val()
                    };

                    $('#cabeceraVendedor').show();
                    $('#resumen').show();
                    $('#graficas').show();
                    $('#contenedorTabla').show();

                    // ============ NOMBRE VENDEDOR ============
                    $('#nombreVendedor').text(res.vendedor);

                    // ============ CARDS ============
                    let totalVentas = parseFloat(res.total_ventas) || 0;
                    let totalCantidad = parseInt(res.total_cantidad) || 0;
                    let ventas = parseFloat(res.ventas) || 0;
                    let cantVentas = parseInt(res.cantidad_ventas) || 0;
                    let ventasReparto = parseFloat(res.ventas_reparto) || 0;
                    let cantReparto = parseInt(res.cantidad_ventas_reparto) || 0;

                    $('#totalVentas').text(formatoMoneda(totalVentas));
                    $('#totalCantidad').text(totalCantidad);

                    $('#ventasMostrador').text(formatoMoneda(ventas));
                    $('#cantVentasMostrador').text(cantVentas);

                    $('#ventasReparto').text(formatoMoneda(ventasReparto));
                    $('#cantVentasReparto').text(cantReparto);

                    let ticket = totalCantidad > 0 ? totalVentas / totalCantidad : 0;
                    $('#ticketPromedio').text(formatoMoneda(ticket));

                    let pMostrador = totalVentas > 0 ? (ventas / totalVentas) * 100 : 0;
                    let pReparto = totalVentas > 0 ? (ventasReparto / totalVentas) * 100 : 0;
                    $('#porcMostrador').text(pMostrador.toFixed(1) + '%');
                    $('#porcReparto').text(pReparto.toFixed(1) + '%');

                    // ================= GRÁFICA POR DÍA =================
                    crearGraficaPorDia(res.cantidadesPorDia || {});
                }
            });
        });

        // Botón para descargar PDF
        $('#btnDescargarPDF').on('click', function() {
            if (!ultimoReporte) {
                Swal.fire('Sin datos', 'Primero debes generar un reporte', 'warning');
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
                doc.text('REPORTE DE VENTAS POR VENDEDOR', pageWidth / 2, 20, {
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
                doc.text(`Vendedor: ${filtros.vendedor || 'N/A'}`, 20, yPos);
                yPos += 5;
                doc.text(`Fecha Inicio: ${filtros.fechainicio || 'N/A'}`, 20, yPos);
                yPos += 5;
                doc.text(`Fecha Fin: ${filtros.fechafin || 'N/A'}`, 20, yPos);
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

                // ============ RESUMEN GENERAL ============
                let totalVentas = parseFloat(data.total_ventas) || 0;
                let totalCantidad = parseInt(data.total_cantidad) || 0;
                let ventas = parseFloat(data.ventas) || 0;
                let cantVentas = parseInt(data.cantidad_ventas) || 0;
                let ventasReparto = parseFloat(data.ventas_reparto) || 0;
                let cantReparto = parseInt(data.cantidad_ventas_reparto) || 0;
                let ticket = totalCantidad > 0 ? totalVentas / totalCantidad : 0;
                let pMostrador = totalVentas > 0 ? (ventas / totalVentas) * 100 : 0;
                let pReparto = totalVentas > 0 ? (ventasReparto / totalVentas) * 100 : 0;

                doc.setFontSize(11);
                doc.setTextColor(0, 0, 0);
                doc.setFont('helvetica', 'bold');
                doc.text('RESUMEN GENERAL:', 20, yPos);
                yPos += 6;

                doc.setFont('helvetica', 'normal');
                doc.setFontSize(9);

                const resumenData = [
                    ['Vendedor:', data.vendedor || 'N/A'],
                    ['Total Ventas:', formatoMoneda(totalVentas)],
                    ['Total Remisiones:', totalCantidad.toString()],
                    ['Ventas Mostrador:', `${formatoMoneda(ventas)} (${cantVentas} remisiones)`],
                    ['Ventas Reparto:', `${formatoMoneda(ventasReparto)} (${cantReparto} remisiones)`],
                    ['Ticket Promedio:', formatoMoneda(ticket)],
                    ['% Mostrador:', pMostrador.toFixed(1) + '%'],
                    ['% Reparto:', pReparto.toFixed(1) + '%']
                ];

                resumenData.forEach(([label, value]) => {
                    doc.setFont('helvetica', 'bold');
                    doc.text(label, 25, yPos);
                    doc.setFont('helvetica', 'normal');
                    doc.text(value, 65, yPos);
                    yPos += 5;
                });

                yPos += 6;

                // Línea separadora
                doc.setDrawColor(200, 200, 200);
                doc.setLineWidth(0.2);
                doc.line(15, yPos, pageWidth - 15, yPos);
                yPos += 6;

                // ============ VENTAS POR DÍA ============
                // Verificar si hay espacio
                if (yPos > 220) {
                    doc.addPage();
                    yPos = 20;
                }

                doc.setFontSize(10);
                doc.setFont('helvetica', 'bold');
                doc.setTextColor(0, 0, 128);
                doc.text('VENTAS POR DÍA', 20, yPos);
                yPos += 5;

                const diaData = Object.keys(data.cantidadesPorDia || {}).map(key => ({
                    fecha: key,
                    total: data.cantidadesPorDia[key].total || 0
                }));

                if (diaData.length > 0) {
                    const diaHeaders = ['Fecha', 'Total Vendido'];
                    const diaRows = diaData.map(item => [
                        item.fecha,
                        formatoMoneda(item.total)
                    ]);

                    doc.autoTable({
                        head: [diaHeaders],
                        body: diaRows,
                        startY: yPos,
                        styles: {
                            fontSize: 8,
                            cellPadding: 1.5
                        },
                        headStyles: {
                            fillColor: [0, 0, 128],
                            textColor: [255, 255, 255],
                            fontSize: 9,
                            fontStyle: 'bold'
                        },
                        columnStyles: {
                            0: {
                                cellWidth: 60
                            },
                            1: {
                                cellWidth: 80
                            }
                        },
                        margin: {
                            left: 20,
                            right: 20
                        }
                    });
                } else {
                    doc.setFontSize(9);
                    doc.setFont('helvetica', 'normal');
                    doc.text('No hay datos de ventas por día', 25, yPos);
                }

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
                const nombreVendedor = (data.vendedor || 'vendedor').replace(/\s+/g, '_');
                const filename = `ventas_vendedor_${nombreVendedor}_${fecha.replace(/\//g, '-')}.pdf`;
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

        // LÍNEA → Ventas por día
        function crearGraficaPorDia(data) {
            Highcharts.chart('graficaPorDia', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: ''
                },
                xAxis: {
                    categories: Object.keys(data),
                    title: {
                        text: 'Fecha'
                    }
                },
                yAxis: {
                    title: {
                        text: 'Total $'
                    }
                },
                series: [{
                    name: 'Total por día',
                    data: Object.values(data).map(v => parseFloat(v.total))
                }]
            });
        }

        // PIE → Mostrador vs Reparto
        function crearGraficaMostradorReparto(mostrador, reparto) {
            Highcharts.chart('graficaMostradorReparto', {
                chart: {
                    type: 'pie'
                },
                title: {
                    text: ''
                },
                tooltip: {
                    pointFormat: '<b>{point.percentage:.1f}%</b><br>${point.y:,.2f}'
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f}%'
                        }
                    }
                },
                series: [{
                    name: 'Ventas',
                    data: [{
                            name: 'Mostrador',
                            y: parseFloat(mostrador)
                        },
                        {
                            name: 'Reparto',
                            y: parseFloat(reparto)
                        }
                    ]
                }]
            });
        }
    </script>

@stop
