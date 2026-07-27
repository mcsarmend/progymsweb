@extends('adminlte::page')
@section('title', 'Reporte > Inventario > Corte de Caja')
@section('content_header')
@stop
@section('content')
    <div class="card">
        <div class="card-body">
            <div class="card">
                <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                    <h1 class="card-title" style="font-size: 2rem;">Reporte Sucursal</h1>
                </div>
                @if ($type != 4)
                    <div class="d-flex justify-content-center">
                        <form action="" method="post" class="text-center" id="infocortecaja">
                            <p class="text-center">Selecciona la sucursal y el período para realizar el corte</p>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="sucursal" class="form-label">Sucursal:</label>
                                    <select name="sucursal" id="sucursal" class="form-control">
                                        @foreach ($idssucursales as $almacen)
                                            <option value="{{ $almacen->id }}">{{ $almacen->nombre }}</option>
                                        @endforeach
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label for="fecha" class="form-label">Fecha:</label>
                                    <input type="date" name="fecha" id="fecha" class="form-control" required>
                                </div>

                            </div>

                            <button type="submit" class="btn btn-info">Obtener información</button>
                        </form>
                    </div>
                @endif
                <form id="cortecajaform">

                    <div class="card-body">
                        <div>
                            <h3>Total General</h3>
                            <p style="background-color: #d4edda; color: #155724; padding: 10px; text-align: center;"
                                id="total-general">
                                <strong>$0.00</strong>
                            </p>

                            <h3>Total en efectivo a entregar</h3>
                            <p style="background-color: #d4edda; color: #155724; padding: 10px; text-align: center;"
                                id="total-efectivo-entregar">
                                <strong>$0.00</strong>
                            </p>

                            <hr style="border: 1px solid #000;">

                            <!-- REMESA RECIBIDA (Suma al efectivo a entregar) -->
                            <div class="concept-container" id="remesa-recibida-container">
                                <div class="concept-header">REMESA RECIBIDA (Suma al efectivo a entregar)</div>
                                <div class="inputs-container" id="remesa-recibida-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('remesa-recibida-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- REMESA ENTREGADA (Resta al efectivo a entregar) -->
                            <div class="concept-container" id="remesa-entregada-container">
                                <div class="concept-header">REMESA ENTREGADA (Resta al efectivo a entregar)</div>
                                <div class="inputs-container" id="remesa-entregada-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('remesa-entregada-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- OTRAS VENTAS (Suma al efectivo a entregar) -->
                            <div class="concept-container" id="otras-ventas-container">
                                <div class="concept-header">OTRAS VENTAS (Suma al efectivo a entregar)</div>
                                <div class="inputs-container" id="otras-ventas-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('otras-ventas-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- GASTOS EN GENERAL (Resta al efectivo a entregar) -->
                            <div class="concept-container" id="gastos-en-general-container">
                                <div class="concept-header">GASTOS EN GENERAL (Resta al efectivo a entregar)</div>
                                <div class="inputs-container" id="gastos-en-general-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('gastos-en-general-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- EFECTIVO POR DOBLE FORMA DE PAGO (Suma al efectivo a entregar) -->
                            <div class="concept-container" id="efectivo-doble-forma-pago-container">
                                <div class="concept-header">EFECTIVO POR DOBLE FORMA DE PAGO (Suma al efectivo a entregar)
                                </div>
                                <div class="inputs-container" id="efectivo-doble-forma-pago-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('efectivo-doble-forma-pago-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- SALDO A FAVOR (Suma al efectivo a entregar) -->
                            <div class="concept-container" id="saldo-favor-container">
                                <div class="concept-header">SALDO A FAVOR (Suma al efectivo a entregar)</div>
                                <div class="inputs-container" id="saldo-favor-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('saldo-favor-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- CUENTAS POR PAGAR (Resta al efectivo a entregar) -->
                            <div class="concept-container" id="cuentas-por-pagar-container">
                                <div class="concept-header">CUENTAS POR PAGAR (Resta al efectivo a entregar)</div>
                                <div class="inputs-container" id="cuentas-por-pagar-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('cuentas-por-pagar-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- ABONO EFECTIVO CxC (Suma al efectivo a entregar) -->
                            <div class="concept-container" id="abono-efectivo-cxc-container">
                                <div class="concept-header">ABONO EFECTIVO CxC (Suma al efectivo a entregar)</div>
                                <div class="inputs-container" id="abono-efectivo-cxc-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('abono-efectivo-cxc-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- ABONO CxC TRANSFERENCIA/TERMINAL (No suma ni resta) -->
                            <div class="concept-container" id="abono-cxc-transferencia-terminal-container">
                                <div class="concept-header">ABONO CxC TRANSFERENCIA/TERMINAL (No suma ni resta)</div>
                                <div class="inputs-container" id="abono-cxc-transferencia-terminal-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('abono-cxc-transferencia-terminal-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">

                            <!-- CUENTAS POR COBRAR (Resta al efectivo a entregar) -->
                            <div class="concept-container" id="cuentas-por-cobrar-container">
                                <div class="concept-header">CUENTAS POR COBRAR (Resta al efectivo a entregar)</div>
                                <div class="inputs-container" id="cuentas-por-cobrar-inputs"></div>
                                <button type="button" class="add-button"
                                    onclick="addInput('cuentas-por-cobrar-inputs')">Agregar</button>
                            </div>
                            <hr style="border: 1px solid #000;">
                        </div>

                        <div id="contenido-corte">
                            @foreach ($remisiones_por_pago as $forma_pago => $remisiones)
                                @php
                                    if ($forma_pago === '') {
                                        continue;
                                    }
                                    $remisiones_por_pago = $remisiones_por_pago ?? [];
                                    $totales_por_pago = $totales_por_pago ?? [];
                                    $total_general = $total_general ?? array_sum($totales_por_pago);
                                @endphp

                                @if (!empty($totales_por_pago[$forma_pago]))
                                    <h3>Forma de Pago: {{ ucfirst($forma_pago) }}</h3>
                                    <table border="1" style="width: 100%; border-collapse: collapse;">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Fecha</th>
                                                <th>Cliente</th>
                                                <th>Total</th>
                                                <th>Vendedor</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @forelse($remisiones as $remision)
                                                <tr>
                                                    <td>{{ $remision->id }}</td>
                                                    <td>{{ $remision->fecha }}</td>
                                                    <td>{{ $remision->cliente }}</td>
                                                    <td>${{ number_format($remision->total, 2) }}</td>
                                                    <td>{{ $remision->vendedor }}</td>
                                                </tr>
                                            @empty
                                                <tr>
                                                    <td colspan="5" style="text-align: center;">
                                                        Sin datos para esta forma de pago
                                                    </td>
                                                </tr>
                                            @endforelse
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3"><strong>Total por {{ ucfirst($forma_pago) }}</strong>
                                                </td>
                                                <td colspan="2"
                                                    style="background-color:#d4edda; color:#155724; text-align:center;">
                                                    <strong>${{ number_format($totales_por_pago[$forma_pago], 2) }}</strong>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                @endif
                            @endforeach
                        </div>

                        <div class="col"><label for="observaciones">Observaciones:</label></div>
                        <div class="col">
                            <textarea id="observaciones" name="observaciones" rows="3" cols="120"
                                placeholder="Escribe tu texto aquí..." data-value="" value=""></textarea>
                        </div>
                        <br>

                        <button type="button" class="btn btn-primary" onclick="sendDataAsJson()">Realizar corte</button>
                </form>
            </div>
        </div>
    </div>
    </div>
    @include('fondo')
