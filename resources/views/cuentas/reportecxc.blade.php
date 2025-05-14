@extends('adminlte::page')

@section('title', 'Reporte de Cuentas por Cobrar')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h3>Listado de Cuentas por Cobrar</h3>
        </div>
        <div class="card-body">
            <table class="table table-hover" id="cxc_tabla">
                <thead>
                    <tr>
                        <th>Cliente</th>
                        <th>Saldo total</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($clientesConSaldo as $cliente)
                        <tr>
                            <td>{{ $cliente->nombre }}</td>
                            <td>${{ number_format($cliente->saldo_total, 2) }}</td>
                            <td>
                                <button class="btn btn-primary btn-detalle" data-cliente-id="{{ $cliente->id }}"
                                    data-toggle="modal" data-target="#detalleModal">
                                    Ver Detalle
                                </button>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal de Detalle -->
    <div class="modal fade" id="detalleModal" tabindex="-1" role="dialog" aria-labelledby="detalleModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detalleModalLabel">Detalle de Cuentas por Cobrar</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h6>Cliente: <span id="nombreCliente"></span></h6>
                    <div class="table-responsive">
                        <h6>Cuentas por Cobrar:</h6>
                        <table class="table table-sm" id="tablaCxC">
                            <thead>
                                <tr>
                                    <th>Remision</th>
                                    <th>Fecha</th>
                                    <th>Monto</th>
                                    <th>Saldo</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody id="cuerpoCxC">
                                <!-- Aquí se cargarán las cuentas por cobrar -->
                            </tbody>
                        </table>
                    </div>
                    <div class="table-responsive">
                        <h6>Pagos Realizados:</h6>
                        <table class="table table-sm" id="tablaPagos">
                            <thead>
                                <tr>
                                    <th>ID Pago</th>
                                    <th>Fecha</th>
                                    <th>Monto</th>
                                    <th>Método</th>
                                    <th>Remision Relacionada</th>
                                </tr>
                            </thead>
                            <tbody id="cuerpoPagos">
                                <!-- Aquí se cargarán los pagos -->
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
        @include('fondo')
@stop

@section('css')
    {{-- Agregar estilos de DataTable si es necesario --}}
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
@stop

@section('js')
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {

            drawTriangles();
            showUsersSections();

            // Inicializar DataTable para la tabla principal
            $('#cxc_tabla').DataTable({
                language: {
                    url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-MX.json"
                }
            });

            // Manejar el click en el botón de detalle
            $(document).on('click', '.btn-detalle', function() {
                var clienteId = $(this).data('cliente-id');
                var clienteNombre = $(this).closest('tr').find('td:first').text();

                // Mostrar nombre del cliente en el modal
                $('#nombreCliente').text(clienteNombre);

                // Limpiar tablas anteriores
                $('#cuerpoCxC').empty();
                $('#cuerpoPagos').empty();

                // Obtener y mostrar las cuentas por cobrar
                $.get('/obtener-cxc/' + clienteId, function(data) {
                    data.cuentas.forEach(function(cuenta) {
                        $('#cuerpoCxC').append(`
                            <tr>
                                <td>${cuenta.remision_id}</td>
                                <td>${cuenta.fecha}</td>
                                <td>$${parseFloat(cuenta.monto).toFixed(2)}</td>
                                <td>$${parseFloat(cuenta.saldo_restante).toFixed(2)}</td>
                                <td>${cuenta.estado}</td>
                            </tr>
                        `);
                    });

                    // Obtener y mostrar los pagos
                    $.get('/obtener-pagos/' + clienteId, function(pagos) {
                        pagos.forEach(function(pago) {
                            $('#cuerpoPagos').append(`
                                <tr>
                                    <td>${pago.id}</td>
                                    <td>${pago.fecha}</td>
                                    <td>$${parseFloat(pago.monto).toFixed(2)}</td>
                                    <td>${pago.metodo_pago}</td>
                                    <td>${pago.remision_id}</td>
                                </tr>
                            `);
                        });
                    });
                });
            });
        });
    </script>
@stop
