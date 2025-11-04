@foreach ($remisiones_por_pago as $forma_pago => $remisiones)
    @if ($totales_por_pago[$forma_pago] > 0)
        <h3>Forma de Pago: {{ ucfirst($forma_pago) }}</h3>

        <table class="table table-bordered">
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
                @foreach($remisiones as $r)
                    <tr>
                        <td>{{ $r->id }}</td>
                        <td>{{ $r->fecha }}</td>
                        <td>{{ $r->cliente }}</td>
                        <td>${{ number_format($r->total, 2) }}</td>
                        <td>{{ $r->vendedor }}</td>
                    </tr>
                @endforeach
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3"><strong>Total {{ ucfirst($forma_pago) }}</strong></td>
                    <td colspan="2"><strong>${{ number_format($totales_por_pago[$forma_pago], 2) }}</strong></td>
                </tr>
            </tfoot>
        </table>
        <br>
    @endif
@endforeach
