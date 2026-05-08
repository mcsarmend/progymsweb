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

                    <!-- Botón -->
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-success w-100 py-2">
                            <i class="fas fa-search"></i> Buscar
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
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            Highcharts.setOptions({
                lang: {
                    decimalPoint: '.',
                    thousandsSep: ','
                }
            })
        });

        $('#reporteresumenventas').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/reporteresumenventas', // Ruta al controlador de Laravel
                type: 'POST',
                // data: datosFormulario, // Enviar los datos del formulario
                data: datosFormulario,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },

                success: function(response) {


                    // ACTUALIZAR TARJETAS DEL DASHBOARD
                    $('#total_vendido').text('$' + Number(response.total_vendido).toLocaleString(
                        'es-MX'));

                    $('#cantidad_remisiones').text(response.cantidad_remisiones);


                    // GRAFICA DE METODOS DE PAGO

                    // Preparar datos para la gráfica
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
                        }, {
                            title: {
                                text: 'Total Vendido ($)'
                            },
                            opposite: true
                        }],
                        series: [{
                                name: 'Cantidad',
                                data: cantidades,
                                tooltip: {
                                    valueSuffix: ' remisiones'
                                }
                            },
                            {
                                name: 'Total Vendido',
                                type: 'column', // 👉 columnas, no línea
                                yAxis: 1, // 👉 eje secundario
                                data: totales,
                                tooltip: {
                                    valuePrefix: '$'
                                }
                            }
                        ]
                    });

                    // // GRAFICO VENTAS POR DIA

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
                        }, {
                            title: {
                                text: 'Total Vendido ($)'
                            },
                            opposite: true
                        }],
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

                    let colores = Highcharts.getOptions().colors; // colores base de Highcharts

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
                        }, {
                            title: {
                                text: 'Total Vendido ($)'
                            },
                            opposite: true
                        }],
                        series: [{
                            name: 'Cantidad',
                            data: cantidades_tipo,
                            tooltip: {
                                valueSuffix: ' remisiones'
                            },
                            color: colores[0] // un color para toda la serie
                        }, {
                            name: 'Total Vendido',
                            type: 'column',
                            yAxis: 1,
                            data: totales_tipo,
                            tooltip: {
                                valuePrefix: '$'
                            },
                            color: colores[1] // otro color para toda la serie
                        }]
                    });


                    // GRAFICO TIPOS DE REMISION

                    let tiposRemision = Object.keys(response.tipos_remision);

                    let cantidadesRemision = tiposRemision.map(key => {
                        return Number(response.tipos_remision[key].cantidad);
                    });

                    let totalesRemision = tiposRemision.map(key => {
                        return Number(response.tipos_remision[key].total);
                    });

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
                        }, {
                            title: {
                                text: 'Total Vendido ($)'
                            },
                            opposite: true
                        }],
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
                    Swal.fire(
                        '¡Gracias por esperar!',
                        "Existe un error: " + response.message,
                        'error'
                    )
                }
            });
        });
    </script>
@stop
