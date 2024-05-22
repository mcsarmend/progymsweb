@extends('adminlte::page')

@section('title', 'Ingreso Inventario')

@section('content_header')
    <h1>Ingreso Inventario</h1>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            Descripción del producto
        </div>
        <div class="card-body">
            <form action="">
                <label for="name">Nombre:</label>

                <input type="text" id="name" name="name" class="form-control" placeholder="Nombre">
                <br>
                <label for="name">Codigo de Barras:</label>

                <input type="text" id="id" name="id" required minlength="10" maxlength="10"
                    class="form-control" placeholder="10 caracteres">
                <br>

                <label for="">Marca:</label>
                <select class="form-control" name="marca">
                    <option class="form-control"value="">Selecciona una marca</option>
                    @foreach ($marcas as $marca)
                        <option class="form-control" value="{{ $marca->id }}">{{ $marca->nombre }}</option>
                    @endforeach
                </select>
                <br>
                <label for="">Categoria:</label>
                <select class="form-control" name="marca">
                    <option class="form-control"value="">Selecciona una categoria</option>
                    @foreach ($categorias as $categoria)
                        <option class="form-control" value="{{ $categoria->id }}">{{ $categoria->nombre }}</option>
                    @endforeach
                </select>
                <br>
                
                Almacen 1
                Almacen 2
                Almacen 3
                Almacen 4
                Almacen 5
                Almacen 6
                Almacen 7
                Precio de venta 1
                Precio de venta 2
                Precio de venta 3
                Precio de venta 4

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
    </script>
@stop
