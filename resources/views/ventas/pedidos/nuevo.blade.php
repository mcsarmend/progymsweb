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
                                <th>Cancelar</th>
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

            // Si type es 4, deshabilitar el tipo de precio (por si acaso)
            if (type == 4) {
                $("#tipo_precio").prop("disabled", true);
            }

            $('#fecha').val(new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000 - 6 * 60 * 60000)
                .toISOString().split('T')[0]);
        });

        function buscarProducto() {
            var precioproducto = "";
            if ($('#cliente').val() == "") {
                Swal.fire({
                    title: '¡No has indicado cliente!',
                    icon: 'warning'
                });
                return;
            } else {
                generateOptions().then(optionsHtml => {
                    Swal.fire({
                        title: 'Productos',
                        html: `

                <label for="inputWithDatalist">Selecciona un producto:</label>
                <input list="datalistOptions" id="inputWithDatalist" class="form-control col-sm-14" >
                <datalist id="datalistOptions">
                     ${optionsHtml}
                </datalist>
                <label for="inputCantidad">Cantidad:</label>
                <input type="number" id="inputCantidad" class="form-control col-sm-14" >
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
                            var cantidad = $('#inputCantidad').val();
                            var type = @json($type);

                            var idprecio = $('#tipo_precio').val();
                            if (idcliente == null) {
                                idcliente = 1;
                            }

                            const data = {
                                id_producto: idproducto,
                                idcliente: idcliente,
                                cantidad: cantidad,
                                id_precio: idprecio
                            };

                            $.ajax({
                                url: 'buscarsoloprecio', // URL a la que se hace la solicitud
                                type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                                data: data,
                                dataType: 'json', // Tipo de datos esperados en la respuesta
                                headers: {
                                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                },
                                success: function(data) {

                                    agregarFila(data.idproducto, data.cantidad, data.subtotal,
                                        data.nombre,
                                        data.precio);

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
                });
            }
        }



        function generateOptions() {
            return new Promise((resolve) => {
                var options = @json($productos);
                var dataList = '';
                options.forEach(function(item) {
                    dataList += `<option value="${item.id}-${item.nombre} -${item.nombre_marca}">`;
                });
                resolve(dataList);
            });
        }

        function obtenerNumerosHastaGuion(text) {
            return text.split('-')[0];
        }

        function eliminarFila(elemento) {
            elemento.remove();
        }

        function obtenerNumerosHastaGuion(cadena) {
            const indiceGuion = cadena.indexOf('-');
            if (indiceGuion === -1) {
                return null;
            }
            const subcadena = cadena.substring(0, indiceGuion);
            const numeros = subcadena.match(/\d+/g);
            return numeros ? numeros.join('') : '';
        }

        function agregarFila(codigo, cantidad, subtotal, nombre, precio) {
            var codigoExiste = false;
            $('#productos tbody tr').each(function() {
                var codigoExistente = $(this).find('td').eq(0).text();
                if (codigoExistente === codigo) {
                    codigoExiste = true;
                    return false;
                }
            });

            if (codigoExiste) {
                Swal.fire({
                    title: 'El producto ya ha sido agregado',
                    icon: 'warning'
                });
                return;
            }

            var nuevaFila =
                `<tr>
                    <td>${codigo}</td>
                    <td>${cantidad}</td>
                    <td>${nombre}</td>
                    <td>${precio}</td>
                    <td>${subtotal}</td>
                    <td><button class="btn btn-danger btn-sm eliminar-fila">Eliminar</button></td>
                </tr>`;

            $('#productos tbody').append(nuevaFila);

            $('.eliminar-fila').off('click').on('click', function() {
                $(this).closest('tr').remove();
            });

            Swal.fire({
                title: 'Has seleccionado:',
                text: nombre,
                icon: 'success'
            });
        }

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

            var $productoTableClone = $('#productos').clone();
            $productoTableClone.attr('id', 'productosClone');
            $productoTableClone.find('tr').each(function() {
                $(this).find('td:last-child, th:last-child').remove();
            });

            var sum = 0;
            $productoTableClone.find('tr').each(function() {
                var $lastTd = $(this).find('td:last-child');
                if ($lastTd.length) {
                    var value = parseFloat($lastTd.text());
                    if (!isNaN(value)) sum += value;
                }
            });

            $productoTableClone.append(`
                <tr>
                    <td colspan="${$productoTableClone.find('tr:first-child th').length - 1}"
                        style="border: 1px solid black; padding: 8px;">Total</td>
                    <td style="border: 1px solid black; padding: 8px;">${sum}</td>
                </tr>
            `);

            var productoTableHtml = $productoTableClone.prop('outerHTML');
            var elementos = table + '<br>' + productoTableHtml;

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
                    var cantidadTotalLetra = convertirNumeroALetras(sum);
                    var cliente = $('#cliente').val();
                    var $productoTableClone2 = $('#productos').clone();
                    numeroPedido = validarPedido(
                        hora, nota, vendedor, cliente, $productoTableClone2
                    );
                }
            });
        });

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

        function validarPedido(hora, nota, vendedor, cliente, $productoTableClone) {

            var $productoTableClone = $('#productosClone').clone();

            var table = $('#productos');
            var tableData = tableToJson(table);

            tableData.forEach(element => {
                delete element["Cancelar"];
            });
            var jsonString = JSON.stringify(tableData, null, 2);

            var total = 0;
            tableData.forEach(element => {
                total += parseInt(element.Subtotal);
            });

            if (total == 0) {
                Swal.fire({
                    title: '¡No has agregado productos!',
                    icon: 'warning'
                });
                return;
            }

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
            var msg = "";
            $.ajax({
                url: 'crearnuevopedido',
                type: 'POST',
                data: data,
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(data) {
                    msg = data.message + ": " + data.id;
                    numeroPedido = data.id;
                    Swal.fire({
                        title: msg,
                        icon: 'success',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        width: '80%'
                    });
                }
            });
        }

        function tableToJson(table) {
            var data = [];
            var headers = [];
            $(table).find('thead th').each(function(index, th) {
                headers[index] = $(th).text();
            });

            $(table).find('tbody tr').each(function(index, tr) {
                var row = {};
                $(tr).find('td').each(function(cellIndex, td) {
                    row[headers[cellIndex]] = $(td).text();
                });
                data.push(row);
            });

            return data;
        }

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
