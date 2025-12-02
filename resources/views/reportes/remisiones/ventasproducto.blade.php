@extends('adminlte::page')

@section('title', 'Reporte de Ventas por Producto')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Resumen de Ventas por Producto</h1>
        </div>

        <div class="card-body">

            {{-- ================= FORMULARIO ================= --}}
            <form id="formReporte" class="d-flex flex-wrap align-items-end gap-4">

                <div class="d-flex flex-column">
                    <label class="mb-1">Categorías</label>
                    <input list="listacategorias" id="categorias" name="categorias" class="form-control" >
                    <datalist id="listacategorias">
                        @foreach ($categorias as $c)
                            <option value="{{ $c->id }} - {{ $c->nombre }}"></option>
                        @endforeach
                    </datalist>
                </div>

                <div class="d-flex flex-column">
                    <label class="mb-1">Marcas</label>
                    <input list="listamarcas" id="marcas" name="marcas" class="form-control" >
                    <datalist id="listamarcas">
                        @foreach ($marcas as $m)
                            <option value="{{ $m->id }} - {{ $m->nombre }}"></option>
                        @endforeach
                    </datalist>
                </div>

                <div class="d-flex flex-column">
                    <label class="mb-1">Fecha Inicio</label>
                    <input type="date" name="fechainicio" class="form-control" required>
                </div>

                <div class="d-flex flex-column">
                    <label class="mb-1">Fecha Fin</label>
                    <input type="date" name="fechafin" class="form-control" required>
                </div>

                <div class="d-flex align-items-end">
                    <button class="btn btn-primary">Generar Reporte</button>
                </div>

            </form>


            <hr>

            {{-- ================= TOP 10 ================= --}}
            <h3 class="text-center mt-4">Top 10 Productos Más Vendidos</h3>
            <div id="top10Container" class="mt-4"></div>

            <hr>

            {{-- ================= GRAFICA ================= --}}
            <div class="mt-5">
                <h3 class="text-center">Ventas por Producto y Almacén</h3>
                <div id="graficaSucursales" style="height: 420px;"></div>
            </div>
        </div>
    </div>

    @include('fondo')
@stop


@section('js')
    <script src="https://code.highcharts.com/highcharts.js"></script>

    <script>
        // ========================== FORM ==========================
        $('#formReporte').on('submit', function(e) {
            e.preventDefault();

            $.ajax({
                url: '/generarreporteventasproducto',
                method: "POST",
                data: $(this).serialize(),
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(res) {

                    renderTop10(res.top10, res.clientes);

                    renderGraficaSucursales(
                        res.almacenes,
                        res.series
                    );
                }
            });
        });

        // ==============================================================
        //                     TOP 10 PRODUCTOS
        // ==============================================================
        function renderTop10(top10, clientesData) {

            let html = "";
            let fontSize = 40;

            top10.forEach((p, index) => {

                let clientes = clientesData[p.codigo]
                    .map(c => `<span class="badge bg-info text-dark me-1">${c}</span>`)
                    .join('');

                html += `
                    <div class="p-3 mb-3 border rounded shadow"
                        style="font-size:${fontSize}px; background:#f7f7f7;">

                        <strong>${index+1}. ${p.nombre}</strong>
                        <span class="text-primary">(${p.cantidad_total} ventas)</span>

                    </div>
                `;

                fontSize = fontSize > 18 ? fontSize - 3 : 18;
            });

            $('#top10Container').html(html);
        }

        // ==============================================================
        //                     GRAFICA HIGHCHARTS
        // ==============================================================
        function renderGraficaSucursales(almacenes, series) {

            Highcharts.chart('graficaSucursales', {

                chart: {
                    type: 'line'
                },

                title: {
                    text: 'Ventas de los TOP 10 productos por almacén'
                },

                xAxis: {
                    categories: almacenes,
                    title: {
                        text: 'Almacenes'
                    }
                },

                yAxis: {
                    title: {
                        text: 'Cantidad Vendida'
                    }
                },

                tooltip: {
                    shared: true,
                    valueSuffix: ' unidades'
                },

                series: series
            });
        }
    </script>
@stop
