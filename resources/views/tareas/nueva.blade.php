@extends('adminlte::page')

@section('title', 'Nueva notificación')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Nueva Tarea</h1>
        </div>
        <div class="card-body">
            <form id="nuevatarea">
                @csrf
                <div class="row">
                    <div class="col">
                        <label for="fechainicio">Fecha Inicio:</label>
                        <input type="date" id="fechainicio" name="fechainicio" class="form-control"required></input>
                    </div>
                    <div class="col">
                        <label for="fechafin">Fecha Fin:</label>
                        <input type="date" id="fechafin" name="fechafin" class="form-control"required></input>
                    </div>
                    <div class="col">
                        <label for="asunto">Asunto:</label>
                        <input type="text" id="asunto" name="asunto" class="form-control"required>
                    </div>
                    <div class="col">
                        <label for="objetivo">Dirijido a:</label>
                        <select name="usuario" id="usuario" class="form-control">
                            @foreach ($usuarios as $usuario)
                                <option value="{{ encrypt($usuario->id) }}">{{ $usuario->name }}</option>
                            @endforeach
                        </select>
                    </div>

                </div>
                <div class="row">
                    <div class="col">
                        <label for="descripcion">Descripción:</label>
                        <textarea id="descripcion" name="descripcion" class="form-control"required></textarea>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </div>
                </div>
            </form>
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

            var today = new Date().toISOString().split('T')[0];

            // Establecer la fecha mínima en los campos de fecha
            $('#fechainicio').attr('min', today);
            $('#fechafin').attr('min', today);

        });

        $('#nuevatarea').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();
            Swal.fire({
                title: '¡Se creará una nueva tarea!',
                text: "¡Revisa que los datos sean correctos!",
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Enviar',
                width: '80%'
            }).then((result) => {
                if (result.isConfirmed) {

                    $.ajax({
                        url: '/creartarea', // Ruta al controlador de Laravel
                        type: 'POST',
                        data: datosFormulario, // Enviar los datos del formulario
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


        });
    </script>
@stop
