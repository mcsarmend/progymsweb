@extends('adminlte::page')

@section('title', 'Edición Proveedores')

@section('content_header')
    <h1>Edición Proveedores</h1>
@stop

@section('content')
   <div class="card">
    <div class="card-header">
        <h1 class="card-title">Edición Proveedores</h1>
    </div>
    <div class="card-body">
        <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Nihil laboriosam temporibus architecto, cumque accusamus asperiores in iusto dignissimos sequi. Odio alias commodi dicta repellat rerum quisquam! Ab aut nemo accusamus!</p>
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
