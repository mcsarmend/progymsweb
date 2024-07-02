@extends('adminlte::page')

@section('title', 'Remisionar')

@section('content_header')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Remisionar</h2>
        </div>
        <div class="card-body">


            <form id="remisionar">

                <div class="row">
                    <div class="col"><label for="vendedor">Vendedor:</label></div>
                    <div class="col"><input type="text" class="form-control" id="vendedor" name = "vendedor"
                            data-value={{ $idvendedor }} value="{{ $vendedor }}" readonly></div>

                    <div class="col"><label for="sucursal">Sucursal:</label></div>
                    <div class="col"><input type="text" class="form-control" id="sucursal" name = "sucursal"
                            data-value={{ $idsucursal }} value={{ $nombresucursal->nombre }} readonly></div>

                    <div class="col"><label for="fecha">Fecha:</label></div>
                    <div class="col"><input type="date" class="form-control" id="fecha" name = "fecha"
                            data-value="" value="" readonly></div>

                </div>
                <br>
                <div class="row">
                    <div class="col"><label for="nota">Nota:</label></div>
                    <div class="col">
                        <textarea id="nota" name="nota" rows="3" cols="21" placeholder="Escribe tu texto aquí..."
                            data-value=""></textarea>
                    </div>
                    <div class="col"><label for="metodo_pago">Metodo de pago:</label></div>
                    <div class="col">
                        <select name="metodo_pago" id="metodo_pago" class="form-control">
                            <option value="efectivo">Efectivo</option>
                            <option value="transferencia">Transferencia</option>
                            <option value="terminal">Terminal</option>
                            <option value="clip">Clip</option>
                        </select>

                    </div>

                    <div class="col"><label for="cliente">Cliente:</label></div>
                    <div class="col">
                        <!-- Movemos el elemento #fila-producto aquí -->
                        <div class="row" id="fila-producto">
                            <div class="col">
                                <input type="text" id="cliente" name="cliente" list="client-list" class="form-control">
                                <datalist id="client-list">
                                    <option value="Mostrador">
                                        @foreach ($clientes as $cliente)
                                    <option value="{{ $cliente->id }}-{{ $cliente->nombre }}">
                                        @endforeach
                                </datalist>
                            </div>

                        </div>
                        <br>

                    </div>
                </div>

                <div class="row">
                    <div class="col"><label for="fecha">Tipo de Precio:</label></div>
                    <div class="col"><input type="text" class="form-control" id="tipo" name = "tipo"
                            data-value="" value="" readonly></div>

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
                        <button type="submit" class="btn btn-success">Realizar Remisión</button>
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
                Swal.fire({
                    title: 'Productos',
                    html: `
                <label for="inputCantidad">Cantidad:</label>
                <input type="number" id="inputCantidad" class="form-control col-sm-14" >
                <br>
                <label for="inputWithDatalist">Selecciona un producto:</label>
                <input list="datalistOptions" id="inputWithDatalist" class="form-control col-sm-14">
                <datalist id="datalistOptions">
                    ${generateOptions()}
                </datalist>
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
                        const idcliente = obtenerNumerosHastaGuion($('#cliente').val());
                        var cantidad = $('#inputCantidad').val();
                        if (idcliente === "") {
                            idcliente = 1;
                        }

                        const data = {
                            id_producto: idproducto,
                            idcliente: idcliente,
                            cantidad: cantidad
                        };

                        $.ajax({
                            url: 'buscarprecio', // URL a la que se hace la solicitud
                            type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                            data: data,
                            dataType: 'json', // Tipo de datos esperados en la respuesta
                            headers: {
                                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                            },
                            success: function(data) {

                                agregarFila(data.idproducto, data.cantidad, data.subtotal, data.nombre,
                                    data.precio);
                            },
                            error: function(xhr, status, error) {
                                console.error(error); // Manejar errores de la solicitud
                            }
                        });

                        Swal.fire({
                            title: 'Has seleccionado:',
                            text: result.value.producto,
                            icon: 'success'
                        });
                    }
                });
            }
        }

        // Función para generar las opciones del datalist
        function generateOptions() {
            var options = @json($productos);
            var dataList = '';
            options.forEach(function(item) {
                dataList += `<option value="${item.id}-${item.nombre}">`;
            });
            return dataList;
        }

        // Función para obtener números hasta el guion
        function obtenerNumerosHastaGuion(text) {
            return text.split('-')[0];
        }


        function eliminarFila(elemento) {
            elemento.remove();
        }

        function obtenerNumerosHastaGuion(cadena) {
            // Buscar la posición del guion medio en la cadena
            const indiceGuion = cadena.indexOf('-');

            // Si no hay guion en la cadena, retornar null o algún valor indicando la ausencia del guion
            if (indiceGuion === -1) {
                return null; // o puedes retornar una cadena vacía o un valor que desees
            }

            // Extraer la parte de la cadena hasta el guion (excluyendo el guion)
            const subcadena = cadena.substring(0, indiceGuion);

            // Usar una expresión regular para obtener solo los números de la subcadena
            const numeros = subcadena.match(/\d+/g);

            // Combinar los números en una sola cadena
            return numeros ? numeros.join('') : '';
        }

        function agregarFila(codigo, cantidad, subtotal, nombre, precio) {
            // Datos para la nueva fila


            // Crear la nueva fila
            var nuevaFila = `
                    <tr>
                        <td>${codigo}</td>
                        <td>${cantidad}</td>
                        <td>${nombre}</td>
                        <td>${precio}</td>
                        <td>${subtotal}</td>
                        <td><button class="btn btn-danger btn-sm eliminar-fila">Eliminar</button></td>
                    </tr>
                `;

            // Agregar la nueva fila a la tabla
            $('#productos tbody').append(nuevaFila);

            $('.eliminar-fila').off('click').on('click', function() {
                $(this).closest('tr').remove();
            });
        }

        $('#remisionar').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();
            var datos = [];
            var formData = new URLSearchParams(datosFormulario);
            for (const [key, value] of formData.entries()) {
                datos.push({
                    key: key,
                    value: value
                });
            }

            // Crear la tabla HTML
            var table = '<table style="width:100%; border: 1px solid black; border-collapse: collapse;">';
            table +=
                '<tr><th style="border: 1px solid black; padding: 8px;">Campo</th><th style="border: 1px solid black; padding: 8px;">Valor</th></tr>';
            datos.forEach(element => {
                table += '<tr><td style="border: 1px solid black; padding: 8px;">' + element.key +
                    '</td><td style="border: 1px solid black; padding: 8px;">' + element.value +
                    '</td></tr>';
            });
            table += '</table>';

            // Clonar la tabla con id="producto" y quitar la última columna
            var $productoTableClone = $('#productos').clone();
            $productoTableClone.find('tr').each(function() {
                $(this).find('td:last-child, th:last-child').remove();
            });

            // Calcular la suma de la última columna
            sum = 0;
            $productoTableClone.find('tr').each(function() {
                var $lastTd = $(this).find('td:last-child');
                if ($lastTd.length) {
                    var value = parseFloat($lastTd.text());
                    if (!isNaN(value)) {
                        sum += value;
                    }
                }
            });

            // Añadir una nueva fila al final de la tabla con la suma
            $productoTableClone.append('<tr><td colspan="' + ($productoTableClone.find('tr:first-child th').length -
                    1) +
                '" style="border: 1px solid black; padding: 8px;">Total</td><td style="border: 1px solid black; padding: 8px;">' +
                sum + '</td></tr>');



            // Obtener el HTML de la tabla modificada
            var productoTableHtml = $productoTableClone.prop('outerHTML');



            // Concatenar las tablas
            table += '<br>' + productoTableHtml;

            Swal.fire({
                title: '¡Se realizará una remisión con los siguientes datos!',
                html: table,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Remisionar',
                width: '80%'
            }).then((result) => {
                if (result.isConfirmed) {



                    Swal.fire({
                        title: '!Remisión realizada correctamente!',
                        text: 'Ticket No. ',
                        icon: 'success',
                        showCancelButton: true,
                        cancelButtonText: 'Cerrar',
                        confirmButtonText: 'Imprimir',
                    }).then((result) => {
                        if (result.isConfirmed) {

                            // Datos para el PDF
                            var nombreSucursal = $('#sucursal').val();
                            var numeroRemision = "123456789";
                            var fecha = $('#fecha').val();
                            const opciones = {
                                timeZone: 'America/Mexico_City',
                                hour12: false
                            };
                            var hora = new Date().toLocaleString('es-MX', opciones);
                            var nota = $('#nota').val();
                            var vendedor = $('#vendedor').val();
                            var cantidadTotalLetra = convertirNumeroALetras(sum);

                            // Crear el PDF
                            const {
                                jsPDF
                            } = window.jspdf;
                            const doc = new jsPDF();

                            doc.setFontSize(16);
                            doc.text('GRUPO PROGYMS', 10, 10);
                            doc.setFontSize(12);
                            doc.text(`SUCURSAL: ${nombreSucursal}`, 10, 20);
                            doc.text(`Remisión No.: ${numeroRemision}  ${fecha}`, 10, 30);
                            doc.text(`Nota: ${nota}`, 10, 40);
                            doc.text(`Almacen: ${nombreSucursal}`, 10, 50);
                            doc.text(`Vendedor: ${vendedor}`, 10, 60);

                            // Convertir la tabla HTML a un formato aceptable para jsPDF
                            var res = doc.autoTableHtmlToJson($productoTableClone[0]);
                            doc.autoTable(res.columns, res.data, {
                                startY: 70
                            });

                            doc.text(`${cantidadTotalLetra}`, 10, doc.autoTable.previous.finalY +
                                10);

                            doc.text(`${fecha} ${hora}`, 10, doc.autoTable.previous.finalY + 20);

                            doc.text(
                                'Para cambios y devoluciones, presentar el producto SIN ABRIR con su ticket de venta dentro de los primeros 5 dias habiles despues de la fecha de compra.',
                                10, doc.autoTable.previous.finalY + 30);

                            // Guardar el PDF
                            doc.save(`remision_${numeroRemision}.pdf`);
                            Swal.fire('Ticket impreso!', '', 'success');
                        } else if (result.isDenied) {
                            Swal.fire('Ticket no impreso', '', 'info');
                        }
                    });
                }
            });
        });

        $('#cliente').on('change', function() {
            var cliente = $(this).val();
            var idcliente = obtenerNumerosHastaGuion(cliente);

            // Hacer la llamada AJAX
            $.ajax({
                url: 'buscaridprecio', // Cambia esta URL a la correcta
                type: 'POST',
                data: {
                    idcliente: idcliente
                },
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    // Actualizar el valor del input #tipo con el valor recibido
                    if (response.nombreprecio == null) {
                        $('#tipo').val("Publico");
                    } else {
                        $('#tipo').val(response.nombreprecio);
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
