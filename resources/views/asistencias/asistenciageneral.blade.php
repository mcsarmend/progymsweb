@extends('adminlte::page')

@section('title', 'Asistencias')

@section('content_header')
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/css/bootstrap.min.css">
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Asistencias</h1>
        </div>

        <div class="container mt-5">
            <form id="asistencia_individual">
                <div class="row mb-3">
                    <!-- Select Empleado -->
                    <div class="col-md-4">
                        <label for="id_empleado" class="form-label">Empleado</label>
                        <select name="id_empleado" id="id_empleado" class="form-control">
                            @foreach ($empleados as $empleado)
                                <option value="{{ encrypt($empleado->id) }}">{{ $empleado->nombre }}</option>
                            @endforeach
                            <option value="0">TODOS</option>
                        </select>
                    </div>

                    <!-- Fecha Inicio -->
                    <div class="col-md-4">
                        <label for="fecha_inicio" class="form-label">Fecha de Inicio</label>
                        <input type="date" class="form-control" id="fecha_inicio" name="fecha_inicio" required>
                    </div>

                    <!-- Fecha Fin -->
                    <div class="col-md-4">
                        <label for="fecha_fin" class="form-label">Fecha de Fin</label>
                        <input type="date" class="form-control" id="fecha_fin" name="fecha_fin" required>
                    </div>
                </div>

                <!-- Botón de Enviar -->
                <div class="row">
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary">Buscar</button>
                    </div>
                </div>
            </form>
        </div>


        <div class="p-4 m-4">
            <div class="row">
                <div class="col">
                    <!-- Sección: Promedio Diario -->
                    <div class="card text-center" style="background-color: #8d8913;">
                        <h5 style="color: #ffffff;">Asistencias del mes</h5>
                        <p style="color: #ffffff;" class="display-4" id="asistencias_totales"></p>
                    </div>
                </div>

                <div class="col">
                    <!-- Sección: Promedio Diario -->
                    <div class="card text-center" style="background-color: #3a86d2;">
                        <h5 style="color: #ffffff;">Promedio Diario</h5>
                        <p style="color: #ffffff;" class="display-4" id="asistencias_promedio"></p>
                    </div>
                </div>

                <div class="col">
                    <!-- Sección: Total empleados -->
                    <div class="card text-center" style="background-color: #6d5bc9;">
                        <h5 style="color: #ffffff;">Total empleados</h5>
                        <p style="color: #ffffff;" class="display-4" id="total_empleados"></p>
                    </div>
                </div>

                <div class="col">
                    <!-- Sección: Total empleados -->
                    <div class="card text-center" style="background-color: #ca5d48;">
                        <h5 style="color: #ffffff;">Incidencias del mes</h5>
                        <p class="display-4" id="total_incidencias" style="color: #ffffff;"></p>
                    </div>
                </div>
            </div>
        </div>




        <div id="incidencias" style="width:100%; height:400px;">
        </div>

        <br>

        <div class="chart-container">
            <div id="lineChart" style="width:100%; height:400px;"></div>
        </div>

        <br>

        <div class="card-body">
            <table id="asistencias" class="table table-striped table-bordered display nowrap" style="width: 100%">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Vendedor</th>
                        <th>Hora Entrada</th>
                        <th>Hora Salida</th>
                        <th>Incidencia</th>
                    </tr>
                </thead>
            </table>
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




            data = @json($entradasysalidas);
            data = convertirJson(data, 1);
            fechas = data.map(d => d.fecha);
            entradas = data.map(d => d.entrada);
            salidas = data.map(d => d.salida);
            incidencias = data.map(d => d.incidencia);

            let totalAsistencias = entradas.reduce((suma, entrada) => suma + entrada, 0);
            let promedioAsistencias = totalAsistencias / entradas.length;
            promedioAsistencias = promedioAsistencias.toFixed(2);

            let totalIncidencias = incidencias.reduce((suma, incidencia) => suma + incidencia, 0);


            $('#asistencias_totales').text(totalAsistencias)
            $('#asistencias_promedio').text(promedioAsistencias)
            let totalempleadosjs = @json($totalempleados);
            $('#total_empleados').text(totalempleadosjs);
            $('#total_incidencias').text(totalIncidencias);




            // Crear el gráfico
            Highcharts.chart('incidencias', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Asistencia por Día'
                },
                xAxis: {
                    categories: fechas,
                    title: {
                        text: 'Fecha'
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Cantidad'
                    }
                },
                series: [{
                        name: 'Entradas',
                        data: entradas,
                        color: '#28a745' // Verde para Entrada
                    },
                    {
                        name: 'Salidas',
                        data: salidas,
                        color: '#007bff' // Azul para Salida
                    }, {
                        name: 'Incidencias',
                        data: incidencias,
                        color: '#dc3545' // Rojo para Incidencia
                    }
                ],
                plotOptions: {
                    column: {
                        dataLabels: {
                            enabled: true
                        }
                    }
                }
            });


            tendencias = @json($tendencias);
            tendencias = convertirJson(tendencias, 2);
            semanas = tendencias.map(d => d.semana);
            entradasSemana = tendencias.map(d => d.entrada);

            Highcharts.chart('lineChart', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: 'Tendencia de Asistencias'
                },
                xAxis: {
                    categories: semanas
                },
                yAxis: {
                    title: {
                        text: 'Asistencias'
                    }
                },
                series: [{
                    name: 'Asistencias',
                    data: entradasSemana,
                    color: '#28A745'
                }]
            });



            // TABLA ASSITENCIAS


            var asistencias = @json($reporte);

            $('#asistencias').DataTable({
                destroy: true,
                scrollX: true,
                scrollCollapse: true,
                language: {
                    url: "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                buttons: [
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
                data: asistencias,
                columns: [{
                        "data": "fecha"
                    },
                    {
                        "data": "vendedor"
                    },
                    {
                        "data": "hora_entrada"
                    },
                    {
                        "data": "hora_salida"
                    }, {
                        "data": "incidencia"
                    }

                ],

            });
        });






        function convertirJson(jsonData, type) {
            if (type == 1) {
                return $.map(jsonData, function(item) {
                    // Crear un nuevo objeto y convertir los valores de entrada y salida a número
                    return {
                        fecha: item.fecha,
                        entrada: parseInt(item.entrada), // Convertir a número
                        salida: parseInt(item.salida), // Convertir a número
                        incidencia: parseInt(item.incidencia) // Convertir a número
                    };
                });
            } else {
                return $.map(jsonData, function(item) {
                    // Crear un nuevo objeto y convertir los valores de entrada y salida a número
                    return {
                        semana: item.semana,
                        entrada: parseInt(item.entrada), // Convertir a número
                        salida: parseInt(item.salida), // Convertir a número
                        incidencia: parseInt(item.incidencia) // Convertir a número
                    };
                });
            }

        }

        $('#asistencia_individual').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/asistencia_graficas', // Ruta al controlador de Laravel
                type: 'POST',
                data: datosFormulario,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );

                    // Actualizar los gráficos con los nuevos datos
                    actualizarGraficos(response.asistencia, response.asistencia_semana, response
                        .reporte);

                },
                error: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        "Existe un error: " + response.message,
                        'error'
                    );
                }
            });
        });

        function actualizarGraficos(entradasysalidas, tendencias, reporte) {
            // Procesar los nuevos datos
            let data = convertirJson(entradasysalidas, 1);
            let fechas = data.map(d => d.fecha);
            let entradas = data.map(d => d.entrada);
            let salidas = data.map(d => d.salida);
            let incidencias = data.map(d => d.incidencia);

            let totalAsistencias = entradas.reduce((suma, entrada) => suma + entrada, 0);
            let promedioAsistencias = totalAsistencias / entradas.length;
            promedioAsistencias = promedioAsistencias.toFixed(2);

            let totalIncidencias = incidencias.reduce((suma, incidencia) => suma + incidencia, 0);

            $('#asistencias_totales').text(totalAsistencias);
            $('#asistencias_promedio').text(promedioAsistencias);
            $('#total_incidencias').text(totalIncidencias);

            // Actualizar el gráfico de asistencias por día
            Highcharts.chart('incidencias', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Asistencia por Día'
                },
                xAxis: {
                    categories: fechas,
                    title: {
                        text: 'Fecha'
                    }
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Cantidad'
                    }
                },
                series: [{
                        name: 'Entradas',
                        data: entradas,
                        color: '#28a745' // Verde para Entrada
                    },
                    {
                        name: 'Salidas',
                        data: salidas,
                        color: '#007bff' // Azul para Salida
                    }, {
                        name: 'Incidencias',
                        data: incidencias,
                        color: '#dc3545' // Rojo para Incidencia
                    }
                ],
                plotOptions: {
                    column: {
                        dataLabels: {
                            enabled: true
                        }
                    }
                }
            });

            // Actualizar el gráfico de tendencias de asistencias
            let tendenciasData = convertirJson(tendencias, 2);
            let semanas = tendenciasData.map(d => d.semana);
            let entradasSemana = tendenciasData.map(d => d.entrada);

            Highcharts.chart('lineChart', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: 'Tendencia de Asistencias'
                },
                xAxis: {
                    categories: semanas
                },
                yAxis: {
                    title: {
                        text: 'Asistencias'
                    }
                },
                series: [{
                    name: 'Asistencias',
                    data: entradasSemana,
                    color: '#28A745'
                }]
            });


            $('#asistencias').DataTable({
                destroy: true,
                scrollX: true,
                scrollCollapse: true,
                language: {
                    url: "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                buttons: [
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
                data: reporte,
                columns: [{
                        "data": "fecha"
                    },
                    {
                        "data": "vendedor"
                    },
                    {
                        "data": "hora_entrada"
                    },
                    {
                        "data": "hora_salida"
                    }, {
                        "data": "incidencia"
                    }

                ],

            });

        }
    </script>

    <script></script>
@stop
