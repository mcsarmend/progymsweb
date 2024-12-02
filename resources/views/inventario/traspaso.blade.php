@extends('adminlte::page')

@section('title', 'Traspaso Almacén')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Inventario > Traspaso</h2>
        </div>
        <div class="card-body">
            <div class="card">
                <div class="card-body">
                    <form method="POST" id="traspaso">
                        @csrf
                        <div class="row">
                            <div class="col">
                                <label for="">Almacén Origen:</label>
                                <select class="form-control" name="almacen_origen" id="almacen_origen" required>
                                    <option class="form-control" value="">Selecciona un almacen</option>
                                    @foreach ($almacenes as $almacen)
                                        <option class="form-control" value="{{ $almacen->id }}">{{ $almacen->nombre }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col">
                                <label for="">Almacén Destino:</label>
                                <select class="form-control" name="almacen_destino" id="almacen_destino" required>
                                    <option class="form-control" value="">Selecciona un almacen</option>
                                    @foreach ($almacenes as $almacen)
                                        <option class="form-control" value="{{ $almacen->id }}">{{ $almacen->nombre }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col">
                                <label for="documento">Documento:</label>
                                <input type="text" name="documento" id="documento" class="form-control">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col">
                                <div class="btn btn-primary" onclick="buscarProducto()">Agregar otro producto</div>
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
                            <button type="submit" class="btn btn-success">Traspasar</button>
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
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script>
        let contadorFilas = 1;
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            $('#almacen_origen, #almacen_destino').change(function() {
                crearnodocumento();
            });

        });

        function crearnodocumento() {
            const time = getFormattedDateTime();
            const almacenOrigen = $('#almacen_origen option:selected').text().trim().substring(0, 3).toUpperCase();
            const almacenDestino = $('#almacen_destino option:selected').text().trim().substring(0, 3).toUpperCase();
            const clave = almacenOrigen + almacenDestino;
            const documento = time + clave;
            $('#documento').val(documento);
        }

        function buscarProducto() {
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
                    const datalist = document.getElementById('datalistOptions');
                    const options = Array.from(datalist.options).map(option => option.value);
                    if (cantidad === "" || producto === "" || !options.includes(producto)) {
                        Swal.showValidationMessage(
                            'Debes llenar ambos campos y seleccionar un producto válido');
                        return false;
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
                    const cantidad = result.value.cantidad;
                    const idsucursal = $('#sucursal').val();
                    const idcliente = ""; // Ajusta esto según tus necesidades

                    const data = {
                        id_producto: idproducto,
                        idcliente: idcliente || 1,
                        cantidad: cantidad,
                        sucursal: idsucursal
                    };

                    $.ajax({
                        url: 'buscarpreciocompras',
                        type: 'POST',
                        data: data,
                        dataType: 'json',
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

        $('#traspaso').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario y generar la tabla inicial
            var datosFormulario = $(this).serialize();

            var formData = new URLSearchParams(datosFormulario);
            datosForm = [];
            for (const [key, value] of formData.entries()) {
                datosForm.push({
                    key: key,
                    value: value
                });
            }


            datos = tableToJson("productos");

            // Clonar la tabla con id="productos" y ajustarla para el PDF
            var $productoTableClone = $('#productos').clone();
            $productoTableClone.attr('id', 'productosClone')
            $productoTableClone.find('tr').each(function() {
                $(this).find('td:last-child, th:last-child').remove();
            });

            // Calcular la suma de la última columna
            var sum = 0;
            $productoTableClone.find('tr').each(function() {
                var $lastTd = $(this).find('td:last-child');
                if ($lastTd.length) {
                    var value = parseFloat($lastTd.text());
                    if (!isNaN(value)) {
                        sum += value;
                    }
                }
            });

            // if (sum == 0) {
            //     Swal.fire({
            //         title: 'No hay productos agregados',
            //         text: 'Debe agregar al menos un producto',
            //         icon: 'error'
            //     });
            //     return;
            // }

            if ($('#almacen_origen').val() == $('#almacen_destino').val()) {
                Swal.fire({
                    title: 'Los almacenes son los mismos',
                    text: 'Selecciona almacenes distintos',
                    icon: 'error'
                });
                return;
            }





            // Mostrar el cuadro de diálogo de confirmación con SweetAlert
            Swal.fire({
                title: '¡Se realizará un traspaso de mercancia!',
                text: "Total de importe: " + sum,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceptar',
                width: '80%'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Obtener los valores necesarios para el PDF
                    var documento = $('#documento').val();
                    var almacen_origen = $('#almacen_origen').val();
                    var almacen_destino = $('#almacen_destino').val();

                    numeroRemision = enviartraspaso("TRASNFER", datos, documento, sum, almacen_origen,
                        almacen_destino);

                }
            });
        });


        function enviartraspaso(movimiento, data, documento, suma, almacen_origen, almacen_destino) {

            const datos = {
                almacen_origen: almacen_origen,
                almacen_destino: almacen_destino,
                movimiento: movimiento,
                productos: data,
                documento: documento,
                importe: suma
            };

            $.ajax({
                url: 'realizartraspaso', // URL a la que se hace la solicitud
                type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                data: datos,
                dataType: 'json', // Tipo de datos esperados en la respuesta
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire({
                        title: '¡Gracias por esperar!:',
                        text: response.message,
                        icon: 'success'
                    });
                    setTimeout(function() {
                        window.location.reload();
                    }, 3000);



                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Error:',
                        text: xhr.responseJSON.error,
                        icon: 'danger'
                    });
                }
            });
        }

        function tableToJson(tableId) {
            var table = $('#' + tableId);
            var headers = [];
            var data = [];

            // Obtener encabezados de la tabla
            table.find('thead th').each(function(index, item) {
                headers[index] = $(item).text();
            });

            // Obtener filas de la tabla
            table.find('tbody tr').each(function() {
                var row = {};
                $(this).find('td').each(function(index, item) {
                    row[headers[index]] = $(item).text();
                });
                data.push(row);
            });

            // Convertir datos a JSON
            return JSON.stringify(data, null, 4);
        }
    </script>
@stop
