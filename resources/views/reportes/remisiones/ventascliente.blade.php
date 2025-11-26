@extends('adminlte::page')

@section('title', 'Reporte de Ventas por Cliente')

@section('content_header')
@stop

@section('content')

    <div class="card">
        <div class="card-header">
            <h1>Resumen de Ventas por Cliente</h1>
        </div>

        <div class="card-body">

            {{-- ================= FORMULARIO ================= --}}
            <form id="formReporte" class="row g-3">

                <div class="col-md-6">
                    <label>Cliente</label>
                    <input list="listaClientes" id="cliente" name="cliente" class="form-control" required>
                    <datalist id="listaClientes">
                        @foreach ($clientes as $c)
                            <option value="{{ $c->id }} - {{ $c->nombre }}"></option>
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

            {{-- ================= CARDS DE RESUMEN ================= --}}
            <div id="resumen" class="row mt-4" style="display:none;">

                <div class="col-md-3">
                    <div class="small-box bg-success">
                        <div class="inner">
                            <h3 id="totalVendido">$0</h3>
                            <p>Total Vendido</p>
                        </div>
                        <div class="icon"><i class="fas fa-dollar-sign"></i></div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="small-box bg-info">
                        <div class="inner">
                            <h3 id="cantidadRemisiones">0</h3>
                            <p>Cantidad Remisiones</p>
                        </div>
                        <div class="icon"><i class="fas fa-file-invoice"></i></div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="small-box bg-warning">
                        <div class="inner">
                            <h3 id="ticketPromedio">$0</h3>
                            <p>Ticket Promedio</p>
                        </div>
                        <div class="icon"><i class="fas fa-chart-line"></i></div>
                    </div>
                </div>

            </div>

            {{-- ================= GRÁFICAS (HIGHCHARTS) ================= --}}
            <div id="graficas" style="display:none;">
                <div class="row mt-4">

                    <div class="col-md-6">
                        <h4>Ventas por Día</h4>
                        <div id="graficaPorDia" style="height: 350px;"></div>
                    </div>
                </div>
            </div>

            <hr>

            {{-- ================= TABLA ================= --}}
            <div id="contenedorTabla" style="display:none;">
                <h3>Detalle de Remisiones</h3>
                <table id="tablaRemisiones" class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Forma Pago</th>
                            <th>Total</th>
                            <th>Tipo Precio</th>
                            <th>Tipo Remisión</th>
                            <th>Cliente</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>

        </div>
    </div>

    @include('fondo')
@stop


@section('js')

    {{-- HIGHCHARTS --}}
    <script src="https://code.highcharts.com/highcharts.js"></script>

    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
        });

        // Extraer ID del input
        function obtenerNumerosHastaGuion(texto) {
            return texto.split('-')[0];
        }

        $('#formReporte').on('submit', function(e) {
            e.preventDefault();

            let datos = $(this).serialize();
            let idcliente = obtenerNumerosHastaGuion($('#cliente').val());
            datos += "&idcliente=" + idcliente;

            $.ajax({
                url: '/generarreporteventascliente',
                method: "POST",
                data: datos,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(res) {

                    $('#resumen').show();
                    $('#graficas').show();
                    $('#contenedorTabla').show();

                    // ================= CARDS =================
                    $('#totalVendido').text('$' + parseFloat(res.total_vendido).toFixed(2));
                    $('#cantidadRemisiones').text(res.cantidad_remisiones);
                    let ticket = res.cantidad_remisiones > 0 ? res.total_vendido / res
                        .cantidad_remisiones : 0;
                    $('#ticketPromedio').text('$' + ticket.toFixed(2));

                    // ================= TABLA =================
                    let tabla = $('#tablaRemisiones').DataTable();
                    tabla.clear();

                    res.remisiones.forEach(r => {
                        tabla.row.add([
                            r.fecha,
                            r.forma_pago,
                            '$' + parseFloat(r.total).toFixed(2),
                            r.tipo_de_precio,
                            r.reparto == 1 ? 'REPARTO' : 'MOSTRADOR',
                            r.nombre
                        ]);
                    });

                    tabla.draw();


                    crearGraficaPorDia(res.cantidadesPorDia);
                }
            });
        });


        // =====================================
        // ========== HIGHCHARTS ===============
        // =====================================

        // BARRAS → Métodos de pago


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
    </script>

@stop
