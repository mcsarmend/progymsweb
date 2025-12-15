@extends('adminlte::page')

@section('title', 'Ruta pedidos')

@section('content_header')
@stop

@section('content')
    <div class="card">

        <div class="card-body">

            <div class="card">
                <div class="card-header">
                    <h1>Ruta pedidos</h1>
                </div>
                <div class="card-body">

                    <br>
                </div>
            </div>
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
    </script>
@stop
