@extends('adminlte::page')

@section('title', 'Calendario')

@section('content_header')
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
@stop

@section('content')
    <div class="card">
        <div class="card-header">
            <h2>Calendario de Incidencias</h2>
        </div>
        <div class="card-body">
            <h6>Recuerda que por default se carga el mes en curso</h6>
            <div class="container mt-6">
                <div class="scroll-horizontal">

                    <form id = "getincidencias">
                        <div class="row">
                            <div class="col">
                                <div class="container mt-1">
                                    <label for="mes" class="form-label">Selecciona un Mes</label>
                                    <select class="form-select" name="mes" id="mes">
                                        <option value="1">Enero</option>
                                        <option value="2">Febrero</option>
                                        <option value="3">Marzo</option>
                                        <option value="4">Abril</option>
                                        <option value="5">Mayo</option>
                                        <option value="6">Junio</option>
                                        <option value="7">Julio</option>
                                        <option value="8">Agosto</option>
                                        <option value="9">Septiembre</option>
                                        <option value="10">Octubre</option>
                                        <option value="11">Noviembre</option>
                                        <option value="12">Diciembre</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col">
                                <div class="container mt-1">
                                    <label for="mes" class="form-label">Selecciona un Mes</label>
                                    <select class="form-select" name="anio" id="anio">
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                        <option value="2026">2026</option>

                                    </select>
                                </div>
                            </div>
                            <div class="col">
                                <div class="container mt-1">

                                    <button type="submit" class="btn btn-success">Generar</button>
                                </div>
                            </div>
                        </div>


                    </form>

                    <br>
                    <table class="table table-bordered" id="incidenciasTabla">
                        <thead>
                            <tr>
                                <th>Usuario</th>
                                <!-- Genera los días del mes automáticamente -->
                                <script>
                                    for (let i = 1; i <= 31; i++) {
                                        document.write('<th>Día ' + i + '</th>');
                                    }
                                </script>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí se llenarán los datos dinámicamente -->
                        </tbody>
                    </table>
                </div>
            </div>


        </div>


    </div>

    <div class="modal fade" id="incidenciaModal" tabindex="-1" aria-labelledby="incidenciaModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="incidenciaModalLabel">Agregar Incidencia</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p id="usuarioSeleccionado"></p>
                    <p id = "idusuario"style="display: none"></p>

                    <div class="mb-3">
                        <label for="fechaIncidencia" class="form-label">Fecha de la Incidencia</label>
                        <input type="date" class="form-control" id="fechaIncidencia" required>
                    </div>

                    <!-- Select para tipo de incidencia -->
                    <div class="mb-3">
                        <label for="tipoIncidencia" class="form-label">Tipo de Incidencia</label>
                        <select class="form-select" id="tipoIncidencia">
                            <option value="FALTA">Falta</option>
                            <option value="PERMISO">Permiso</option>
                            <option value="VACACION">Vacación</option>
                            <option value="ENFERMEDAD">Enfermedad</option>
                            <option value="CUMPLE">Cumpleaños</option>
                            <option value="PRIMA_VACACIONAL">Prima Vacacional</option>
                            <option value="CAJA_AHORRO">Caja de Ahorro</option>
                            <option value="AGUINALDO">Aguinaldo</option>
                            <option value="TERMINO_RELACION_LAVORAL">Termino de relacion lavoral</option>
                            <option value="OTRO">Otro</option>
                        </select>
                    </div>

                    <!-- Textbox para descripción -->
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <textarea class="form-control" id="descripcion" rows="3" placeholder="Añadir una descripción..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="guardarCambios">Guardar Cambios</button>
                </div>
            </div>
        </div>
    </div>

    @include('fondo')
@stop

@section('css')
    <style>
        .scroll-horizontal {
            overflow-x: auto;
            /* Permite el scroll horizontal */
            white-space: nowrap;
            /* Evita que el contenido se ajuste automáticamente */
        }

        .table {
            min-width: 1000px;
            /* Ajusta el ancho mínimo de la tabla para forzar el scroll */
        }
    </style>
@stop

