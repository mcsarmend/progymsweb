@extends('adminlte::page')

@section('title', 'Reportes de Lista de precios')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Reporte de Cuentas por Cobrar</h1>
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
                    <div class="container-fluid">
                        <h6>Cliente: <span id="nombreCliente"></span></h6>
                        <div class="row">
                            <div class="col-md-12">
                                <h6>Cuentas por Cobrar:</h6>
                                <table class="table table-sm" id="tablaCxC">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
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
                            <div class="col-md-12">
                                <h6>Pagos Realizados:</h6>
                                <table class="table table-sm" id="tablaPagos">
                                    <thead>
                                        <tr>
                                            <th>ID Pago</th>
                                            <th>Fecha</th>
                                            <th>Monto</th>
                                            <th>Método</th>
                                            <th>CxC Relacionada</th>
                                        </tr>
                                    </thead>
                                    <tbody id="cuerpoPagos">
                                        <!-- Aquí se cargarán los pagos -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
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

@stop

@section('js')
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();




        });
    </script>
@stop
