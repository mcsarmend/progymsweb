@extends('adminlte::page')

@section('title', 'Alta Cliente')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Alta Cliente</h1>

        </div>
        <div class="card-body">
            <form id="crearcliente">
                @csrf
                <div class="row">
                    <div class="col">
                        <label for="cliente">Nombre Cliente:</label>
                    </div>
                    <div class="col">
                        <input type="text" id="cliente" name="cliente" class="form-control" required> <br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col"><label for="">Sucursal:</label></div>
                    <div class="col"> <select class="form-control" name="sucursal">

                            @foreach ($warehouses as $warehouse)
                                <option class="form-control" value="{{ $warehouse->id }}">{{ $warehouse->nombre }}</option>
                            @endforeach
                        </select></div>
                </div>
                <br>
                <div class="row">
                    <div class="col">
                        <label for="telefono">Telefono:</label>
                    </div>
                    <div class="col">
                        <input type="number" id="telefono" name="telefono" class="form-control" required> <br><br>
                    </div>
                </div>


                <div class="row">
                    <div class="col"><label for="">Precio:</label></div>
                    <div class="col"> <select class="form-control" name="precio">

                            @foreach ($prices as $price)
                                <option class="form-control" value="{{ $price->id }}">{{ $price->nombre }}</option>
                            @endforeach
                        </select></div>
                </div>
                <br>
                <div class="row">
                    <div class="col">
                        <input type="submit" value="Crear" class="btn btn-success">
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
        });
        $('#crearcliente').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/crearcliente', // Ruta al controlador de Laravel
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
