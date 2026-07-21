@extends('adminlte::page')

@section('title', 'Editar Banners')

@section('content_header')
@stop

@section('content')
    <div class="card">
        <div class="card-body">

            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                Las imágenes deben ser de <strong>1600x697 píxeles</strong> en formato <strong>.jpg</strong> y peso
                máximo de <strong>2MB</strong>
            </div>

            <!-- Usar URL directa en lugar de route() -->
            <form id="editarBanners" enctype="multipart/form-data" action="/enviareditarbanners" method="POST">
                @csrf

                <!-- Banners en grid de 2 columnas -->
                <div class="row">
                    @for ($i = 1; $i <= 6; $i++)
                        <div class="col-md-6 mb-4">
                            <div class="card h-100">
                                <div class="card-header bg-light">
                                    <h4 class="mb-0">Banner {{ $i }}</h4>
                                    <small class="text-muted">slide_0{{ $i }}.jpg</small>
                                </div>
                                <div class="card-body">
                                    <!-- Imagen actual -->
                                    <div class="form-group">
                                        <label>Imagen Actual:</label>
                                        <div class="current-image-container mb-2 text-center">
                                            <img src="{{ asset('assets/images/slide_0' . $i . '.jpg') }}"
                                                alt="Banner {{ $i }} Actual" class="img-fluid border rounded"
                                                style="max-height: 200px; width: auto;"
                                                onerror="this.src='{{ asset('assets/images/sin-imagen.jpg') }}'">
                                        </div>

                                        <!-- Vista previa -->
                                        <div class="preview-container" id="preview{{ $i }}"
                                            style="display: none;">
                                            <label class="text-primary">Vista Previa:</label>
                                            <div class="text-center">
                                                <img src="#" alt="Vista previa" class="img-fluid border rounded"
                                                    style="max-height: 200px; width: auto;">
                                            </div>
                                            <div class="alert alert-warning mt-2" style="font-size: 12px;">
                                                <i class="fas fa-exclamation-triangle"></i>
                                                Asegúrate de que la imagen sea de 1600x697 píxeles
                                            </div>
                                        </div>

                                        <input type="file" name="banner{{ $i }}_imagen"
                                            id="banner{{ $i }}_imagen" class="form-control-file"
                                            accept=".jpg,.jpeg">
                                        <small class="form-text text-muted">
                                            <i class="fas fa-info-circle"></i>
                                            Selecciona una imagen JPG de 1600x697 píxeles (máx. 2MB)
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        @if ($i % 2 == 0)
                            <div class="w-100"></div>
                        @endif
                    @endfor
                </div>

                <!-- Botones de acción -->
                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <button type="submit" class="btn btn-primary btn-lg" id="btnSubmit">
                            <i class="fas fa-save"></i> Actualizar Banners
                        </button>
                        <button type="reset" class="btn btn-secondary btn-lg ml-2">
                            <i class="fas fa-undo"></i> Restablecer
                        </button>
                    </div>
                </div>
            </form>

        </div>
    </div>
    @include('fondo')
@stop

