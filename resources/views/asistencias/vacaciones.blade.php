@extends('adminlte::page')

@section('title', 'Vacaciones')

@section('content_header')
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Vacaciones</h2>
        </div>
        <div class="card-body">

            <div class="container mt-6">
                <div class="scroll-horizontal">


                    <div class="mb-3">
                        <label for="id" class="form-label">Nombre</label>
                        <select name="id" id="id" class="form-control">
                            @foreach ($empleados as $empleado)
                                <option value="{{ encrypt($empleado->id) }}">{{ $empleado->nombre }}</option>
                            @endforeach
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary" onclick="openFechasModal()">Buscar</button>

                    <br>
                    <table class="table table-bordered table-hover" id="vacacionesTabla">
                        <thead class ="thead-dark">
                            <tr>
                                <th>Empleado</th>
                                <!-- Genera los días del mes automáticamente -->

                                <th>Vacaciones Restantes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí se llenarán los datos dinámicamente -->
                        </tbody>
                    </table>
                </div>
            </div>


        </div>


    </div>

    <div class="modal fade" id="fechasModal" tabindex="-1" aria-labelledby="fechasModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="fechasModalLabel">Fechas de vacaciones de:</h5>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="usuarioSeleccionado"></p> <br>
                    <table id = "tableFechas">
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th># de Vacacion</th>
                            </tr>
                        </thead>
                        <tbody>


                        </tbody>
                    </table>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    @include('fondo')
@stop

@section('css')
    <style>
        .scroll-horizontal {
            overflow-x: auto;
            /* Permite el scroll horizontal */
            white-space: nowrap;
            /* Evita que el contenido se ajuste automáticamente */
        }

        .table {
            min-width: 1000px;
            /* Ajusta el ancho mínimo de la tabla para forzar el scroll */
        }
    </style>
@stop

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openFechasModal() {

            var nombre = $("#id option:selected").text();

            var id = $('#id').val();
            // Mostrar el nombre del usuario en el modal
            $('#usuarioSeleccionado').text(` ${nombre}`);


            $.ajax({
                url: 'getvacaciones', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    $('#tableFechas').DataTable({
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
                        "data": data.vacacionesFechas,
                        "columns": [{
                                "data": "FechaVacacion"
                            },
                            {
                                "data": "NoVacacion"
                            }
                        ],
                        "columnDefs": [{
                            "width": "200px",
                            "targets": 0
                        }],
                        // Aplicar estilo a lengthMenu al inicializar
                        "initComplete": function() {
                            $('.dataTables_length select').css('width',
                                '100px'); // Ajusta el ancho aquí
                        }
                    });


                }
            });



            // Abrir el modal de Bootstrap
            $('#fechasModal').modal('show');
        }
        $(document).ready(function() {
            var vacaciones = @json($vacaciones);
            $('#vacacionesTabla').DataTable({
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
                processing: true,
                sort: true,
                paging: true,
                pageLength: 15, // Mostrar 15 registros por página
                lengthMenu: [
                    [15, 25, 50, -1], // Opciones para el usuario (incluye 'All' para mostrar todos)
                    [15, 25, 50, 'All']
                ],
                pdf: {
                    orientation: 'landscape', // Orientación del PDF
                    pageSize: 'A4', // Tamaño del PDF
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                excel: {
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                "data": vacaciones,
                "columns": [{
                        "data": "empleado"
                    },
                    {
                        "data": "vacaciones_restantes"
                    }
                ],
                // Aplicar estilo a lengthMenu al inicializar
                "initComplete": function() {
                    $('.dataTables_length select').css('width',
                        '100px'); // Ajusta el ancho aquí
                }
            });

            drawTriangles();
            showUsersSections();
        });
    </script>
@stop
