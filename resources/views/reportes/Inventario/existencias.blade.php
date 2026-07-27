@extends('adminlte::page')

@section('title', 'Existencias y Costos')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">

            <div class="card">
                <div class="card-header">
                    <h1>Precios y existencias</h1>
                </div>
                <div class="card-body">

                    <form method="POST" id="existencias_form">
                        @csrf
                        <div class="row justify-content-center align-items-center text-center">
                            <div class="col-auto">
                                <label for="">Almacen:</label>
                                <select class="form-control" name="almacen" id="almacen" required>
                                    <option class="form-control" value="0">Todos</option>
                                    @foreach ($almacenes as $almacen)
                                        <option class="form-control" value="{{ $almacen->id }}">{{ $almacen->nombre }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-auto">
                                <button type="button" id="btnExcel" class="btn btn-success">
                                    <i class="fas fa-file-excel"></i> Descargar Excel
                                </button>
                            </div>
                            <div class="col-auto">
                                <button type="button" id="btnPDF" class="btn btn-danger">
                                    <i class="fas fa-file-pdf"></i> Descargar PDF
                                </button>
                            </div>
                        </div>
                    </form>
                    <br>

                    <div class="col-12 col-md-6 mb-3 mx-auto">
                        <div class="card bg-primary text-white shadow h-100">
                            <div class="card-body text-center">
                                <h3><i class=""></i> Total Costos</h3>
                                <h1 id="total_costos" class="display-4" style="color: #00ffa6;">$0.00</h1>
                            </div>
                        </div>
                    </div>
                    <table id="productos" class="table">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Categoria</th>
                                <th>Costo</th>
                                <th>Costo Promedio</th>
                                <th>Público</th>
                                <th>Frecuente</th>
                                <th>Mayoreo</th>
                                <th>Distribuidor</th>
                                <th>Platinum</th>
                                <th>Existencias Totales</th>
                                <th>Bodega</th>
                                <th>TownCenter</th>
                                <th>Coacalco</th>
                                <th>Naucalpan</th>
                                <th>Tienda Piso</th>
                                <th>Pedidos</th>
                                <th>Promotoria</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

    @include('fondo')
@stop

@section('css')

@stop

@section('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.2.0/js/dataTables.fixedHeader.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.2.0/css/fixedHeader.dataTables.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

    <script>
        $(document).ready(function() {
            var products = @json($products);
            var total_costos = @json($total_costos);
            var user = @json(auth()->user()->name ?? 'Usuario');

            $('#total_costos').text(
                '$' + Number(total_costos).toLocaleString('es-MX', {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                })
            );

            $('#productos').DataTable({
                destroy: true,
                scrollX: true,
                fixedHeader: true,
                scrollY: '700px',
                scrollCollapse: true,
                "language": {
                    "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                "buttons": [],
                dom: 'Blfrtip',
                createdRow: function(row, data, dataIndex) {
                    $(row).css('font-size', '17px');
                    $(row).addClass(dataIndex % 2 === 0 ? 'bg-white' : 'bg-secondary text-white');
                },
                pageLength: 50,
                processing: true,
                sort: true,
                paging: true,
                lengthMenu: [
                    [10, 25, 50, -1],
                    [10, 25, 50, 'All']
                ],
                "data": products,
                "columns": [{
                        "data": "codigo"
                    },
                    {
                        "data": "producto",
                        "width": "350px"
                    },
                    {
                        "data": "marca"
                    },
                    {
                        "data": "categoria"
                    },
                    {
                        "data": "costo"
                    },
                    {
                        "data": "costo_promedio"
                    },
                    {
                        "data": "publico",
                        "render": function(data) {
                            return data ? '$' + data : '$0.00';
                        }
                    },
                    {
                        "data": "frecuente",
                        "render": function(data) {
                            return data ? '$' + data : '$0.00';
                        }
                    },
                    {
                        "data": "mayoreo",
                        "render": function(data) {
                            return data ? '$' + data : '$0.00';
                        }
                    },
                    {
                        "data": "distribuidor",
                        "render": function(data) {
                            return data ? '$' + data : '$0.00';
                        }
                    },
                    {
                        "data": "platinum",
                        "render": function(data) {
                            return data ? '$' + data : '$0.00';
                        }
                    },
                    {
                        "data": "totales"
                    },
                    {
                        "data": "bodega"
                    },
                    {
                        "data": "towncenter"
                    },
                    {
                        "data": "coacalco"
                    },
                    {
                        "data": "naucalpan"
                    },
                    {
                        "data": "tienda_piso"
                    },
                    {
                        "data": "pedidos"
                    },
                    {
                        "data": "promotoria"
                    }
                ],
                order: [
                    [2, 'asc']
                ]
            });

            drawTriangles();
            showUsersSections();
        });

        // Función para obtener el nombre del almacén
        function getNombreAlmacen() {
            return $('#almacen option:selected').text();
        }

        // Función para obtener el timestamp formateado
        function getFormattedTimestamp() {
            var ahora = new Date();
            var fecha = ahora.toISOString().slice(0, 10);
            var hora = ahora.toTimeString().slice(0, 8).replace(/:/g, '-');
            return fecha + '_' + hora;
        }

        // Función para obtener el nombre del archivo
        function getNombreArchivo(extension) {
            var almacen = getNombreAlmacen().replace(/\s+/g, '_');
            var timestamp = getFormattedTimestamp();
            return 'existencias_' + almacen + '_' + timestamp + '.' + extension;
        }

        // Función para normalizar los datos según el almacén seleccionado
        function normalizarDatos(data, esTodos) {
            if (esTodos) {
                return data;
            } else {
                return data.map(item => {
                    return {
                        codigo: item.codigo || '',
                        producto: item.producto || '',
                        marca: item.marca || '',
                        categoria: item.categoria || '',
                        costo: item.costo || 0,
                        costo_promedio: item.costo_promedio || 0,
                        publico: item.publico || 0,
                        frecuente: item.frecuente || 0,
                        mayoreo: item.mayoreo || 0,
                        distribuidor: item.distribuidor || 0,
                        platinum: item.platinum || 0,
                        totales: item.existencias || 0,
                        bodega: 0,
                        towncenter: 0,
                        coacalco: 0,
                        naucalpan: 0,
                        tienda_piso: 0,
                        pedidos: 0,
                        promotoria: 0
                    };
                });
            }
        }

        // Botón de Excel
        $('#btnExcel').on('click', function() {
            const idsucursal = $('#almacen').val();
            const esTodos = idsucursal == 0;
            const data = {
                sucursal: idsucursal
            };

            Swal.fire({
                title: 'Generando Excel...',
                text: 'Por favor espera',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            $.ajax({
                url: 'reportesoloexistencias',
                type: 'POST',
                data: data,
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.close();

                    if (!response.products || response.products.length === 0) {
                        Swal.fire({
                            icon: 'warning',
                            title: 'Sin datos',
                            text: 'No hay productos para el almacén seleccionado'
                        });
                        return;
                    }

                    var datosNormalizados = normalizarDatos(response.products, esTodos);
                    exportarexcel(datosNormalizados, getNombreArchivo('xlsx'));
                },
                error: function(xhr) {
                    Swal.close();
                    console.error('Error:', xhr);
                    Swal.fire({
                        title: 'Error:',
                        text: xhr.responseJSON?.message || 'Error al generar el reporte',
                        icon: 'warning'
                    });
                }
            });
        });

        // Botón de PDF
        $('#btnPDF').on('click', function() {
            const idsucursal = $('#almacen').val();
            const esTodos = idsucursal == 0;
            const data = {
                sucursal: idsucursal
            };

            Swal.fire({
                title: 'Generando PDF...',
                text: 'Por favor espera',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            $.ajax({
                url: 'reportesoloexistencias',
                type: 'POST',
                data: data,
                dataType: 'json',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    Swal.close();

                    if (!response.products || response.products.length === 0) {
                        Swal.fire({
                            icon: 'warning',
                            title: 'Sin datos',
                            text: 'No hay productos para el almacén seleccionado'
                        });
                        return;
                    }

                    var datosNormalizados = normalizarDatos(response.products, esTodos);
                    generarPDF(datosNormalizados, esTodos);
                },
                error: function(xhr) {
                    Swal.close();
                    console.error('Error:', xhr);
                    Swal.fire({
                        title: 'Error:',
                        text: xhr.responseJSON?.message || 'Error al generar el reporte',
                        icon: 'warning'
                    });
                }
            });
        });

        function generarPDF(data, esTodos) {
            try {
                console.log('Generando PDF con datos:', data);

                const {
                    jsPDF
                } = window.jspdf;

                // Determinar orientación según el tipo de reporte
                const orientation = esTodos ? 'landscape' : 'portrait';
                const doc = new jsPDF(orientation, 'mm', 'a4');

                const user = @json(auth()->user()->name ?? 'Usuario');
                const almacen = getNombreAlmacen();
                const ahora = new Date();
                const fecha = ahora.toLocaleDateString('es-MX');
                const hora = ahora.toTimeString().slice(0, 8);

                const pageWidth = doc.internal.pageSize.getWidth();
                const pageHeight = doc.internal.pageSize.getHeight();

                // ============ ENCABEZADO ============
                // Título principal
                doc.setFontSize(16);
                doc.setTextColor(0, 0, 128);
                doc.text('REPORTE DE EXISTENCIAS', pageWidth / 2, 20, {
                    align: 'center'
                });

                // Línea decorativa
                doc.setDrawColor(0, 0, 128);
                doc.setLineWidth(0.3);
                doc.line(15, 25, pageWidth - 15, 25);

                // ============ INFORMACIÓN DEL REPORTE (Formato vertical compacto) ============
                let yPos = 32;
                doc.setFontSize(9);
                doc.setTextColor(0, 0, 0);

                // Almacén
                doc.setFont('helvetica', 'bold');
                doc.text('Almacén:', 20, yPos);
                doc.setFont('helvetica', 'normal');
                doc.text(almacen, 55, yPos);
                yPos += 7;

                // Fecha
                doc.setFont('helvetica', 'bold');
                doc.text('Fecha:', 20, yPos);
                doc.setFont('helvetica', 'normal');
                doc.text(fecha, 55, yPos);
                yPos += 7;

                // Hora
                doc.setFont('helvetica', 'bold');
                doc.text('Hora:', 20, yPos);
                doc.setFont('helvetica', 'normal');
                doc.text(hora, 55, yPos);
                yPos += 7;

                // Descargado por
                doc.setFont('helvetica', 'bold');
                doc.text('Descargado por:', 20, yPos);
                doc.setFont('helvetica', 'normal');
                doc.text(user, 55, yPos);
                yPos += 8;

                // Línea separadora
                doc.setDrawColor(0, 0, 128);
                doc.setLineWidth(0.2);
                doc.line(15, yPos, pageWidth - 15, yPos);
                yPos += 6;

                // ============ TABLA DE DATOS ============
                let columnasPermitidas;
                let headersMap;
                let columnStyles = {};
                let fontSize = 6;
                let headFontSize = 7;

                if (esTodos) {
                    // Para "Todos": todas las columnas de existencias en HORIZONTAL
                    columnasPermitidas = [
                        "codigo",
                        "producto",
                        "marca",
                        "categoria",
                        "totales",
                        "bodega",
                        "towncenter",
                        "coacalco",
                        "naucalpan",
                        "tienda_piso",
                        "pedidos",
                        "promotoria"
                    ];

                    headersMap = {
                        "codigo": "Código",
                        "producto": "Producto",
                        "marca": "Marca",
                        "categoria": "Cat.",
                        "totales": "Totales",
                        "bodega": "Bodega",
                        "towncenter": "T.Center",
                        "coacalco": "Coacalco",
                        "naucalpan": "Naucalpan",
                        "tienda_piso": "T.Piso",
                        "pedidos": "Pedidos",
                        "promotoria": "Prom."
                    };

                    columnStyles = {
                        0: {
                            cellWidth: 14
                        }, // Código
                        1: {
                            cellWidth: 48
                        }, // Producto - MÁS LARGA
                        2: {
                            cellWidth: 18
                        }, // Marca
                        3: {
                            cellWidth: 16
                        }, // Categoria
                        4: {
                            cellWidth: 14
                        }, // Totales
                        5: {
                            cellWidth: 14
                        }, // Bodega
                        6: {
                            cellWidth: 14
                        }, // TownCenter
                        7: {
                            cellWidth: 14
                        }, // Coacalco
                        8: {
                            cellWidth: 14
                        }, // Naucalpan
                        9: {
                            cellWidth: 14
                        }, // Tienda Piso
                        10: {
                            cellWidth: 14
                        }, // Pedidos
                        11: {
                            cellWidth: 14
                        } // Promotoria
                    };

                    fontSize = 5.5;
                    headFontSize = 6;
                } else {
                    // Para un almacén específico en VERTICAL
                    columnasPermitidas = [
                        "codigo",
                        "producto",
                        "marca",
                        "categoria",
                        "totales"
                    ];

                    headersMap = {
                        "codigo": "Código",
                        "producto": "Producto",
                        "marca": "Marca",
                        "categoria": "Categoría",
                        "totales": "Existencias"
                    };

                    columnStyles = {
                        0: {
                            cellWidth: 16
                        }, // Código
                        1: {
                            cellWidth: 80
                        }, // Producto - MÁS LARGA
                        2: {
                            cellWidth: 26
                        }, // Marca
                        3: {
                            cellWidth: 30
                        }, // Categoria
                        4: {
                            cellWidth: 26
                        } // Existencias
                    };

                    fontSize = 8;
                    headFontSize = 9;
                }

                // Filtrar datos
                const dataFiltrada = data.map(item => {
                    let obj = {};
                    columnasPermitidas.forEach(col => {
                        obj[col] = item[col] !== undefined && item[col] !== null ? item[col] : 0;
                    });
                    return obj;
                });

                const headers = columnasPermitidas.map(col => headersMap[col] || col);
                const rows = dataFiltrada.map(item => columnasPermitidas.map(col => item[col]));

                // Generar tabla
                doc.autoTable({
                    head: [headers],
                    body: rows,
                    startY: yPos + 2,
                    styles: {
                        fontSize: fontSize,
                        cellPadding: 1.2,
                        valign: 'middle',
                        halign: 'center'
                    },
                    headStyles: {
                        fillColor: [0, 0, 128],
                        textColor: [255, 255, 255],
                        fontSize: headFontSize,
                        fontStyle: 'bold',
                        halign: 'center'
                    },
                    columnStyles: columnStyles,
                    pageBreak: 'auto',
                    margin: {
                        top: 15,
                        bottom: 15,
                        left: 10,
                        right: 10
                    },
                    tableWidth: 'auto'
                });

                // ============ PIE DE PÁGINA ============
                const totalPages = doc.internal.getNumberOfPages();
                for (let i = 1; i <= totalPages; i++) {
                    doc.setPage(i);
                    doc.setFontSize(7);
                    doc.setTextColor(100, 100, 100);
                    const footerText = `Página ${i} de ${totalPages} | Generado: ${fecha} ${hora}`;
                    doc.text(footerText, pageWidth / 2, pageHeight - 6, {
                        align: 'center'
                    });

                    // Línea de pie de página
                    doc.setDrawColor(200, 200, 200);
                    doc.setLineWidth(0.2);
                    doc.line(15, pageHeight - 9, pageWidth - 15, pageHeight - 9);
                }

                // Guardar PDF
                doc.save(getNombreArchivo('pdf'));

                Swal.fire({
                    icon: 'success',
                    title: 'PDF generado correctamente',
                    text: 'El reporte se ha descargado exitosamente'
                });

            } catch (error) {
                console.error('Error en generarPDF:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error al generar PDF',
                    text: error.message || 'Error desconocido'
                });
            }
        }

        // Función exportarexcel
        function exportarexcel(data, filename) {
            try {
                if (typeof XLSX === 'undefined') {
                    console.error('La librería XLSX no está cargada');
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'La librería XLSX no está disponible'
                    });
                    return;
                }

                const ws = XLSX.utils.json_to_sheet(data);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, 'Existencias');
                XLSX.writeFile(wb, filename);

                Swal.fire({
                    icon: 'success',
                    title: 'Excel generado correctamente',
                    text: 'El reporte se ha descargado exitosamente'
                });
            } catch (error) {
                console.error('Error en exportarexcel:', error);
                Swal.fire({
                    icon: 'error',
                    title: 'Error al generar Excel',
                    text: error.message || 'Error desconocido'
                });
            }
        }
    </script>
@stop
