@extends('adminlte::page')

@section('title', 'Tareas Delegadas')

@section('content_header')
@stop

@section('content')
    <br>
    <div class="card">
        <div class="card-header">
            <h1>Tareas Delegadas</h1>
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
                        <th>Dirigido a</th>
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
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.9/css/buttons.dataTables.css">
@stop

@section('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"
        integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.9/js/dataTables.buttons.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.9/js/buttons.html5.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.9/js/buttons.print.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.debug.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.8.0/html2pdf.bundle.min.js"
        integrity="sha512-w3u9q/DeneCSwUDjhiMNibTRh/1i/gScBVp2imNVAMCt6cUHIw6xzhzcPFIaL3Q1EbI2l+nu17q2aLJJLo4ZYg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"
        integrity="sha512-BNaRQnYJYiPSqHHDb58B0yaPfCu+Wgds8Gp/gU33kqBtgNS4tSPHuGibyoeqMV/TJlSKda6FXzoEyYGjTe+vXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/xlsx@0.17.0/dist/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.0/FileSaver.min.js"
        integrity="sha512-csNcFYJniKjJxRWRV1R7fvnXrycHP6qDR21mgz1ZP55xY5d+aHLfo9/FcGDQLfn2IfngbAHd8LdfsagcCqgTcQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            var tareas = @json($tareas);

            $('#notificaciones').DataTable({
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
                data: tareas,
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
                        "data": "objetivo2",
                    },
                    {
                        "data": "fecharealizada",
                        "render": function(data, type, row) {

                            if (row.fechaaccion == null) {
                                return "NO REALIZADA";
                            } else {

                                return row.fechaaccion;
                            }

                        }
                    },

                ],
                rowCallback: function(row, data) {
                    var today = new Date().toISOString().split('T')[0];
                    var fechafin = data.fechafin;
                    var className = '';

                    if (fechafin === today) {
                        className = 'table-warning';
                    } else if (new Date(fechafin) < new Date(today)) {
                        className = 'table-danger';
                    } else {
                        className = 'table-success';
                    }

                    $('td', row).addClass(className);
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