@section('js')
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function llenarTabla(empleados, incidencias) {
            const $tbody = $("#incidenciasTabla tbody");
            $tbody.empty(); // Limpiar antes de rellenar

            empleados.forEach(empleado => {
                let fila = `<tr><td>${empleado.nombre}</td>`;

                // Crear las celdas de días y colocar la primera letra del tipo de incidencia si existe
                for (let i = 1; i <= 31; i++) {
                    let tipoIncidencia = '';
                    let clase = '';

                    // Buscar si existe una incidencia en el día `i` para el empleado actual
                    incidenciaDelDia = incidencias.find(element =>
                        element.iduser === empleado.id && obtenerDiaEnUTC6(element.fecha) === i
                    );

                    if (incidenciaDelDia) {
                        tipoIncidencia = incidenciaDelDia.tipo.charAt(0).toUpperCase();
                        clase = 'bg-primary text-white text-center p-2 rounded';
                        fila +=
                            `<td class="dia-celda ${clase}" onclick="abrirSwalDetalles(${empleado.id})">${tipoIncidencia}</td>`;
                    } else {
                        fila += `<td class="dia-celda"></td>`;
                    }


                }

                // Agregar la columna de acciones
                fila +=
                    `<td><button class="btn btn-primary btn-sm" onclick="openIncidenciaModal(${empleado.id}, '${empleado.nombre}')">Agregar Incidencia</button></td></tr>`;

                // Añadir la fila al tbody
                $tbody.append(fila);
            });
        }



        function obtenerDiaEnUTC6(fecha) {
            // Crear la fecha en UTC y ajustar la hora a UTC-6
            const fechaUTC6 = new Date(Date.UTC(
                parseInt(fecha.slice(0, 4)), // Año
                parseInt(fecha.slice(5, 7)) - 1, // Mes (0-indexed)
                parseInt(fecha.slice(8, 10)), // Día
                6, 0, 0 // Establecer la hora en UTC-6
            ));
            return fechaUTC6.getDate();
        }


        function abrirSwalDetalles(idIncidencia) {
            $.ajax({
                url: `/obtenerincidencia`, // Reemplaza con la ruta correcta
                method: 'GET',
                data: {
                    id: idIncidencia
                },
                success: function(incidencia) {
                    // Mostrar el swal con los detalles de la incidencia
                    descripcion = `${incidencia[0].descripcion}`;
                    if (descripcion == "null") {
                        descripcion = "Sin descripción";
                    }
                    Swal.fire({
                        title: `Detalles de la incidencia para ${incidencia[0].nombre}`,
                        html: `<strong>Fecha:</strong> ${incidencia[0].fecha}<br>
           <strong>Tipo:</strong> ${incidencia[0].tipo}<br>
           <strong>Descripción:</strong> ` + descripcion,
                        icon: 'info',
                        showCancelButton: true,
                        confirmButtonText: 'Cerrar',
                        cancelButtonText: 'Cancelar incidencia',
                    }).then((result) => {
                        if (result.dismiss === Swal.DismissReason.cancel) {
                            cancelarIncidencia(incidencia[0].id, incidencia[0]
                                .fecha); // Llama a la función para cancelar
                        }
                    });
                },
                error: function(err) {
                    console.error('Error al obtener los detalles de la incidencia:', err);
                }
            });
        }
        // Función para abrir el modal y mostrar el nombre del usuario seleccionado
        function openIncidenciaModal(id, nombre) {
            // Mostrar el nombre del usuario en el modal
            $('#usuarioSeleccionado').text(`Agregar incidencia para: ${nombre}`);
            $('#idusuario').text(`${id}`);

            // Abrir el modal de Bootstrap
            $('#incidenciaModal').modal('show');
        }

        $('#guardarCambios').click(function() {

            id = $('#idusuario').text();
            usuario = $('#usuarioSeleccionado').text();
            tipoIncidencia = $('#tipoIncidencia').val();
            descripcion = $('#descripcion').val();
            fecha = $('#fechaIncidencia').val();
            if (!fecha) {
                Swal.fire(
                    '¡Aviso!',
                    "Favor de seleccionar la fecha",
                    'warning'
                )
                return; // Detiene la ejecución si la fecha no es válida
            }
            incidenciaData = {
                "iduser": id,
                "tipo": tipoIncidencia,
                "descripcion": descripcion,
                "fecha": fecha
            };


            $.ajax({
                url: '/marcarincidencia', // Ruta al controlador de Laravel
                type: 'POST',
                // data: datosFormulario, // Enviar los datos del formulario
                data: incidenciaData,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire(
                        '¡Gracias por esperar!',
                        response.message,
                        'success'
                    );
                    setTimeout(function() {
                        window.location.reload();
                    }, 3000);

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

        $('#getincidencias').submit(function(e) {
            e.preventDefault(); // Evitar la recarga de la página

            // Obtener los datos del formulario
            var datosFormulario = $(this).serialize();



            $.ajax({
                url: '/calendarioincidencias', // Ruta al controlador de Laravel
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
                    incidencias = response.incidencias;
                    empleados = @json($empleados);
                    llenarTabla(empleados, incidencias);

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


        function cancelarIncidencia(idIncidencia, fecha) {
            $.ajax({
                url: 'cancelarincidencia', // Cambia esto por la URL de tu endpoint
                type: 'POST',
                data: {
                    id: idIncidencia,
                    fecha: fecha
                },
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.fire({
                        title: 'Incidencia cancelada',
                        text: 'La incidencia ha sido cancelada con éxito.',
                        icon: 'success'
                    });
                    setTimeout(function() {
                        window.location.reload();
                    }, 3000);
                    // Aquí puedes agregar lógica adicional, como recargar datos de la tabla
                },
                error: function(error) {
                    Swal.fire({
                        title: 'Error',
                        text: 'Hubo un problema al cancelar la incidencia.',
                        icon: 'error'
                    });
                }
            });
        }



        $(document).ready(function() {

            $(document).off('click', '.selector').on('click', '.selector', abrirSwalDetalles);
            drawTriangles();
            showUsersSections();

            // Ejemplo de JSON con usuarios y sus datos
            empleados = @json($empleados);
            empleados = empleados.map(empleado => ({
                ...empleado,
                dias: Array(31).fill("")
            }));

            var incidencias = @json($incidencias);

            llenarTabla(empleados, incidencias);
        });
    </script>
@stop
