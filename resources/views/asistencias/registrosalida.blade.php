@extends('adminlte::page')

@section('title', 'Registro Salida')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Registro Salida</h1>
        </div>
        <div class="card-body">
            <button id="register_entrance" class="btn btn-success">Registrar Salida</button>
        </div>


    </div>
    @include('fondo')
@stop

@section('css')
@stop

@section('js')
    <script>
        function getDeviceInfo() {
            const deviceInfo = {
                userAgent: navigator.userAgent,
                platform: navigator.platform,
                vendor: navigator.vendor,
                language: navigator.language,
                screenResolution: `${screen.width}x${screen.height}`,
                colorDepth: screen.colorDepth,
                isTouchDevice: 'ontouchstart' in window || navigator.maxTouchPoints > 0
            };
            return deviceInfo;
        }


        $(document).ready(function() {
            drawTriangles();
            showUsersSections();


            $('#register_entrance').click(function() {
                device = getDeviceInfo();
                $.ajax({
                    type: "POST",
                    url: "registrarsalida",
                    data: {
                        _token: "{{ csrf_token() }}",
                        device: device

                    },
                    success: function(response) {
                        Swal.fire(
                            '¡Gracias por esperar!',
                            response.message,
                            'success'
                        );
                    },
                    error: function(xhr) {

                        Swal.fire(
                            '¡Gracias por esperar!',
                            "Existe un error: " + xhr.responseJSON.message,
                            'error'
                        )
                    }
                });
            });


            function getDeviceInfo() {
                const deviceInfo = {
                    userAgent: navigator.userAgent,
                    platform: navigator.platform,
                    vendor: navigator.vendor,
                    language: navigator.language,
                    screenResolution: `${screen.width}x${screen.height}`,
                    colorDepth: screen.colorDepth,
                    isTouchDevice: 'ontouchstart' in window || navigator.maxTouchPoints > 0
                };
                return deviceInfo;
            }
        });
    </script>
@stop
