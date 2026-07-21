@extends('adminlte::page')

@section('title', 'Editar Inventario')

@section('content_header')

@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h1>Editar Inventario</h1>
        </div>
        <div class="card-body">

            <div class="card">

                <div class="card-body">
                    <table id="productos" class="table">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Categoria</th>
                                <th>Almacenes</th>
                                <th>Precios</th>
                                <th>Campos</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="almacenes" tabindex="-1" role="dialog" aria-labelledby="almacenesCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-width" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="almacenesLongTitle">Detalle de almacenes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <table id="almacenestabla" class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Almacen</th>
                                <th>Existencias</th>
                                <th>Editar</th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">



    </div>
    </div>
    </div>
    </div>

    <div class="modal fade" id="precios" tabindex="-1" role="dialog" aria-labelledby="preciosCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-width " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="preciosLongTitle">Detalle de precios</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="preciostabla" class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tipo</th>
                                <th>Precio</th>
                                <th>Editar</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editarProducto" tabindex="-1" role="dialog" aria-labelledby="editarProductoCenterTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-width" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editarProductoLongTitle">
                        Editar Producto:
                        <span class="badge badge-secondary" id="editar_header_id">#--</span>
                        <span class="text-primary ml-2" id="editar_header_nombre">--</span>
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <form id="formEditarProducto" enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">

                        {{-- ID oculto del producto --}}
                        <input type="hidden" id="editar_producto_id" name="id">

                        <div class="row g-3">

                            {{-- NOMBRE --}}
                            <div class="col-md-12 mb-3">
                                <label for="editar_nombre" class="form-label">Nombre</label>
                                <input type="text" id="editar_nombre" name="nombre" class="form-control" required>
                            </div>

                            {{-- MARCA --}}
                            <div class="col-md-6 mb-3">
                                <label for="editar_marca" class="form-label">Marca</label>
                                <select id="editar_marca" name="marca_id" class="form-control" required>
                                    <option value="">-- Selecciona una marca --</option>
                                    @foreach ($marcas as $m)
                                        <option value="{{ $m->id }}">{{ $m->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>

                            {{-- CATEGORÍA --}}
                            <div class="col-md-6 mb-3">
                                <label for="editar_categoria" class="form-label">Categoría</label>
                                <select id="editar_categoria" name="categoria_id" class="form-control" required>
                                    <option value="">-- Selecciona una categoría --</option>
                                    @foreach ($categorias as $c)
                                        <option value="{{ $c->id }}">{{ $c->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>

                            {{-- COSTO --}}
                            <div class="col-md-6 mb-3">
                                <label for="editar_costo" class="form-label">Costo</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" step="0.01" min="0" id="editar_costo"
                                        name="costo" class="form-control" required>
                                </div>
                            </div>

                            {{-- IMAGEN --}}
                            <div class="col-md-6 mb-3">
                                <label for="editar_imagen" class="form-label">Imagen del producto</label>
                                <div class="mb-2">
                                    <img id="editar_imagen_preview" src="" alt="Vista previa"
                                        style="max-width: 150px; max-height: 150px; display: none; border: 1px solid #ddd; padding: 5px; border-radius: 4px;">
                                </div>
                                <input type="file" id="editar_imagen" name="imagen" class="form-control"
                                    accept=".jpg,">
                                <small class="text-muted">Formatos permitidos: JPG, Tamaño máximo: 2MB</small>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary" id="btnGuardarProducto">
                            <i class="fas fa-save"></i> Guardar Cambios
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>



    @include('fondo')
@stop

@section('css')
    <style>
        .modal-dialog.custom-width {
            max-width: 80%;
            /* Ajusta este valor según tus necesidades */
        }
    </style>
@stop

@section('js')
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();

            // Previsualización de la imagen al seleccionar un archivo
            $(document).on('change', '#editar_imagen', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#editar_imagen_preview')
                            .attr('src', e.target.result)
                            .show();
                    }
                    reader.readAsDataURL(file);
                } else {
                    $('#editar_imagen_preview').hide();
                }
            });
        });

        var products = @json($productos);
        $('#productos').DataTable({
            destroy: true,
            scrollX: true,
            scrollCollapse: true,
            "language": {
                "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
            },
            "buttons": [
                'copy', 'excel', 'pdf', 'print'
            ],
            dom: 'Blfrtip',
            destroy: true,
            processing: true,
            sort: true,
            paging: true,
            lengthMenu: [
                [10, 25, 50, -1],
                [10, 25, 50, 'All']
            ], // Personalizar el menú de longitud de visualización

            // Configurar las opciones de exportación
            // Para PDF
            pdf: {
                orientation: 'landscape', // Orientación del PDF (landscape o portrait)
                pageSize: 'A4', // Tamaño del papel del PDF
                exportOptions: {
                    columns: ':visible' // Exportar solo las columnas visibles
                }
            },
            // Para Excel
            excel: {
                exportOptions: {
                    columns: ':visible' // Exportar solo las columnas visibles
                }
            },
            "data": products,
            "columns": [{
                    "data": "id"
                },
                {
                    "data": "nombre"
                },
                {
                    "data": "marca"
                },
                {
                    "data": "categoria"
                },

                {
                    "data": "almacenes",
                    "render": function(data, type, row) {
                        return '<button onclick="editaralmacenes(' + row.id +
                            ')" class="btn btn-primary">Editar</button>';
                    }
                },
                {
                    "data": "precios",
                    "render": function(data, type, row) {
                        return '<button onclick="editarprecios(' + row.id +
                            ')" class="btn btn-primary">Editar</button>';
                    }
                },
                {
                    "data": "campos",
                    "render": function(data, type, row) {
                        return '<button onclick="editarproducto(' + row.id +
                            ')" class="btn btn-primary">Editar</button>';
                    }
                },
            ]
        });

        function editaralmacenes(id) {
            $('#almacenes').modal('show');

            $.ajax({
                url: 'detalleamacenes', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id_producto: id
                },
                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    $('#almacenestabla').DataTable({
                        destroy: true,
                        scrollX: true,
                        scrollCollapse: true,
                        "language": {
                            "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                        },
                        "buttons": [
                            'copy', 'excel', 'pdf', 'print'
                        ],
                        dom: 'Blfrtip',
                        destroy: true,
                        processing: true,
                        sort: true,
                        paging: true,
                        lengthMenu: [
                            [10, 25, 50, -1],
                            [10, 25, 50, 'All']
                        ], // Personalizar el menú de longitud de visualización

                        // Configurar las opciones de exportación
                        // Para PDF
                        pdf: {
                            orientation: 'landscape', // Orientación del PDF (landscape o portrait)
                            pageSize: 'A4', // Tamaño del papel del PDF
                            exportOptions: {
                                columns: ':visible' // Exportar solo las columnas visibles
                            }
                        },
                        // Para Excel
                        excel: {
                            exportOptions: {
                                columns: ':visible' // Exportar solo las columnas visibles
                            }
                        },
                        "data": data,
                        "columns": [{
                                "data": "idproducto"
                            },
                            {
                                "data": "nombre"
                            },
                            {
                                "data": "existencias"
                            },
                            {
                                "data": "editar",
                                "render": function(data, type, row) {

                                    var idfila = row.nombre;
                                    fila = quitarEspaciosExtra(idfila);
                                    return '<input type="number" class="form control" id = "idalmacen_' +
                                        row.idproducto + fila +
                                        '"> <button onclick="enviareditaralmacenform(' +
                                        row.idproducto + ",'" + row.nombre + "'" +
                                        ')" class="btn btn-primary">Enviar</button>';
                                }
                            },
                        ]
                    });
                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud
                    console.error(error); // Muestra el error en la consola del navegador
                }
            });
        }

        function quitarEspaciosExtra(cadena) {
            return cadena.replace(/\s+/g, '').trim();
        }


        function editarprecios(id) {
            $('#precios').modal('show');

            $.ajax({
                url: 'detalleprecios', // URL a la que se hace la solicitud
                type: 'GET', // Tipo de solicitud (GET, POST, etc.)
                data: {
                    id_producto: id
                },

                dataType: 'json', // Tipo de datos esperados en la respuesta
                success: function(data) {
                    $('#preciostabla').DataTable({
                        destroy: true,
                        scrollX: true,
                        scrollCollapse: true,
                        "language": {
                            "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                        },
                        "buttons": [
                            'copy', 'excel', 'pdf', 'print'
                        ],
                        dom: 'Blfrtip',
                        destroy: true,
                        processing: true,
                        sort: true,
                        paging: true,
                        lengthMenu: [
                            [10, 25, 50, -1],
                            [10, 25, 50, 'All']
                        ], // Personalizar el menú de longitud de visualización

                        // Configurar las opciones de exportación
                        // Para PDF
                        pdf: {
                            orientation: 'landscape', // Orientación del PDF (landscape o portrait)
                            pageSize: 'A4', // Tamaño del papel del PDF
                            exportOptions: {
                                columns: ':visible' // Exportar solo las columnas visibles
                            }
                        },
                        // Para Excel
                        excel: {
                            exportOptions: {
                                columns: ':visible' // Exportar solo las columnas visibles
                            }
                        },
                        "data": data,
                        "columns": [{
                                "data": "idproducto"
                            },
                            {
                                "data": "nombre"
                            },
                            {
                                "data": "price"
                            }, {
                                "data": "editar",
                                "render": function(data, type, row) {
                                    return '<input type="number" class="form control" id = "idprecio_' +
                                        row.idproducto + row.nombre +
                                        '"> <button onclick="enviareditarprecioform(' +
                                        row.idproducto + ",'" + row.nombre + "'" +
                                        ')" class="btn btn-primary">Enviar</button>';
                                }
                            },
                        ]
                    });
                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud
                    console.error(error); // Muestra el error en la consola del navegador
                }
            });
        }


        function editarproducto(id) {
            $('#editarProducto').modal('show');

            // Limpia mientras carga
            $('#editar_header_id').text('#' + id);

            // Ocultar previsualización anterior
            $('#editar_imagen_preview').hide();
            $('#editar_imagen').val(''); // Limpiar el input file

            $.ajax({
                url: 'obtenerproducto',
                type: 'GET',
                data: {
                    id_producto: id
                },
                dataType: 'json',
                success: function(data) {
                    // Llena los inputs del formulario
                    $('#editar_producto_id').val(data[0].id);
                    $('#editar_header_nombre').text(data[0].nombre || 'Nombre no disponible');
                    $('#editar_nombre').val(data[0].nombre);
                    $('#editar_marca').val(data[0].marca);
                    $('#editar_categoria').val(data[0].categoria);
                    $('#editar_costo').val(data[0].costo);

                    // Mostrar la imagen si existe
                    if (data[0].imagen && data[0].imagen !== '') {
                        var imagePath = '{{ asset('assets/images/productos') }}/' + data[0].imagen;
                        $('#editar_imagen_preview')
                            .attr('src', imagePath)
                            .show();
                    } else {
                        $('#editar_imagen_preview').hide();
                    }
                },
                error: function(xhr, status, error) {
                    console.error(error);
                    $('#editar_header_nombre').text('Error al cargar');
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se pudo cargar la información del producto'
                    });
                }
            });
        }

        function enviareditaralmacenform(id, almacen) {
            nuevaexistencia = '#idalmacen_' + id + quitarEspaciosExtra(almacen);
            val_nuevaexistencia = $(nuevaexistencia).val();
            if (val_nuevaexistencia == "") {
                Swal.fire(
                    '¡Aviso!',
                    "No haz llenado la nueva existencia",
                    'warning'
                )
            } else {
                var datosFormulario = {
                    id: id,
                    almacen: almacen,
                    nueva_existencia: val_nuevaexistencia
                };
                // Realizar la solicitud AJAX con jQuery

                $.ajax({
                    url: '/enviareditaralmacenes', // Ruta al controlador de Laravel
                    type: 'POST',
                    data: datosFormulario, // Enviar los datos del formulario
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        Swal.fire(
                            '¡Gracias por esperar!',
                            response.message,
                            'success'
                        );
                        /*                     setTimeout(function() {
                                                window.location.reload();
                                            }, 3000); */

                    },
                    error: function(response) {
                        Swal.fire(
                            '¡Gracias por esperar!',
                            "Existe un error: " + response.message,
                            'error'
                        )
                    }
                });
            }

        }

        function enviareditarprecioform(id, tipo) {
            nuevoprecio = '#idprecio_' + id + tipo;
            val_nuevoprecio = $(nuevoprecio).val();
            if (val_nuevoprecio == "") {
                Swal.fire(
                    '¡Aviso!',
                    "No haz llenado el nuevo precio",
                    'warning'
                )
            } else {
                var datosFormulario = {
                    id: id,
                    tipo: tipo,
                    nuevo_precio: val_nuevoprecio
                };
                // Realizar la solicitud AJAX con jQuery

                $.ajax({
                    url: '/enviareditarprecio', // Ruta al controlador de Laravel
                    type: 'POST',
                    data: datosFormulario, // Enviar los datos del formulario
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        Swal.fire(
                            '¡Gracias por esperar!',
                            response.message,
                            'success'
                        );
                        /*                     setTimeout(function() {
                                                window.location.reload();
                                            }, 3000); */

                    },
                    error: function(response) {
                        Swal.fire(
                            '¡Gracias por esperar!',
                            "Existe un error: " + response.message,
                            'error'
                        )
                    }
                });
            }

        }

        $('#formEditarProducto').on('submit', function(e) {
            e.preventDefault();

            var btn = $('#btnGuardarProducto');

            // Validar campos obligatorios
            var nombre = $.trim($('#editar_nombre').val());
            var marca = $('#editar_marca').val();
            var categoria = $('#editar_categoria').val();
            var costo = $('#editar_costo').val();
            var imagen = $('#editar_imagen')[0].files[0];

            // Validar nombre
            if (nombre === '') {
                Swal.fire({
                    icon: 'warning',
                    title: 'Campo requerido',
                    text: 'El nombre del producto es obligatorio'
                });
                $('#editar_nombre').focus();
                return;
            }

            // Validar marca
            if (marca === '') {
                Swal.fire({
                    icon: 'warning',
                    title: 'Campo requerido',
                    text: 'Debes seleccionar una marca'
                });
                $('#editar_marca').focus();
                return;
            }

            // Validar categoría
            if (categoria === '') {
                Swal.fire({
                    icon: 'warning',
                    title: 'Campo requerido',
                    text: 'Debes seleccionar una categoría'
                });
                $('#editar_categoria').focus();
                return;
            }

            // Validar costo
            if (costo === '' || parseFloat(costo) < 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Campo requerido',
                    text: 'El costo debe ser un número válido mayor o igual a 0'
                });
                $('#editar_costo').focus();
                return;
            }

            // Validar imagen si se seleccionó una
            if (imagen) {
                // Validar tipo de archivo
                const tiposPermitidos = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if ($.inArray(imagen.type, tiposPermitidos) === -1) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Solo se permiten imágenes JPG, JPEG, PNG y GIF'
                    });
                    $('#editar_imagen').focus();
                    return;
                }

                // Validar tamaño (10MB)
                if (imagen.size > 10 * 1024 * 1024) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'La imagen no puede superar los 10MB'
                    });
                    $('#editar_imagen').focus();
                    return;
                }
            }

            btn.prop('disabled', true);
            btn.html('<i class="fas fa-spinner fa-spin"></i> Guardando...');

            // Crear FormData para enviar archivos
            var formData = new FormData(this);

            $.ajax({
                url: '/guardarproducto',
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
                        title: 'Producto actualizado',
                        text: response.message || 'Los cambios fueron guardados correctamente'
                    });

                    $('#editarProducto').modal('hide');

                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                },
                error: function(xhr) {
                    var mensaje = 'Ocurrió un error al guardar';

                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        mensaje = xhr.responseJSON.message;
                    }

                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: mensaje
                    });
                },
                complete: function() {
                    btn.prop('disabled', false);
                    btn.html('<i class="fas fa-save"></i> Guardar Cambios');
                }
            });
        });
    </script>
@stop
