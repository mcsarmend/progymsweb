@extends('adminlte::page')

@section('title', 'Inventario > Mermas')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Inventario > Mermas</h1>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style ="font-size: 2rem">Mermas</h1>
                </div>
                <div class="card-body">

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
