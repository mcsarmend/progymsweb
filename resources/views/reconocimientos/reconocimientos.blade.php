@extends('adminlte::page')

@section('title', 'Reconocimientos')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title" style ="font-size: 2rem">Reconocimientos</h1>
                </div>
                <div class="card-body">
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eaque minus fugit distinctio similique
                        incidunt beatae, hic autem quod molestias quo expedita praesentium suscipit veritatis fuga. Et
                        architecto tempore ad aspernatur!</p>
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
