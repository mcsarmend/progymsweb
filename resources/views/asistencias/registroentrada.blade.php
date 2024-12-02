@extends('adminlte::page')

@section('title', 'Registro Entrada')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Registro Entrada</h1>
        </div>
        <div class="card-body">
            <button id="register_entrance" class="btn btn-success">Registrar Entrada</button>
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
                    url: "registrarentrada",
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

            // $('#barcodeInput').focus();

            // $('#barcodeInput').on('keypress', function(e) {
            //     if (e.which == 13) { // Detectar la tecla Enter
            //         const barcode = $(this).val();
            //         handleBarcodeScan(barcode);
            //         $(this).val(''); // Limpiar el campo de entrada después de escanear
            //     }
            // });

            $('#register').click(function() {
                const barcode = $('#barcodeInput').val();
                if (barcode) {
                    handleBarcodeScan(barcode);
                } else {
                    alert('Por favor, escanee un código de barras primero.');
                }
            });

            function handleBarcodeScan(barcode) {
                const deviceInfo = getDeviceInfo();
                $.ajax({
                    type: "POST",
                    url: "/register-entry",
                    data: {
                        _token: "{{ csrf_token() }}",
                        barcode: barcode,
                        deviceInfo: deviceInfo
                    },
                    success: function(response) {
                        if (response.success) {
                            alert('Entrada registrada exitosamente');
                        } else {
                            5056555202340

                        }
                    },
                    error: function(xhr) {
                        alert('Error en el servidor');
                    }
                });
            }

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