@section('css')
    <style>
        .current-image-container img,
        .preview-container img {
            object-fit: contain;
            max-height: 200px;
            border-radius: 8px;
            background: #f8f9fa;
        }

        .preview-container {
            margin-top: 10px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
            border: 2px dashed #007bff;
        }

        .preview-container label {
            font-weight: bold;
            color: #007bff;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .card-header.bg-light {
            background-color: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6;
        }

        .card-header .text-muted {
            font-size: 12px;
        }

        .btn-lg {
            padding: 10px 30px;
            font-size: 1.1rem;
        }

        .form-control-file {
            padding: 10px;
            border: 2px dashed #dee2e6;
            border-radius: 8px;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s;
        }

        .form-control-file:hover {
            border-color: #007bff;
            background: #f8f9fa;
        }

        .preview-container {
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-body {
            max-height: 80vh;
            overflow-y: auto;
        }

        .spinner-border-sm {
            width: 1rem;
            height: 1rem;
            border-width: 0.2em;
        }
    </style>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            if (typeof drawTriangles === 'function') {
                drawTriangles();
            }
            if (typeof showUsersSections === 'function') {
                showUsersSections();
            }

            // Variables para controlar el estado de carga
            var isSubmitting = false;

            // Vista previa para cada uno de los 6 banners
            @for ($i = 1; $i <= 6; $i++)
                (function(index) {
                    $('#banner' + index + '_imagen').change(function(e) {
                        var file = this.files[0];
                        var previewContainer = $('#preview' + index);
                        var previewImg = previewContainer.find('img');
                        var currentContainer = $(this).closest('.form-group').find(
                            '.current-image-container');

                        // Limpiar estado anterior
                        $('.image-error').remove();

                        if (file) {
                            // Validar tipo de archivo
                            var validTypes = ['image/jpeg', 'image/jpg'];
                            if (validTypes.indexOf(file.type) === -1) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Formato no válido',
                                    text: 'Solo se permiten imágenes en formato JPG'
                                });
                                $(this).val('');
                                return;
                            }

                            // Validar tamaño (2MB = 2 * 1024 * 1024 bytes)
                            if (file.size > 2 * 1024 * 1024) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Archivo muy grande',
                                    text: 'El archivo no debe pesar más de 2MB'
                                });
                                $(this).val('');
                                return;
                            }

                            var reader = new FileReader();
                            reader.onload = function(e) {
                                // Crear imagen para validar dimensiones
                                var img = new Image();
                                img.onload = function() {
                                    if (img.width !== 1600 || img.height !== 697) {
                                        Swal.fire({
                                            icon: 'warning',
                                            title: 'Dimensiones incorrectas',
                                            text: 'La imagen debe ser de 1600x697 píxeles (actual: ' +
                                                img.width + 'x' + img.height + ')',
                                            footer: 'La imagen se cargará pero podría verse mal'
                                        });
                                    }

                                    // Mostrar vista previa
                                    previewImg.attr('src', e.target.result);
                                    previewContainer.slideDown(300);
                                    currentContainer.find('img').css('opacity', '0.3');

                                    if (currentContainer.find('.badge-warning').length === 0) {
                                        currentContainer.append(
                                            '<span class="badge badge-warning ml-2">Nueva imagen seleccionada</span>'
                                        );
                                    }
                                };
                                img.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        } else {
                            previewContainer.slideUp(300);
                            currentContainer.find('img').css('opacity', '1');
                            currentContainer.find('.badge-warning').remove();
                        }
                    });
                })({{ $i }});
            @endfor

            // Envío del formulario con AJAX
            $('#editarBanners').submit(function(e) {
                e.preventDefault();

                // Evitar envíos múltiples
                if (isSubmitting) {
                    return;
                }

                // Crear FormData
                var formData = new FormData(this);

                // Mostrar loading
                Swal.fire({
                    title: 'Actualizando banners...',
                    text: 'Por favor espera, esto puede tomar unos segundos',
                    allowOutsideClick: false,
                    didOpen: function() {
                        Swal.showLoading();
                    }
                });

                // Deshabilitar botón de envío
                isSubmitting = true;
                $('#btnSubmit').prop('disabled', true);
                $('#btnSubmit').html(
                    '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Actualizando...'
                );

                // Usar URL directa en lugar de route()
                $.ajax({
                    url: '/enviareditarbanners',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: '¡Éxito!',
                            text: response.message ||
                                'Banners actualizados correctamente',
                            timer: 3000,
                            timerProgressBar: true
                        }).then(function() {
                            window.location.reload();
                        });
                    },
                    error: function(xhr) {
                        var errorMsg = 'Error al actualizar los banners';

                        if (xhr.responseJSON) {
                            if (xhr.responseJSON.message) {
                                errorMsg = xhr.responseJSON.message;
                            }

                            if (xhr.responseJSON.errors) {
                                var errorDetails = '';
                                $.each(xhr.responseJSON.errors, function(key, value) {
                                    if (typeof value === 'string') {
                                        errorDetails += '<li>' + value + '</li>';
                                    } else {
                                        errorDetails += '<li>' + value.join(', ') +
                                            '</li>';
                                    }
                                });
                                if (errorDetails) {
                                    errorMsg += '<br><ul>' + errorDetails + '</ul>';
                                }
                            }
                        }

                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            html: errorMsg
                        });
                    },
                    complete: function() {
                        isSubmitting = false;
                        $('#btnSubmit').prop('disabled', false);
                        $('#btnSubmit').html('<i class="fas fa-save"></i> Actualizar Banners');
                    }
                });
            });

            // Restablecer formulario con confirmación
            $('button[type="reset"]').click(function(e) {
                e.preventDefault();

                var hasChanges = false;
                @for ($i = 1; $i <= 6; $i++)
                    if ($('#banner{{ $i }}_imagen').val() !== '') {
                        hasChanges = true;
                    }
                @endfor

                if (!hasChanges) {
                    Swal.fire({
                        icon: 'info',
                        title: 'Sin cambios',
                        text: 'No hay cambios para restablecer'
                    });
                    return;
                }

                Swal.fire({
                    title: '¿Restablecer cambios?',
                    text: 'Se perderán todos los cambios no guardados en las imágenes',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, restablecer',
                    cancelButtonText: 'Cancelar'
                }).then(function(result) {
                    if (result.isConfirmed) {
                        @for ($i = 1; $i <= 6; $i++)
                            $('#preview{{ $i }}').slideUp(300);
                            $('#banner{{ $i }}_imagen').val('');
                            var currentContainer = $('#banner{{ $i }}_imagen').closest(
                                '.form-group').find('.current-image-container');
                            currentContainer.find('img').css('opacity', '1');
                            currentContainer.find('.badge-warning').remove();
                        @endfor

                        Swal.fire({
                            icon: 'success',
                            title: 'Restablecido',
                            text: 'El formulario ha sido restablecido',
                            timer: 1500
                        });
                    }
                });
            });
        });
    </script>
@stop
