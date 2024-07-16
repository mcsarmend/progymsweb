@extends('adminlte::page')

@section('title', 'Inventario > Compras')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Inventario > Compras</h2>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-body">
                    <form method="post" id="enviarcompra">
                        <div class="row">
                            <div class="col">
                                <div class="btn btn-primary" onclick="buscarProducto()">Agregar otro producto</div>
                            </div>
                            <div class="col"><label for="proveedor">Proveedor:</label></div>
                            <div class="col">
                                <select name="proveedor" id="proveedor" class="form-control">
                                    @foreach ($proveedores as $proveedor)
                                        <option value="{{ $proveedor->id }}" data-clave="{{ $proveedor->clave }}">
                                            {{ $proveedor->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col"><label for="sucursal">Sucursal:</label></div>
                            <div class="col">
                                <select name="sucursal" id="sucursal" class="form-control" disabled>
                                    @foreach ($sucursales as $sucursal)
                                        <option value="{{ $sucursal->id }}">{{ $sucursal->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col"><label for="documento">Documento:</label></div>
                            <div class="col">
                                <input type="text" name="documento" id="documento" class="form-control" readonly>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <table id="productos" class="table" border="0.1">
                                <thead>
                                    <tr>
                                        <th>Codigo</th>
                                        <th>Cantidad</th>
                                        <th>Nombre</th>
                                        <th>Costo Unitario</th>
                                        <th>Costo Subtotal</th>
                                        <th>Cancelar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <div class="row">
                            <button type="submit" class="btn btn-success">Ingresar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @include('fondo')
@stop

@section('css')
@stop

@section('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.34/moment-timezone-with-data.min.js"></script>
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();

            $('#proveedor').change(function() {
                time = getFormattedDateTime();
                var selectedOption = $(this).find(':selected'); // Obtén la opción seleccionada
                var clave = selectedOption.data('clave'); // Extrae el atributo data-clave
                var documento = time + clave; // Genera el valor del documento
                $('#documento').val(documento); // Coloca el valor en el input
            });

            crearnodocumento();
        });

        function getFormattedDateTime() {
            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var year = now.getFullYear().toString().slice(-2);
            var hours = ("0" + now.getHours()).slice(-2);
            var minutes = ("0" + now.getMinutes()).slice(-2);

            return day + month + year + hours + minutes;
        }



        function crearnodocumento() {
            time = getFormattedDateTime();
            var selectedOption = $('#proveedor').find(':selected'); // Obtén la opción seleccionada
            var clave = selectedOption.data('clave'); // Extrae el atributo data-clave
            var documento = time + clave; // Genera el valor del documento
            $('#documento').val(documento); // Coloca el valor en el input
        }

        function buscarProducto() {
            var precioproducto = "";
            Swal.fire({
                title: 'Productos',
                html: `
                    <label for="inputWithDatalist">Selecciona un producto:</label>
                    <input list="datalistOptions" id="inputWithDatalist" class="form-control col-sm-14">
                    <datalist id="datalistOptions">
                        ${generateOptions()}
                    </datalist>
                    <label for="inputCantidad">Cantidad:</label>
                    <input type="number" id="inputCantidad" class="form-control col-sm-14">
                    <br>
                `,
                focusConfirm: false,
                preConfirm: () => {
                    const cantidad = document.getElementById('inputCantidad').value;
                    const producto = document.getElementById('inputWithDatalist').value;
                    if (cantidad === "" || producto === "") {
                        Swal.showValidationMessage('Debes llenar ambos campos');
                    }
                    return {
                        cantidad: cantidad,
                        producto: producto
                    };
                },
                showCancelButton: true,
                confirmButtonText: 'Siguiente',
                cancelButtonText: 'Cerrar'
            }).then((result) => {
                if (result.isConfirmed) {
                    const idproducto = obtenerNumerosHastaGuion(result.value.producto);
                    var idcliente = "";
                    var cantidad = $('#inputCantidad').val();
                    var idsucursal = $('#sucursal').val();
                    if (idcliente == null) {
                        idcliente = 1;
                    }
                    const data = {
                        id_producto: idproducto,
                        idcliente: idcliente,
                        cantidad: cantidad,
                        sucursal: idsucursal
                    };
                    $.ajax({
                        url: 'buscarpreciocompras', // URL a la que se hace la solicitud
                        type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                        data: data,
                        dataType: 'json', // Tipo de datos esperados en la respuesta
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        success: function(data) {
                            agregarFila(data.idproducto, data.cantidad, data.nombre, data.costo);
                        },
                        error: function(xhr, status, error) {
                            Swal.fire({
                                title: 'Error:',
                                text: xhr.responseJSON.error,
                                icon: 'warning'
                            });
                        }
                    });
                }
            });
        }

        function generateOptions() {
            var options = @json($productos);
            var dataList = '';
            options.forEach(function(item) {
                dataList += `<option value="${item.id}-${item.nombre}">`;
            });
            return dataList;
        }

        function agregarFila(codigo, cantidad, nombre, costo) {
            // Verificar si el código ya existe en alguna fila
            var codigoExiste = false;
            $('#productos tbody tr').each(function() {
                var codigoExistente = $(this).find('td').eq(0).text();
                if (codigoExistente === codigo) {
                    codigoExiste = true;
                    return false; // Salir del bucle each
                }
            });

            // Si el código ya existe, no agregar la nueva fila
            if (codigoExiste) {
                Swal.fire({
                    title: 'El producto ya ha sido agregado',
                    icon: 'warning'
                });
                return;
            }

            var costosubtotal = costo * cantidad;
            // Crear la nueva fila
            var nuevaFila =
                `<tr>
                    <td>${codigo}</td>
                    <td>${cantidad}</td>
                    <td>${nombre}</td>
                    <td>${costo}</td>
                    <td>${costosubtotal}</td>
                    <td><button class="btn btn-danger btn-sm eliminar-fila">Eliminar</button></td>
                </tr>`;

            // Agregar la nueva fila a la tabla
            $('#productos tbody').append(nuevaFila);

            // Asignar el evento de eliminación a los botones de la nueva fila
            $('.eliminar-fila').off('click').on('click', function() {
                $(this).closest('tr').remove();
            });

            Swal.fire({
                title: 'Has agregado:',
                text: nombre,
                icon: 'success'
            });
        }

        function obtenerNumerosHastaGuion(text) {
            return text.split('-')[0];
        }
    </script>
@stop
