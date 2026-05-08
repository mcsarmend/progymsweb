@extends('adminlte::page')

@section('title', ' Categorias')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style ="font-size: 2rem">Categorias</h1>
                </div>
                <div class="card-body">
                    <table id="categorias" class="table">
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Nombre</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>




    @include('fondo')
@stop

@section('css')
    <style>
        .modal-dialog.custom-width {
            max-width: 55%;
            /* Ajusta este valor según tus necesidades */
        }

        #direcciontabla th:first-child,
        #direcciontabla td:first-child {
            min-width: 300px;
            /* Ajusta este valor según tus necesidades */
        }
    </style>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            var categorias = @json($categorias);
            $('#categorias').DataTable({
                destroy: true,
                scrollX: true,
                scrollCollapse: true,
                "language": {
                    "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                "buttons": [
                    'copy', 'excel', 'pdf', 'print'
                ],

                destroy: true,
                processing: true,
                sort: true,
                paging: true,
                lengthMenu: [
                    [10, 25, 50, -1],
                    [10, 25, 50, 'All']
                ], // Personalizar el menú de longitud de visualización

                "data": categorias,
                "columns": [{
                        "data": "id"
                    },
                    {
                        "data": "nombre"
                    },


                ]
            });
            drawTriangles();
            showUsersSections();
        });

</script>
@stop