@stop

@section('css')
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 10px;
            vertical-align: top;
        }

        th {
            text-align: center;
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .concept-container {
            margin-bottom: 20px;
        }

        .concept-header {
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }

        .inputs-container {
            margin-top: 10px;
        }

        .add-button {
            margin-top: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

        .add-button:hover {
            background-color: #218838;
        }

        .input-group {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .input-group input {
            margin-right: 10px;
            flex: 1;
        }

        .remove-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 3px 8px;
            cursor: pointer;
            margin-left: 10px;
        }

        .remove-button:hover {
            background-color: #c82333;
        }
    </style>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
            calculateTotals();
            document.querySelectorAll('.concept-container input[type="number"]').forEach(input => {
                input.addEventListener('input', calculateTotals);
            });

            $('#cortecajaform').submit(function(e) {
                e.preventDefault();
                var datosFormulario = $(this).serialize();
                $.ajax({
                    url: '/enviarcortecaja',
                    type: 'POST',
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

            $('#infocortecaja').submit(function(e) {
                e.preventDefault();
                $.ajax({
                    url: '/infocortecaja',
                    type: 'POST',
                    data: $(this).serialize(),
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        $('#contenido-corte').html(response.html);
                        recalcular();
                    },
                    error: function(response) {
                        Swal.fire("Error", "No se pudo obtener la información.", "error");
                    }
                });
            });
        });

        function sendDataAsJson() {
            let data = {
                total_general: parseFloat($("#total-general").text().replace("$", "").trim()) || 0,
                total_efectivo_entregar: parseFloat($("#total-efectivo-entregar").text().replace("$", "").trim()) || 0,
                inputs_adicionales: {},
                formas_pago: [],
                observaciones: $("#observaciones").val() || "Sin Observaciones",
                fecha: $('#fecha').val() || null
            };

            $(".concept-container").each(function() {
                let conceptId = $(this).attr('id').replace('-container', '');
                let inputs = [];
                $(this).find(".inputs-container input").each(function() {
                    valor = $(this).val()
                    if ($.isNumeric(valor)) {
                        inputs.push(parseFloat($(this).val()) || 0);
                    } else {
                        inputs.push($(this).val() || "Sin Concepto");
                    }
                });
                data.inputs_adicionales[conceptId] = inputs;
            });

            $("h3:contains('Forma de Pago:')").each(function() {
                let formaPago = $(this).text().replace("Forma de Pago: ", "").trim();
                let tabla = $(this).next("table");
                let totalTexto = tabla.find("tfoot td strong").text().trim();
                let totalFormaPago = parseFloat(totalTexto.replace(/[^\d.]/g, '')) || 0;
                let remisiones = [];
                $(this).next("table").find("tbody tr").each(function() {
                    let celdas = $(this).find("td");
                    remisiones.push({
                        id: $(celdas[0]).text().trim(),
                        fecha: $(celdas[1]).text().trim(),
                        cliente: $(celdas[2]).text().trim(),
                        total: parseFloat($(celdas[3]).text().replace(/[^0-9.]/g, "")),
                        vendedor: $(celdas[4]).text().trim()
                    });
                });
                data.formas_pago.push({
                    forma_pago: formaPago,
                    remisiones: remisiones,
                    total: totalFormaPago
                });
            });

            var type = parseInt(@json($type));
            if (type != 4) {
                sucursal = $('#sucursal').val();
                data.sucursal = sucursal;
            }

            $.ajax({
                url: '/enviarinfocortecaja',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
                },
                success: function(response) {
                    Swal.fire(
                        '¡Datos enviados!',
                        'Se ha procesado correctamente la información.',
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
        }

        function addInput(containerId) {
            var type = parseInt(@json($type));
            const container = document.getElementById(containerId);
            const inputGroup = document.createElement('div');
            inputGroup.classList.add('input-group');

            const montoInput = document.createElement('input');
            montoInput.type = 'number';
            montoInput.placeholder = 'Monto';
            montoInput.required = true;
            if (type != 4) {
                montoInput.addEventListener('input', recalcular);
            } else {
                montoInput.addEventListener('input', calculateTotals);
            }

            const conceptoInput = document.createElement('input');
            conceptoInput.type = 'text';
            conceptoInput.placeholder = 'Concepto';
            conceptoInput.required = true;

            const removeButton = document.createElement('button');
            removeButton.textContent = 'Eliminar';
            removeButton.classList.add('remove-button');
            removeButton.onclick = function() {
                container.removeChild(inputGroup);
                if (type != 4) {
                    recalcular()
                } else {
                    calculateTotals();
                }
            };

            inputGroup.appendChild(montoInput);
            inputGroup.appendChild(conceptoInput);
            inputGroup.appendChild(removeButton);
            container.appendChild(inputGroup);

            if (type != 4) {
                recalcular();
            } else {
                calculateTotals();
            }
        }

        function calculateTotals() {
            let totalGeneral = 0;
            let totalEfectivo = 0;

            let remesaRecibida = sumContainerInputs('remesa-recibida-container');
            let remesaEntregada = sumContainerInputs('remesa-entregada-container');
            let otrasVentas = sumContainerInputs('otras-ventas-container');
            let gastosEnGeneral = sumContainerInputs('gastos-en-general-container');
            let efectivoDobleFormaPago = sumContainerInputs('efectivo-doble-forma-pago-container');
            let saldoFavor = sumContainerInputs('saldo-favor-container');
            let cuentasPorPagar = sumContainerInputs('cuentas-por-pagar-container');
            let abonoEfectivoCxC = sumContainerInputs('abono-efectivo-cxc-container');
            let abonoCxCTransferenciaTerminal = sumContainerInputs('abono-cxc-transferencia-terminal-container');
            let cuentasPorCobrar = sumContainerInputs('cuentas-por-cobrar-container');

            let totalPorEfectivo = parseFloat('{{ $totales_por_pago['efectivo'] ?? 0 }}');
            let totalPorTransferencia = parseFloat('{{ $totales_por_pago['transferencia'] ?? 0 }}');
            let totalPorTerminal = parseFloat('{{ $totales_por_pago['terminal'] ?? 0 }}');
            let totalPorClip = parseFloat('{{ $totales_por_pago['clip'] ?? 0 }}');
            let totalPorMercadoPago = parseFloat('{{ $totales_por_pago['mercado_pago'] ?? 0 }}');
            let totalPorVales = parseFloat('{{ $totales_por_pago['vales'] ?? 0 }}');

            let totalElectronico = totalPorTransferencia + totalPorTerminal + totalPorClip + totalPorMercadoPago +
                totalPorVales;

            totalGeneral = totalPorEfectivo + totalElectronico;

            // Cálculo del total efectivo a entregar
            totalEfectivo = totalPorEfectivo +
                remesaRecibida +
                otrasVentas +
                efectivoDobleFormaPago +
                saldoFavor +
                abonoEfectivoCxC -
                remesaEntregada -
                gastosEnGeneral -
                cuentasPorPagar -
                cuentasPorCobrar;

            // abonoCxCTransferenciaTerminal no afecta el total (ni suma ni resta)

            document.getElementById('total-general').textContent = `$${totalGeneral.toFixed(2)}`;
            document.getElementById('total-efectivo-entregar').textContent = `$${totalEfectivo.toFixed(2)}`;
        }

        function sumContainerInputs(containerId) {
            let total = 0;
            document.querySelectorAll(`#${containerId} .input-group input[type="number"]`).forEach(input => {
                total += parseFloat(input.value) || 0;
            });
            return total;
        }

        function recalcular() {
            let totalGeneral = 0;
            let totalEfectivo = 0;

            let remesaRecibida = sumContainerInputs('remesa-recibida-container');
            let remesaEntregada = sumContainerInputs('remesa-entregada-container');
            let otrasVentas = sumContainerInputs('otras-ventas-container');
            let gastosEnGeneral = sumContainerInputs('gastos-en-general-container');
            let efectivoDobleFormaPago = sumContainerInputs('efectivo-doble-forma-pago-container');
            let saldoFavor = sumContainerInputs('saldo-favor-container');
            let cuentasPorPagar = sumContainerInputs('cuentas-por-pagar-container');
            let abonoEfectivoCxC = sumContainerInputs('abono-efectivo-cxc-container');
            let abonoCxCTransferenciaTerminal = sumContainerInputs('abono-cxc-transferencia-terminal-container');
            let cuentasPorCobrar = sumContainerInputs('cuentas-por-cobrar-container');

            let totalPorEfectivo = 0;
            let totalPorTransferencia = 0;
            let totalPorTerminal = 0;
            let totalPorClip = 0;
            let totalPorMercadoPago = 0;
            let totalPorVales = 0;

            document.querySelectorAll("table").forEach(table => {
                let titleElement = table.previousElementSibling;
                if (!titleElement || !titleElement.textContent.includes("Forma de Pago:")) return;

                let formaPago = titleElement.textContent.replace("Forma de Pago: ", "").trim().toLowerCase();

                let totalPago = 0;
                table.querySelectorAll("tbody tr").forEach(row => {
                    let td = row.querySelector("td:nth-child(4)");
                    if (td) {
                        let valor = parseFloat(td.textContent.replace(/[^0-9.-]/g, '')) || 0;
                        totalPago += valor;
                    }
                });

                if (formaPago === "efectivo") totalPorEfectivo += totalPago;
                if (formaPago === "transferencia") totalPorTransferencia += totalPago;
                if (formaPago === "terminal") totalPorTerminal += totalPago;
                if (formaPago === "clip") totalPorClip += totalPago;
                if (formaPago === "mercado_pago") totalPorMercadoPago += totalPago;
                if (formaPago === "vales") totalPorVales += totalPago;
            });

            let totalElectronico = totalPorTransferencia + totalPorTerminal + totalPorClip + totalPorMercadoPago +
                totalPorVales;
            totalGeneral = totalPorEfectivo + totalElectronico;

            // Cálculo del total efectivo a entregar con todos los conceptos
            totalEfectivo = totalPorEfectivo +
                remesaRecibida +
                otrasVentas +
                efectivoDobleFormaPago +
                saldoFavor +
                abonoEfectivoCxC -
                remesaEntregada -
                gastosEnGeneral -
                cuentasPorPagar -
                cuentasPorCobrar;

            document.getElementById('total-general').textContent = `$${totalGeneral.toFixed(2)}`;
            document.getElementById('total-efectivo-entregar').textContent = `$${totalEfectivo.toFixed(2)}`;
        }
    </script>
@stop
