@extends('adminlte::page')

@section('title', 'Traspaso Almacén')

@section('content_header')
@stop

@section('content')
    <div class="card">

        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1>Traspaso Almacén</h1>
                </div>
                <div class="card-body">
                    <form id = "traspaso">
                        <div class="row">
                            <div class="col">
                                <label for="">Almacén Origen:</label>
                                <select class="form-control" name="almacen_origen" required>
                                    <option class="form-control" value="">Selecciona un almacen</option>
                                    @foreach ($almacenes as $almacen)
                                        <option class="form-control" value="{{ $almacen->id }}">{{ $almacen->nombre }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col">
                                <label for="">Almacén Destino:</label>
                                <select class="form-control" name="almacen_destino" required>
                                    <option class="form-control" value="">Selecciona un almacen</option>
                                    @foreach ($almacenes as $almacen)
                                        <option class="form-control" value="{{ $almacen->id }}">{{ $almacen->nombre }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <br>
                        <div class="col">
                            <div class="btn btn-primary" onclick="agregarProducto()">Agregar otro producto</div>
                        </div>
                        <br>

                        <div class="row">
                            <div class="col" class="form-control">CANTIDAD</div>
                            <div class="col" class="form-control">PRODUCTO</div>
                        </div>
                        <br>
                        <div id="products-container">
                            <!-- Movemos el elemento #fila-producto aquí -->
                            <div class="row" id="fila-producto">
                                <div class="col-sm-2">
                                    <input type="number" id ="cantidad" name ="cantidad" class="form-control" required>
                                </div>
                                <div class="col">
                                    <input type="text" id="producto" name="producto" list="productos-list"
                                        class="form-control">
                                    <datalist id="productos-list">
                                        @foreach ($productos as $producto)
                                            <option value="{{ $producto->id }} {{ $producto->nombre }}">
                                        @endforeach
                                    </datalist>
                                </div>
                                <datalist id="productos-list">
                                    <!-- Las opciones se llenarán dinámicamente -->
                                </datalist>

                            </div>
                            <br>
                        </div>
                        <div class="row">
                            <div class="col">
                                <button type="submit" class="btn btn-success">Realizar traspaso</button>
                            </div>
                        </div>
                        <br>
                    </form>

                </div>

            </div>
        </div>
    </div>

    </div>
    @include('fondo')
@stop

@section('css')

@stop

@section('js')
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script>
        let contadorFilas = 1;
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();


        });

        function agregarProducto() {
            contadorFilas++;
            var divRow = document.createElement('div');
            divRow.className = 'row';
            divRow.id = 'fila-producto-' + contadorFilas;

            var divCol1 = document.createElement('div');
            divCol1.className = 'col-sm-2';
            var inputCantidad = document.createElement('input');
            inputCantidad.type = 'number';
            inputCantidad.name = 'cantidad' + contadorFilas;
            inputCantidad.className = 'form-control';
            inputCantidad.required = true;
            divCol1.appendChild(inputCantidad);

            var divCol2 = document.createElement('div');
            divCol2.className = 'col';
            var inputProducto = document.createElement('input');
            inputProducto.type = 'text';
            inputProducto.id = 'producto' + contadorFilas;
            inputProducto.name = 'producto' + contadorFilas;
            inputProducto.setAttribute('list', 'productos-list');
            inputProducto.className = 'form-control';
            divCol2.appendChild(inputProducto);

            var dataList = document.createElement('datalist');
            dataList.id = 'productos-list';
            divCol2.appendChild(dataList);

            var divCol3 = document.createElement('div');
            divCol3.className = 'col-sm-2';
            var btnEliminar = document.createElement('button');
            btnEliminar.type = 'button';
            btnEliminar.className = 'btn btn-danger';
            btnEliminar.innerText = 'Eliminar';
            btnEliminar.onclick = function() {
                eliminarFila(divRow);
            };
            divCol3.appendChild(btnEliminar);

            divRow.appendChild(divCol1);
            divRow.appendChild(divCol2);
            divRow.appendChild(divCol3);

            document.querySelector('#products-container').appendChild(divRow);

            const br = document.createElement('br');
            document.querySelector('#products-container').appendChild(br);
        }

        function eliminarFila(elemento) {
            elemento.remove();
        }

        $('#traspaso').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();
            // Obtener los valores de los elementos del formulario
            var almacenOrigen = document.querySelector('select[name="almacen_origen"]').value;
            var almacenDestino = document.querySelector('select[name="almacen_destino"]').value;
            var cantidades = [];
            var productos = [];

            cantidades.push($('#cantidad').val());
            productos.push($('#producto').val());


            // Obtener los elementos de cantidad y producto
            for (let index = 2; index <= contadorFilas; index++) {
                cantidades.push(document.querySelector('input[name="cantidad' + contadorFilas + '"]').value);
                productos.push(document.querySelector('input[name="producto' + contadorFilas + '"]').value);
            }



            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/realizartraspaso', // Ruta al controlador de Laravel
                type: 'POST',
                data: {
                    "almacen_origen": almacenOrigen,
                    "almacen_destino": almacenDestino,
                    "productos": productos,
                    "cantidades": cantidades
                }, // Enviar los datos del formulario
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
                        "Existe un error: " + response.responseJSON.message,
                        'error'
                    )
                }
            });
        });
    </script>
@stop
