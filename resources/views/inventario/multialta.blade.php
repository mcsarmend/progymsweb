@extends('adminlte::page')

@section('title', 'Multi Ingreso')

@section('content_header')

@stop

@section('content')
    <div class="card">

        <div class="card-body">
            <div class="card">
                <div class="card-header">
                    <h1>Multi Alta Productos Almacén</h1>
                </div>
                <div class="card-body">


                    <div class="row section" style="display: flex; flex-direction: column-reverse;">
                        <div class="col-md-8 col-sm-6 mb-3 center-form">
                            <form id="subirmultiproducto">
                                <div class="input-group mb-3 fomr-control">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="excelsubirmultiproducto"
                                            accept=".xlsx, .xls">
                                        <label class="custom-file-label-subirmultiproducto"
                                            for="excelsubirmultiproducto">Seleccionar archivo...</label>
                                    </div>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-primary w-100" type="submit">Subir
                                            Productos</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    @include('fondo')
@stop

@section('css')

@stop

@section('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.70/jquery.blockUI.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/xlsx@0.17.0/dist/xlsx.full.min.js"></script>
    <script>
        $(document).ready(function() {
            drawTriangles();
            showUsersSections();
        });

        /* SUBIR Multi Producto*/
        const form_subirmultiproducto = document.getElementById('subirmultiproducto');
        const fileInput_subirmultiproducto = document.getElementById('excelsubirmultiproducto');
        const fileInputLabel_subirmultiproducto = document.querySelector('.custom-file-label-subirmultiproducto');
        fileInput_subirmultiproducto.addEventListener('change', () => {
            name = fileInput_subirmultiproducto.files[0]?.name;
            if (name.substring(name.length - 3, name.length) == 'xls' || name.substring(name.length - 4, name
                    .length) == 'xlsx') {
                fileInputLabel_subirmultiproducto.textContent = fileInput_subirmultiproducto.files[0]?.name ||
                    'Seleccionar archivo';
            } else {
                fileInput_subirmultiproducto.value = "";
                Swal.fire({
                    icon: 'error',
                    title: 'El archivo no es un     ',
                });

            }
        });

        form_subirmultiproducto.addEventListener('submit', (e) => {
            e.preventDefault();
            $.blockUI({
                message: 'Cargando...',
                css: {
                    border: 'none',
                    padding: '15px',
                    backgroundColor: 'rgba(0, 0, 0, 0.5)',
                    color: '#fff',
                    'border-radius': '5px',
                    fontSize: '18px',
                    fontWeight: 'bold',
                }
            });
            const file = fileInput_subirmultiproducto.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const data = new Uint8Array(e.target.result);
                    const workbook = XLSX.read(data, {
                        type: 'array'
                    });
                    const worksheet = workbook.Sheets[workbook.SheetNames[0]];

                    const jsonData = XLSX.utils.sheet_to_json(worksheet, {
                        header: 1,
                        defval: '',
                        range: 1
                    });
                    jsonData.splice(0, 3);
                    $.unblockUI();

                    $.ajax({
                        url: "multialtaproducto",
                        method: "POST",
                        dataType: "JSON",
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        data: {
                            "data": jsonData
                        },
                        success: function(data) {

                            $.unblockUI();

                            Swal.fire({
                                icon: 'success',
                                title: 'Gracias por esperar',
                                text: data.message,

                            });
                        },
                        error: function(data) {
                            $.unblockUI();
                            Swal.fire({
                                icon: 'error',
                                title: 'Encontramos un error...',
                                text: data.message,
                            });
                        }
                    });
                };

                reader.readAsArrayBuffer(file);
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'No se ha seleccionado ningun archivo',

                });
            }
        });
    </script>
@stop
