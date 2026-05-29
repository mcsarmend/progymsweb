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
                    <button class="btn btn-primary">Generar Reporte</button>
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

    <script>
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
    </script>

@stop
