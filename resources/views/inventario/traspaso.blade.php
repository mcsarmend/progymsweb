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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
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

            if ($('#almacen_origen').val() == "" || $('#almacen_destino').val() == "") {
                Swal.fire({
                    title: '¡No has indicado almacenes!',
                    icon: 'warning'
                });
                return;
            }
            generateOptions().then(optionsHtml => {

                Swal.fire({
                    title: 'Productos',
                    html: `
                    <label for="inputWithDatalist">Selecciona un producto:</label>
                    <input list="datalistOptions" id="inputWithDatalist" class="form-control col-sm-14" oninput="actualizarExistencias()">
                    <datalist id="datalistOptions">
                       ${optionsHtml}
                    </datalist>
                    <label for="inputCantidad">Cantidad:</label>
                    <input type="number" id="inputCantidad" class="form-control col-sm-14">
                    <label for="inputExistencias">Existencias:</label>
                    <input type="number" id="inputExistencias" class="form-control col-sm-14" readonly>
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

                        if ($('#inputCantidad').val() > $('#inputExistencias').val()) {
                            Swal.fire({
                                title: '¡Debes ingresar una cantidad menor o igual a las existencias!',
                                icon: 'warning'
                            });
                            return;
                        }

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
                                agregarFila(data.idproducto, data.cantidad, data.nombre, data
                                    .costo);
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

        function generateOptions() {
            return new Promise((resolve, reject) => {
                var sucursal = $('#almacen_origen').val();

                $.ajax({
                    url: 'productosinventario',
                    type: 'POST',
                    data: {
                        sucursal: sucursal
                    },
                    dataType: 'json',
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        var dataList = '';
                        response.productos.forEach(function(item) {
                            dataList +=
                                `<option value="${item.id}-${item.nombre} - ${item.nombre_marca}">`;
                        });
                        resolve(dataList);
                    },
                    error: function(xhr, status, error) {
                        console.error(error);
                        reject(error);
                    }
                });
            });
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

                    numeroRemision = enviartraspaso("TRANSFER", datos, documento, sum,
                        almacen_origen,
                        almacen_destino);

                }
            });
        });

        function actualizarExistencias() {
            const productoInput = document.getElementById('inputWithDatalist');
            const idProducto = obtenerNumerosHastaGuion(productoInput.value); // Usa tu función existente

            if (!idProducto) return; // Si no hay ID válido, no hacer nada
            const idsucursal = $('#almacen_origen').val();

            const data = {
                id_producto: idProducto,
                sucursal: idsucursal,

            };

            $.ajax({
                url: 'buscarexistencias', // URL a la que se hace la solicitud
                type: 'POST', // Tipo de solicitud (GET, POST, etc.)
                data: data,
                dataType: 'json', // Tipo de datos esperados en la respuesta
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(data) {

                    $('#inputExistencias').val(data.existencias);


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
                success: function(data) {
                    msg = data.message + ": " + data.id;
                    numeroRemision = data.id;
                    Swal.fire({
                        title: "Gracias por esperar, el traspaso se realizo con exito",
                        icon: 'success',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Imprimir',
                        width: '80%'
                    }).then((result) => {
                        if (result.isConfirmed) {


                            // Crear el documento PDF
                            var {
                                jsPDF
                            } = window.jspdf;
                            var doc = new jsPDF({
                                orientation: "portrait",
                                unit: "mm",
                                format: [297, 210],
                            });
                            var opciones = {
                                timeZone: "America/Mexico_City",
                                hour12: false,
                            };
                            var documento = $("#documento").val();
                            var time = new Date().toLocaleString("es-MX", opciones);
                            var alm_origen = $('#almacen_origen option:selected').text()
                                .trim();
                            var alm_destino = $('#almacen_destino option:selected').text()
                                .trim();
                            // Agregar contenido al PDF
                            doc.setFontSize(12);
                            doc.setFont("helvetica", "bold");
                            doc.text("GRUPO PROGYMS", 30, 10);
                            doc.text(`Documento: ${documento}`, 10, 22);
                            doc.text(`Fecha: ${time}`, 10, 27);
                            doc.text(`Almacén Origen: ${alm_origen}`, 10, 31);
                            doc.text(`Almacén Destino: ${alm_destino}`, 10, 35);

                            var $productoTableClone2 = $("#productos").clone();
                            // Convertir la tabla HTML a un formato aceptable para jsPDF
                            var res = doc.autoTableHtmlToJson($productoTableClone2[0]);
                            // Eliminar la última columna de cada fila (contenido)
                            res.data = res.data.map((row) => {
                                row.pop();
                                return row;
                            });

                            // Eliminar el encabezado de la última columna (si aplica)
                            res.columns.pop();

                            doc.autoTable({
                                startY: 47, // Empieza después del texto introductorio
                                tableWidth: 'wrap', // Ajuste automático al ancho disponible
                                margin: {
                                    left: 5,
                                    right: 5,
                                }, // Márgenes mínimos
                                head: [res.columns], // Encabezados
                                body: res.data, // Datos
                                styles: {
                                    fontSize: 10, // Reducir tamaño de fuente para que quepa más contenido
                                    fontStyle: "bold",
                                    overflow: 'linebreak', // Permite que el texto largo se ajuste en varias líneas
                                },
                                columnStyles: {
                                    0: {
                                        cellWidth: 30, // Reducir el ancho de la primera columna
                                    },
                                    1: {
                                        cellWidth: 20, // Reducir el ancho de la segunda columna
                                    },
                                    2: {
                                        cellWidth: 100, // Ajustar ancho de la tercera columna
                                    },
                                    3: {
                                        cellWidth: 20, // Reducir el ancho de la cuarta columna
                                    },
                                    4: {
                                        cellWidth: 18, // Reducir el ancho de la quinta columna
                                    },
                                },
                                headStyles: {
                                    fillColor: null,
                                    textColor: 0,
                                },
                                bodyStyles: {
                                    fillColor: "#FFFFFF",
                                    textColor: 0,
                                },
                                // Opción para manejar varias páginas si la tabla es demasiado grande
                                pageBreak: 'auto', // La tabla se ajusta automáticamente a varias páginas
                            });


                            // Guardar y mostrar el PDF
                            doc.save(`traspaso_${documento}.pdf`);
                            Swal.fire("traspaso impreso!", "", "success");

                        } else {
                            setTimeout(function() {
                                window.location.reload();
                            }, 3000);
                        }
                    });
                },

                error: function(xhr, status, error) {
                    Swal.fire({
                        title: 'Error:',
                        text: xxhr.responseJSON.message,
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


        function generarPDF() {
            var {
                jsPDF
            } = window.jspdf;
            var doc = new jsPDF({
                orientation: "portrait",
                unit: "mm",
                format: [297, 210],
            });
            var opciones = {
                timeZone: "America/Mexico_City",
                hour12: false,
            };
            var documento = $("#documento").val();
            var time = new Date().toLocaleString("es-MX", opciones);
            var alm_origen = $('#almacen_origen option:selected').text().trim();
            var alm_destino = $('#almacen_destino option:selected').text().trim();

            // Agregar contenido al PDF
            doc.setFontSize(12);
            doc.setFont("helvetica", "bold");
            doc.text("GRUPO PROGYMS", 30, 10);
            doc.text(`Documento: ${documento}`, 10, 22);
            doc.text(`Fecha: ${time}`, 10, 27);
            doc.text(`Almacén Origen: ${alm_origen}`, 10, 31);
            doc.text(`Almacén Destino: ${alm_destino}`, 10, 35);

            var $productoTableClone2 = $("#productos").clone();
            var res = doc.autoTableHtmlToJson($productoTableClone2[0]);
            res.data = res.data.map((row) => {
                row.pop();
                return row;
            });
            res.columns.pop();

            doc.autoTable({
                startY: 47,
                tableWidth: 'wrap',
                margin: {
                    left: 5,
                    right: 5
                },
                head: [res.columns],
                body: res.data,
                styles: {
                    fontSize: 10,
                    fontStyle: "bold",
                    overflow: 'linebreak',
                },
                columnStyles: {
                    0: {
                        cellWidth: 30
                    },
                    1: {
                        cellWidth: 20
                    },
                    2: {
                        cellWidth: 100
                    },
                    3: {
                        cellWidth: 20
                    },
                    4: {
                        cellWidth: 18
                    },
                },
                headStyles: {
                    fillColor: null,
                    textColor: 0,
                },
                bodyStyles: {
                    fillColor: "#FFFFFF",
                    textColor: 0,
                },
                pageBreak: 'auto',
            });

            doc.save(`traspaso_${documento}.pdf`);
            Swal.fire("traspaso impreso!", "", "success");
        }
    </script>
@stop
