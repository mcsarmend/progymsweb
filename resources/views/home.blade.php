@extends('adminlte::page')

@section('title', 'Inicio')

@section('content_header')
@stop

@section('content')
    <br>
    <div class="card">
        <div class="card-header">
            <h1>Tareas</h1>
        </div>
        <div class="card-body" style="width: 100%">

            <div class="row">
                <div class="col-sm-4">
                    <div class="table-danger">
                        Fecha limite de realizacion de tarea terminado
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="table-warning">
                        Tienes hasta hoy para realizar tu tarea
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="table-success">
                        En tiempo para realizar tarea
                    </div>
                </div>
            </div>

            <table id="notificaciones" class="table table-striped table-bordered display nowrap" style="width: 100%">
                <thead>
                    <tr>
                        <th>Fecha Inicio</th>
                        <th>Fecha Fin</th>
                        <th>Asunto</th>
                        <th>Descripción</th>
                        <th>Asignado por</th>
                        <th>Fecha Realizada</th>

                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    @include('fondo')
@stop

@section('css')
    <style>
        .section {
            border-bottom: 1px solid #034383;
            padding: 20px;
            align-content: center;
        }


        .table-warning {
            background-color: #fff3cd !important;
            /* Amarillo pastel */
        }

        .table-danger {
            background-color: #f8d7da !important;
            /* Rojo pastel */
        }

        .table-success {
            background-color: #d4edda !important;
            /* Verde pastel */
        }
    </style>
@stop

@section('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
        integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            var tareas = @json($tareas);

            $('#notificaciones').DataTable({
                scrollX: true,
                language: {
                    url: "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                dom: 'Bfrtip', // Posición de los botones
                buttons: [{
                        extend: 'copy',
                        text: '<i class="fas fa-copy"></i> Copiar',
                        className: 'btn btn-sm btn-secondary'
                    },
                    {
                        extend: 'excel',
                        text: '<i class="fas fa-file-excel"></i> Excel',
                        className: 'btn btn-sm btn-success',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdf',
                        text: '<i class="fas fa-file-pdf"></i> PDF',
                        className: 'btn btn-sm btn-danger',
                        orientation: 'landscape',
                        pageSize: 'A4'
                    },
                    {
                        extend: 'print',
                        text: '<i class="fas fa-print"></i> Imprimir',
                        className: 'btn btn-sm btn-info'
                    }
                ],
                processing: true,
                data: @json($tareas),
                columns: [{
                        "data": "fechainicio"
                    },
                    {
                        "data": "fechafin"
                    },
                    {
                        "data": "asunto"
                    },
                    {
                        "data": "descripcion"
                    },
                    {
                        "data": "autor"
                    },
                    {
                        "data": "fecharealizada",
                        "render": function(data, type, row) {
                            if (!row.fechaaccion) {
                                return '<button onclick="realizar_tarea(' + row.id +
                                    ')" class="btn btn-info">Marcar</button>';
                            } else {
                                return row.fechaaccion;
                            }
                        }
                    }
                ],
                rowCallback: function(row, data) {
                    var today = new Date().toISOString().split('T')[0];
                    var className = (data.fechafin === today) ? 'table-warning' :
                        (new Date(data.fechafin) < new Date(today)) ? 'table-danger' : 'table-success';
                    $(row).addClass(className);
                }
            });
        });

        function realizar_tarea(id) {

            const datos = {
                id: id,
            };
            Swal.fire({
                title: "¿Marcar tarea como realizada?",
                text: "¡Esta acción no se puede deshacer!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "¡Si, marcarla!"
            }).then((result) => {
                if (result.isConfirmed) {



                    $.ajax({
                        url: '/marcartarea', // Ruta al controlador de Laravel
                        type: 'POST',
                        // data: datosFormulario, // Enviar los datos del formulario
                        data: datos,
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        success: function(response) {
                            Swal.fire(
                                '¡Gracias por esperar!',
                                response.message,
                                'success'
                            );
                            setTimeout(function() {
                                window.location.reload();
                            }, 3000);

                        },
                        error: function(response) {
                            Swal.fire(
                                '¡Gracias por esperar!',
                                "Existe un error: " + response.message,
                                'error'
                            )
                        }
                    });



                }
            });
        }
    </script>
@stop
