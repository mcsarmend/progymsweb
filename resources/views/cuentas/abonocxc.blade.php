@extends('adminlte::page')

@section('title', 'Abono Cuentas por cobrar')

@section('content_header')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.13/jspdf.plugin.autotable.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Abono por cobrar Cliente</h2>
        </div>
        <div class="card-body">


            <form id="abonocxc">
                <!-- Buscador de remisión -->
                <div class="row mb-4">
                    <div class="col-md-9">
                        <div class="input-group">
                            <input type="text" class="form-control form-control-lg" id="buscar_remision"
                                placeholder="Ingrese número de remisión">
                            <button class="btn btn-primary" type="button" id="btn-buscar-remision">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </div>
                </div>
                <hr>
                <!-- Primera fila de campos -->

                <h2>Información de la remisión</h2>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="vendedor">Vendedor:</label>
                            <input type="text" class="form-control" id="vendedor" name="vendedor" readonly>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="sucursal">Sucursal:</label>

                            <input type="text" class="form-control" id="sucursal" name="sucursal" readonly>

                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="fecha">Fecha:</label>
                            <input type="date" class="form-control" id="fecha" name="fecha" readonly>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="tipo">Tipo de Precio:</label>
                            <input type="text" class="form-control" id="tipo" name="tipo" readonly>
                        </div>
                    </div>



                    <br>
                    <br>

                </div>

                <div class="row mt-4">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="cliente">Cliente:</label>
                            <input type="text" class="form-control" id="cliente" name="cliente" readonly>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="total">Total:</label>
                            <input type="text" class="form-control" id="total" name="total" readonly>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="restante">Restante:</label>
                            <input type="text" class="form-control" id="restante" name="restante" readonly>
                        </div>
                    </div>

                </div>


                <!-- Tabla de productos -->
                <div class="row mt-4">
                    <div class="col-md-12">
                        <table id="productos" class="table table-bordered table-striped">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Código</th>
                                    <th>Cantidad</th>
                                    <th>Nombre</th>
                                    <th>Precio Unitario</th>
                                    <th>Subtotal</th>

                                </tr>
                            </thead>
                            <tbody>
                                <!-- Los productos se agregarán aquí dinámicamente -->
                            </tbody>
                        </table>
                    </div>
                </div>
                <hr>

                <br>



                <!-- Botón de submit -->
                <h3>Información para la Cuenta por Cobrar</h3>
                <div class="row mt-4">

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="abono">Cantidad Abonada:</label>
                            <input type="number" class="form-control" id="abono" name="abono">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="metodo_pago">Método de pago:</label>
                            <select name="metodo_pago" id="metodo_pago" class="form-control">
                                <option value="efectivo">Efectivo</option>
                                <option value="transferencia">Transferencia</option>
                                <option value="terminal">Terminal</option>
                                <option value="clip">Clip</option>
                                <option value="mercado_pago">Mercado Pago</option>
                                <option value="vales">Vales</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class=""></i> Abonar a Cuenta
                        </button>
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
            $('#btn-buscar-remision').click(function() {
                event.preventDefault();
                const numeroRemision = $('#buscar_remision').val().trim();

                if (!numeroRemision) {
                    Swal.fire('Error', 'Por favor ingrese un número de remisión válido', 'error');
                    return;
                }

                Swal.fire({
                    title: 'Buscando remisión',
                    html: 'Por favor espere...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });

                $.ajax({
                    url: '/buscarremision',
                    type: 'GET',
                    data: {
                        numero_remision: numeroRemision
                    },
                    dataType: 'json',
                    success: function(response) {
                        Swal.close();

                        if (response.success) {
                            // Llenar campos principales
                            $('#vendedor').val(response.data.data.vendedor);
                            $('#sucursal').val(response.data.data.almacen);
                            soloFecha = response.data.data.fecha.split(' ')[0];
                            $('#fecha').val(soloFecha);
                            $('#tipo').val(response.data.data.tipo_de_precio || '');
                            $('#cliente').val(response.data.data.cliente || '');
                            $('#total').val(response.data.data.total || '');

                            restante = '';
                            if (response.data.data.cxc == null) {
                                restante = '0';
                                $('#restante').val(response.data.data.total || '');
                            } else {

                            }


                            // Limpiar y llenar tabla de productos
                            $('#productos tbody').empty();
                            if (response.data.data.productos && response.data.data.productos
                                .length > 0) {
                                response.data.data.productos.forEach(producto => {
                                    $('#productos tbody').append(`
                                <tr>
                                    <td>${producto.Codigo}</td>
                                    <td>${producto.Cantidad}</td>
                                    <td>${producto.Nombre}</td>
                                    <td>$${parseFloat(producto["Precio Unitario"]).toFixed(2)}</td>
                                    <td>$${parseFloat(producto.Subtotal).toFixed(2)}</td>

                                </tr>
                            `);
                                });
                            }

                            Swal.fire('Éxito', 'Remisión cargada correctamente', 'success');
                        } else {
                            Swal.fire('Error', response.message || 'No se encontró la remisión',
                                'error');
                        }
                    },
                    error: function(xhr) {
                        Swal.close();
                        let errorMsg = 'Error al buscar la remisión';
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMsg = xhr.responseJSON.message;
                        }
                        Swal.fire('Error', errorMsg, 'error');
                    }
                });
            });

            // Opcional: Buscar al presionar Enter

        });

        $('#buscar_remision').keypress(function(e) {
            if (e.which == 13) { // 13 es el código de la tecla Enter
                e
                    .preventDefault(); // Solo previene el comportamiento por defecto del Enter (evita un posible submit del formulario)
                $('#btn-buscar-remision').click(); // Dispara el evento de búsqueda
            }
        });

        $('#abonocxc').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();

            // Realizar la solicitud AJAX con jQuery
            $.ajax({
                url: '/abonocxcevento', // Ruta al controlador de Laravel
                type: 'POST',
                // data: datosFormulario, // Enviar los datos del formulario
                data: datosFormulario,
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
                        "Existe un error: " + response.message,
                        'error'
                    )
                }
            });
        });
    </script>
@stop
