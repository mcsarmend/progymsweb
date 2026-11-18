@extends('adminlte::page')

@section('title', 'Nuevo Pedido')

@section('content_header')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Nuevo Pedido</h2>
        </div>
        <div class="card-body">

            <form id="nuevopedido">

                <div class="row">
                    <div class="col"><label for="vendedor">Vendedor:</label></div>
                    <div class="col"><input type="text" class="form-control" id="vendedor" name="vendedor"
                            data-value={{ $idvendedor }} value="{{ $vendedor }}" readonly></div>

                    <div class="col"><label for="fecha">Fecha:</label></div>
                    <div class="col"><input type="date" class="form-control" id="fecha" name="fecha"
                            data-value="" value="" readonly></div>
                </div>
                <br>
                <div class="row">
                    <div class="col"><label for="nota">Nota:</label></div>
                    <div class="col">
                        <textarea id="nota" name="nota" rows="3" cols="21" placeholder="Escribe tu texto aquí..."
                            data-value="" value=""></textarea>
                    </div>

                    <div class="col"><label for="cliente">Cliente:</label></div>
                    <div class="col">
                        <input type="text" id="cliente" name="cliente" list="client-list" class="form-control">
                        <datalist id="client-list">
                            @foreach ($clientes as $cliente)
                                <option value="{{ $cliente->id }}-{{ $cliente->nombre }}">
                            @endforeach
                        </datalist>
                    </div>

                    <div class="col"><label for="tipo_precio">Tipo de Precio:</label></div>
                    <div class="col">
                        <select name="tipo_precio" id="tipo_precio" class="form-control"
                            @if ($type == 4) disabled @endif>
                            <option value="1">Publico</option>
                            <option value="2">Frecuente</option>
                            <option value="3">Mayoreo</option>
                            <option value="4">Distribuidor</option>
                            <option value="6">Platinum</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="btn btn-primary" onclick="buscarProducto()">Agregar otro producto</div>
                    </div>
                </div>

                <div class="row">
                    <table id="productos" class="table" border="0.1">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Cantidad</th>
                                <th>Nombre</th>
                                <th>Precio Unitario</th>
                                <th>Subtotal</th>
                                <th>Sucursal</th>
                                <th>Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

                <div class="row">
                    <div class="col">
                        <button type="submit" class="btn btn-success">Realizar Pedido</button>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>

    <script>
        var contadorFilas = 1;
        var sum = 0;

        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            var type = @json($type);

            if (type == 4) {
                $("#tipo_precio").prop("disabled", true);
            }

            $('#fecha').val(new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000 - 6 * 60 * 60000)
                .toISOString().split('T')[0]);
        });

        // Función para generar opciones de sucursales
        function generateSucursalOptions() {
            return new Promise((resolve) => {
                var sucursales = @json($idssucursales);
                var optionsHtml = '<option value="">Selecciona una sucursal</option>';

                sucursales.forEach(function(sucursal) {
                    optionsHtml += `<option value="${sucursal.id}">${sucursal.nombre}</option>`;
                });
                resolve(optionsHtml);
            });
        } // Función para obtener nombre de sucursal
        // Función para obtener nombre de sucursal
        function getNombreSucursal(idSucursal) {
            var sucursales = @json($idssucursales);
            var found = sucursales.find(s => s.id == parseInt(idSucursal)); // Asegurar que sea número
            return found ? found.nombre : 'Sucursal no encontrada (ID: ' + idSucursal + ')';
        }

        function cargarProductosPorSucursal() {
            var idsucursal = $('#inputSucursal').val();

            if (!idsucursal) {
                $('#datalistOptions').html('<option value="">Primero selecciona una sucursal</option>');
                $('#inputWithDatalist').val('');
                $('#inputExistencias').val('');
                return;
            }

            $.ajax({
                url: 'productosinventario',
                type: 'POST',
                data: {
                    sucursal: idsucursal
                },
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    // Cerrar el loading


                    var dataList = '';
                    if (response.productos && response.productos.length > 0) {
                        response.productos.forEach(function(item) {
                            dataList +=
                                `<option value="${item.id}-${item.nombre} - ${item.nombre_marca}" data-existencias="${item.existencias}">`;
                        });
                        $('#datalistOptions').html(dataList);
                        $('#inputWithDatalist').val('');
                        $('#inputExistencias').val('');
                        // No mostrar mensaje de éxito, solo actualizar el datalist
                    } else {
                        $('#datalistOptions').html(
                            '<option value="">No hay productos disponibles en esta sucursal</option>');
                        $('#inputWithDatalist').val('');
                        $('#inputExistencias').val('');
                    }
                },
                error: function(xhr, status, error) {
                    Swal.close();
                    Swal.fire({
                        title: 'Error al cargar productos',
                        text: xhr.responseJSON?.error || 'Ocurrió un error al cargar los productos',
                        icon: 'error'
                    });
                }
            });
        }

        // Función principal buscarProducto
        // Función principal buscarProducto
        function buscarProducto() {
            var precioproducto = "";
            if ($('#cliente').val() == "") {
                Swal.fire({
                    title: '¡No has indicado cliente!',
                    icon: 'warning'
                });
                return;
            } else {
                // Generar opciones de sucursales
                generateSucursalOptions().then(sucursalOptionsHtml => {
                    Swal.fire({
                        title: 'Productos',
                        html: `
                    <div style="text-align: left;">
                        <label for="inputSucursal">Selecciona una sucursal:</label>
                        <select id="inputSucursal" class="form-control col-sm-14" onchange="cargarProductosPorSucursal()">
                            ${sucursalOptionsHtml}
                        </select>
                        <br><br>
                        <label for="inputWithDatalist">Selecciona un producto:</label>
                        <input list="datalistOptions" id="inputWithDatalist" class="form-control col-sm-14" oninput="actualizarExistencias()">
                        <datalist id="datalistOptions">
                            <option value="">Primero selecciona una sucursal</option>
                        </datalist>
                        <br><br>
                        <label for="inputCantidad">Cantidad:</label>
                        <input type="number" id="inputCantidad" class="form-control col-sm-14" min="1" value="1">
                        <br>
                        <label for="inputExistencias">Existencias:</label>
                        <input type="number" id="inputExistencias" class="form-control col-sm-14" readonly>
                        <br>
                    </div>
                `,
                        width: '600px',
                        focusConfirm: false,
                        preConfirm: () => {
                            const cantidad = document.getElementById('inputCantidad').value;
                            const producto = document.getElementById('inputWithDatalist').value;
                            const sucursal = document.getElementById('inputSucursal').value;

                            if (sucursal === "") {
                                Swal.showValidationMessage('Debes seleccionar una sucursal');
                                return false;
                            }

                            if (producto === "") {
                                Swal.showValidationMessage('Debes seleccionar un producto');
                                return false;
                            }

                            if (cantidad === "" || parseInt(cantidad) <= 0) {
                                Swal.showValidationMessage('La cantidad debe ser mayor a 0');
                                return false;
                            }

                            // Validar que la cantidad no supere las existencias
                            var existencias = parseInt($('#inputExistencias').val());
                            var cantidadSolicitada = parseInt(cantidad);

                            if (cantidadSolicitada > existencias) {
                                Swal.showValidationMessage(
                                    `No hay suficiente stock. Existencias disponibles: ${existencias}`
                                );
                                return false;
                            }

                            return {
                                cantidad: cantidad,
                                producto: producto,
                                sucursal: sucursal
                            };
                        },
                        showCancelButton: true,
                        confirmButtonText: 'Siguiente',
                        cancelButtonText: 'Cerrar'
                    }).then((result) => {
                        if (result.isConfirmed && result.value) {
                            if (parseInt($('#inputCantidad').val()) > parseInt($('#inputExistencias')
                                    .val())) {
                                Swal.fire({
                                    title: '¡Debes ingresar una cantidad menor o igual a las existencias!',
                                    icon: 'warning'
                                });
                                return;
                            }
                            const idproducto = obtenerNumerosHastaGuion(result.value.producto);
                            var idcliente = obtenerNumerosHastaGuion($('#cliente').val());
                            var cantidad = result.value.cantidad;
                            var idsucursal = result.value.sucursal;
                            var idprecio = $('#tipo_precio').val();

                            if (idcliente == null) {
                                idcliente = 1;
                            }

                            const data = {
                                id_producto: idproducto,
                                idcliente: idcliente,
                                cantidad: cantidad,
                                sucursal: idsucursal,
                                id_precio: idprecio
                            };

                            // Mostrar loading
                            Swal.fire({
                                title: 'Procesando...',
                                text: 'Validando disponibilidad del producto',
                                allowOutsideClick: false,
                                didOpen: () => {
                                    Swal.showLoading();
                                }
                            });

                            $.ajax({
                                url: 'buscarprecio',
                                type: 'POST',
                                data: data,
                                dataType: 'json',
                                headers: {
                                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                },
                                success: function(data) {
                                    Swal.close();
                                    // PASAR EL ID DE SUCURSAL CORRECTAMENTE
                                    agregarFila(data.idproducto, data.cantidad, data.subtotal,
                                        data.nombre, data.precio, idsucursal);
                                },
                                error: function(xhr, status, error) {
                                    Swal.close();
                                    Swal.fire({
                                        title: 'Error:',
                                        text: xhr.responseJSON?.error ||
                                            'Ocurrió un error',
                                        icon: 'warning'
                                    });
                                }
                            });
                        }
                    });
                });
            }
        }
        // Función para agregar fila
        function agregarFila(codigo, cantidad, subtotal, nombre, precio, sucursal) {
            var nombreSucursal = getNombreSucursal(sucursal);
            console.log('ID Sucursal:', sucursal);
            console.log('Nombre Sucursal:', nombreSucursal);

            var nuevaFila =
                `<tr>
            <td>${codigo}</td>
            <td>${cantidad}</td>
            <td>${nombre}</td>
            <td>$${parseFloat(precio).toFixed(2)}</td>
            <td>$${parseFloat(subtotal).toFixed(2)}</td>
            <td>${nombreSucursal}</td>
            <td><button class="btn btn-danger btn-sm eliminar-fila">Eliminar</button></td>
        </tr>`;

            $('#productos tbody').append(nuevaFila);

            $('.eliminar-fila').off('click').on('click', function() {
                $(this).closest('tr').remove();
                actualizarTotal();
            });

            actualizarTotal();

            Swal.fire({
                title: '¡Producto agregado!',
                text: `${nombre} - Sucursal: ${nombreSucursal}`,
                icon: 'success',
                timer: 1500,
                showConfirmButton: false
            });
        }
        // Función para actualizar total
        // Función para actualizar total
        function actualizarTotal() {
            var total = 0;
            $('#productos tbody tr').each(function() {
                var subtotalText = $(this).find('td').eq(4).text().replace('$', '').trim();
                var subtotal = parseFloat(subtotalText);
                if (!isNaN(subtotal)) {
                    total += subtotal;
                }
            });
            console.log('Total actualizado:', total.toFixed(2));
            return total;
        }

        function actualizarExistencias() {
            const productoInput = document.getElementById('inputWithDatalist');
            const idProducto = obtenerNumerosHastaGuion(productoInput.value);
            const idsucursal = $('#inputSucursal').val();

            if (!idProducto || !idsucursal) {
                $('#inputExistencias').val('');
                return;
            }

            // Buscar en el datalist las existencias
            var option = $(`#datalistOptions option[value="${productoInput.value}"]`);
            if (option.length > 0) {
                var existencias = option.data('existencias');
                if (existencias !== undefined) {
                    $('#inputExistencias').val(existencias);
                    $('#inputCantidad').attr('max', existencias);

                    // Validar si la cantidad actual supera las existencias
                    var cantidadActual = parseInt($('#inputCantidad').val());
                    if (cantidadActual > existencias) {
                        $('#inputCantidad').val(existencias);
                    }
                    return;
                }
            }

            // Si no se encuentra en el datalist, hacer la consulta AJAX
            const data = {
                id_producto: idProducto,
                sucursal: idsucursal,
            };

            $.ajax({
                url: 'buscarexistencias',
                type: 'POST',
                data: data,
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(data) {
                    $('#inputExistencias').val(data.existencias);
                    $('#inputCantidad').attr('max', data.existencias);

                    // Validar si la cantidad actual supera las existencias
                    var cantidadActual = parseInt($('#inputCantidad').val());
                    if (cantidadActual > data.existencias) {
                        $('#inputCantidad').val(data.existencias);
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Error:',
                        text: xhr.responseJSON?.error || 'Error al obtener existencias',
                        icon: 'warning'
                    });
                }
            });
        }
        // Función para obtener números hasta guión
        function obtenerNumerosHastaGuion(text) {
            if (!text) return null;
            const indiceGuion = text.indexOf('-');
            if (indiceGuion === -1) {
                return text;
            }
            const subcadena = text.substring(0, indiceGuion);
            const numeros = subcadena.match(/\d+/g);
            return numeros ? numeros.join('') : '';
        }

        // Submit del formulario
        // Submit del formulario
        $('#nuevopedido').submit(function(e) {
            e.preventDefault();

            var datosFormulario = $(this).serialize();
            var datos = [];
            var formData = new URLSearchParams(datosFormulario);

            for (const [key, value] of formData.entries()) {
                datos.push({
                    key: key,
                    value: value
                });
            }

            var table = `
        <table style="width:100%; border: 1px solid black; border-collapse: collapse; font-size: 15px;">
            <tr><th style="border: 1px solid black; padding: 8px;">Campo</th>
            <th style="border: 1px solid black; padding: 8px;">Valor</th></tr>
    `;

            datos.forEach(element => {
                table += `
            <tr>
                <td style="border: 1px solid black; padding: 8px;">${element.key}</td>
                <td style="border: 1px solid black; padding: 8px;">${element.value}</td>
            </tr>`;
            });

            table += '</table>';

            // Clonar la tabla de productos
            var $productoTableClone = $('#productos').clone();
            $productoTableClone.attr('id', 'productosClone');

            // Eliminar la columna "Eliminar" (última columna)
            $productoTableClone.find('tr').each(function() {
                $(this).find('td:last-child, th:last-child').remove();
            });

            // Calcular el total correctamente
            var total = 0;
            $productoTableClone.find('tbody tr').each(function() {
                // El subtotal está en la columna 4 (índice 4)
                var subtotalText = $(this).find('td').eq(4).text().replace('$', '').trim();
                var subtotal = parseFloat(subtotalText);
                if (!isNaN(subtotal)) {
                    total += subtotal;
                }
            });

            // Agregar fila de total
            var columnCount = $productoTableClone.find('thead tr th').length;
            $productoTableClone.find('tbody').append(`
        <tr style="font-weight: bold; background-color: #f8f9fa;">
            <td colspan="${columnCount - 1}" style="border: 1px solid black; padding: 8px; text-align: right;">Total</td>
            <td style="border: 1px solid black; padding: 8px;">$${total.toFixed(2)}</td>
        </tr>
    `);

            var productoTableHtml = $productoTableClone.prop('outerHTML');
            var elementos = table + '<br><br>' + productoTableHtml;

            Swal.fire({
                title: '¡Se levantará un pedido con los siguientes datos!',
                html: elementos,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Enviar pedido',
                width: '80%',
            }).then((result) => {
                if (result.isConfirmed) {
                    var fecha = $('#fecha').val();
                    const opciones = {
                        timeZone: 'America/Mexico_City',
                        hour12: false
                    };
                    var hora = new Date().toLocaleString('es-MX', opciones);
                    var nota = $('#nota').val();
                    var vendedor = $('#vendedor').data('value');
                    var cantidadTotalLetra = convertirNumeroALetras(total);
                    var cliente = $('#cliente').val();

                    validarPedido(hora, nota, vendedor, cliente, total);
                }
            });
        });

        function validarPedido(hora, nota, vendedor, cliente, total) {
            // Obtener datos de la tabla
            var table = $('#productos');
            var tableData = tableToJson(table);

            // Eliminar la columna "Eliminar" de los datos
            tableData.forEach(element => {
                delete element["Eliminar"];
            });

            // Verificar que haya productos
            if (tableData.length === 0) {
                Swal.fire({
                    title: '¡No has agregado productos!',
                    icon: 'warning'
                });
                return;
            }

            // Si no se pasó el total, calcularlo
            if (!total) {
                total = 0;
                tableData.forEach(element => {
                    var subtotal = parseFloat(element.Subtotal.replace('$', '').trim());
                    if (!isNaN(subtotal)) total += subtotal;
                });
            }

            // Convertir a JSON
            var jsonString = JSON.stringify(tableData, null, 2);

            var tipo_precio = $("#tipo_precio").val();
            const data = {
                nota: nota,
                fecha: hora,
                vendedor: vendedor,
                cliente: cliente,
                productos: jsonString,
                total: total,
                tipo_precio: tipo_precio,
            };

            $.ajax({
                url: 'crearnuevopedido',
                type: 'POST',
                data: data,
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(data) {
                    var msg = data.message;
                    Swal.fire({
                        title: msg,
                        icon: 'success',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        width: '80%'
                    });
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Error al crear el pedido',
                        text: xhr.responseJSON?.error || 'Ocurrió un error',
                        icon: 'error'
                    });
                }
            });
        }

        function tableToJson(table) {
            var data = [];
            var headers = [];

            // Obtener encabezados
            $(table).find('thead th').each(function(index, th) {
                headers[index] = $(th).text().trim();
            });

            // Obtener datos de las filas
            $(table).find('tbody tr').each(function(index, tr) {
                var row = {};
                $(tr).find('td').each(function(cellIndex, td) {
                    var header = headers[cellIndex];
                    if (header) {
                        row[header] = $(td).text().trim();
                    }
                });
                data.push(row);
            });

            return data;
        }

        $('#cliente').on('change', function() {
            var cliente = $(this).val();
            var idcliente = obtenerNumerosHastaGuion(cliente);

            $.ajax({
                url: 'buscaridprecio',
                type: 'POST',
                data: {
                    idcliente: idcliente
                },
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    if (response.nombreprecio == null) {
                        $('#tipo_precio').val("Publico");
                    } else {
                        $('#tipo_precio').val(response.idprecio);
                    }
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        });

        function convertirNumeroALetras(num) {
            const unidades = ["", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"];
            const decenas = ["", "diez", "veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta",
                "noventa"
            ];
            const centenas = ["", "cien", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos",
                "setecientos", "ochocientos", "novecientos"
            ];

            if (num === 0) {
                return "cero";
            }

            function convertirCentenas(num) {
                if (num > 99) {
                    return centenas[Math.floor(num / 100)] + " " + convertirDecenas(num % 100);
                } else {
                    return convertirDecenas(num);
                }
            }

            function convertirDecenas(num) {
                if (num < 10) {
                    return unidades[num];
                } else if (num >= 10 && num < 20) {
                    const excepciones = ["diez", "once", "doce", "trece", "catorce", "quince", "dieciséis", "diecisiete",
                        "dieciocho", "diecinueve"
                    ];
                    return excepciones[num - 10];
                } else {
                    return decenas[Math.floor(num / 10)] + (num % 10 === 0 ? "" : " y " + unidades[num % 10]);
                }
            }

            function convertirMiles(num) {
                if (num > 999) {
                    return convertirCentenas(Math.floor(num / 1000)) + " mil " + convertirCentenas(num % 1000);
                } else {
                    return convertirCentenas(num);
                }
            }

            return convertirMiles(num).trim();
        }
    </script>
@stop
