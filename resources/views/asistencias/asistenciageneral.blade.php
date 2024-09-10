@extends('adminlte::page')

@section('title', 'Asistencias')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Asistencias</h1>
        </div>




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

            var asistencias = @json($asistencias);

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
                        "data": "incidencia_entrada"
                    }

                ],

            });
        });
    </script>
@stop
