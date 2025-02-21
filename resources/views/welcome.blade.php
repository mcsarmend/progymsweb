<!DOCTYPE html>
<html lang="es">

<head>

    <title>Grupo Progyms</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="shortcut icon" href="favicons/favicon.ico">
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- MAIN CSS -->
    <link rel="stylesheet" href="css/templatemo-style.css">

</head>

<style>
    .img-responsive {
        position: relative;
        bottom: 1em;
        padding-top: 87px;
        width: 365px;
        padding-right: 0px;
        padding-left: 7px;
    }

    @media screen and (max-width: 639px) {
        .media.blog-thumb .media-left img {
            position: relative;
            bottom: 6em;
            padding-top: 180px;
            width: 360px;
            padding-right: 20px;
            padding-left: 42px;
        }
    }


    .slider {

        width: 98%;

        overflow: hidden;
    }

    .slides {
        display: flex;
        transition: transform 0.5s ease;
    }

    .slide {
        width: 100%;
        /* Asegura que las imágenes ocupen todo el ancho del slider */
        height: auto;
    }

    button {
        position: absolute;

        z-index: 10;
        background-color: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
        font-size: 20px;
    }

    button:hover {
        background-color: rgba(0, 0, 0, 0.8);
    }

    .prev {
        left: 10px;
        transform: translateY(-230%);
    }

    .next {
        right: 10px;
        transform: translateY(-230%);
    }
</style>

<body>

    <br><br><br><br><br>

    <!-- MENU -->
    <section class="navbar custom-navbar navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <!-- Logo -->
                <img src="assets/images/logoSinC.png" height="91" width="367" alt="" />

                <!-- Botón de colapso (hamburguesa) para pantallas pequeñas -->
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

            <!-- Menú de navegación -->
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="section-btn"><a href="#" data-toggle="modal" data-target="#modal-form">Iniciar
                            Sesión</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-nav-first">
                    <li><a href="#home" class="smoothScroll">Inicio</a></li>
                    <li><a href="#about" class="smoothScroll">Nosotros</a></li>
                    <li><a href="#mostsell" class="smoothScroll">Mas Vendidos</a></li>
                    <li><a href="#products" class="smoothScroll">Productos</a></li>
                    <li><a href="#review" class="smoothScroll">Reseñas</a></li>
                    <li><a href="#contact" class="smoothScroll">Contacto</a></li>
                </ul>
            </div>
        </div>
    </section>


    <br><br>
    <!-- HOME -->
    <section id="home" data-stellar-background-ratio="0.5">
        br
        <div class="overlay"></div>
        <div class="container">
            <div class="slider">
                <div class="slides">

                    <img class="slide" src="assets/images/promos/02.jpeg" alt="Imagen 1">
                    <img class="slide" src="assets/images/promos/02.jpeg" alt="Imagen 2">


                </div>
                <button class="prev">❮</button>
                <button class="next">❯</button>
            </div>

        </div>
        </div>
    </section>



    <!-- PRODUCTOs -->

    <section id="products" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">

                <div class="col-md-12 col-sm-12">
                    <div class="section-title">
                        <h2>Catálogo</h2>
                    </div>
                </div>
            </div>
            <br>
            <p>Selecciona una categoria para filtrar</p>
            <div class="col">
                <select name="categories" categories="categories" class="form-control">
                    <option value="">Ninguna</option>
                    @foreach ($categories as $category)
                        <option value="{{ $category->nombre }}">{{ $category->nombre }}</option>
                    @endforeach
                </select>
            </div>

            <br><br>

            <div class="row">
                <table class="table table-hover" id="table-products">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Marca</th>
                            <th>Categoria</th>
                            <th>Público</th>
                            <th>Frecuente</th>
                            <th>Mayoreo</th>
                            <th>Distribuidor</th>
                            <th>Existencias</th>
                            <th>Almacenes</th>
                            <th>Ver imagen</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
        <br>

        <div class="row">
            <p>Todos los precios están sujetos a cambios sin previo aviso</p>

            <ul>
                <li><strong>Precio público</strong>: Clientes primerizos o que no se encuentren registrados en el
                    sistema</li>
                <li><strong>Precio frecuente</strong>: Clientes con compras mayores a **$1500** mensuales</li>
                <li><strong>Precio mayorista</strong>: Clientes con compras mayores a **$3000** mensuales</li>
                <li><strong>Precio distribuidor</strong>: Compras en una sola exhibición de más de **$3000**</li>
            </ul>
        </div>

    </section>


    <!-- CONTACT -->
    <section id="contact" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="section-title">
                        <h2>Contáctanos</h2>
                        <span class="line-bar">...</span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col home-info" style="text-align: center;">
                    <a href="https://wa.me/5215512415377" class="btn section-btn smoothScroll" target="_blank">
                        <i class="fab fa-whatsapp"></i> Viveros (Tlalnepantal)
                    </a>
                </div>
                <br>
                <div class="col home-info" style="text-align: center;">
                    <a href="https://wa.me/5215648149566" class="btn section-btn smoothScroll" target="_blank">
                        <i class="fab fa-whatsapp"></i> San Esteban (Naucalpan)
                    </a>
                </div>
                <br>
                <div class="col home-info" style="text-align: center;">
                    <a href="https://wa.me/5215578397643" class="btn section-btn smoothScroll" target="_blank">
                        <i class="fab fa-whatsapp"></i> Town Center (Nicolás Romero)
                    </a>
                </div>
                <br>
                <div class="col home-info" style="text-align: center;">
                    <a href="https://wa.me/5215531216226" class="btn section-btn smoothScroll" target="_blank">
                        <i class="fab fa-whatsapp"></i> Plaza Coacalco
                    </a>
                </div>
                <br>
                <div class="col home-info" style="text-align: center;">
                    <a href="https://wa.me/5215643018711" class="btn section-btn smoothScroll" target="_blank">
                        <i class="fab fa-whatsapp"></i> Villas de la Hacienda (Cuautitlan Izcalli)
                    </a>
                </div>
            </div>
        </div>
    </section>





    <!-- ABOUT -->
    <section id="about" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">

                <div class="col-md-5 col-sm-6">
                    <div class="about-info">
                        <div class="section-title">
                            <h2>La tienda #1 de la zona</h2>
                            <span class="line-bar">...</span>
                            <br>
                        </div>
                        <p>En PROGYMS, sabemos lo importante que es mantener un estilo de vida saludable
                            y alcanzar tus objetivos físicos. Por eso, ofrecemos una amplia gama de productos de alta
                            calidad que te ayudarán a mejorar tu rendimiento y bienestar. Desde proteínas y vitaminas
                            hasta equipamiento y accesorios de gimnasio, tenemos todo lo que necesitas para llevar tu
                            entrenamiento al siguiente nivel.</p>
                    </div>
                </div>

                <div class="col-md-4 col-sm-12">
                    <div class="about-image">
                        <img src="assets/images/fitnessperson.jpg" style="width: 90%; height: auto;" alt="">
                    </div>
                </div>

            </div>
        </div>
    </section>


    <!-- MAS VENDIDOS -->
    <section id="mostsell" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">

                <div class="col-md-12 col-sm-12">
                    <div class="section-title">
                        <h2>Más Vendidos</h2>
                        <span class="line-bar">...</span>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6">
                    <!-- BLOG THUMB -->
                    <div class="media blog-thumb">
                        <div class="media-object media-left">
                            <a><img src="assets/images/ryse.jpg" class="img-responsive" alt=""></a>
                        </div>
                        <div class="media-body blog-info">
                            <h4 style ="color: #ce3232;"><i class="fa fa-exclamation"></i> Ryse Ring Pop</h4>
                            <h3><a>¡Experimenta el poder de la ciencia y el sabor combinados!
                                </a></h3>
                            <p>RYSE Loaded Pre-Workout utiliza dosis clínicas de ingredientes respaldados por la
                                investigación para asegurarse de que está obteniendo el máximo provecho.</p>

                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6">
                    <!-- BLOG THUMB -->
                    <div class="media blog-thumb">
                        <div class="media-object media-left">
                            <a><img src="assets/images/ghostlegend.png" class="img-responsive" alt=""></a>
                        </div>
                        <div class="media-body blog-info">
                            <small><i class="fa fa-clock-o"></i>Ghost Legend</small>
                            <h3><a>Pre-entrenamiento legendario</a></h3>
                            <p>El pre-entrenamiento GHOST Legend V3 combina una fórmula de energía y enfoque destacada
                                con ingredientes de bomba premium en el icónico sabor Lemon Crush GHOST para que te
                                sientas como una leyenda.</p>

                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6">
                    <!-- BLOG THUMB -->
                    <div class="media blog-thumb">
                        <div class="media-object media-left">
                            <a><img src="assets/images/venominferno.png" class="img-responsive" alt=""></a>
                        </div>
                        <div class="media-body blog-info">
                            <small><i class="fa fa-clock-o"></i>Venom Inferno</small>
                            <h3><a>Un preentreno perfecto.</a></h3>
                            <p>Es el cóctel más explosivo de estimulantes de alta energía y refuerzos de óxido nítrico
                                jamás formulado.</p>

                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6">
                    <!-- BLOG THUMB -->
                    <div class="media blog-thumb">
                        <div class="media-object media-left">
                            <a><img src="assets/images/psycotic.png" class="img-responsive" alt=""></a>
                        </div>
                        <div class="media-body blog-info">
                            <p><i class="fa fa-clock-o"></i>Psycotic</p>
                            <h3><a>Producto mas vendido</a></h3>
                            <p>es un suplemento deportivo pre entrenamiento a base de estimulantes para utilizarse 20-30
                                minutos antes de tu entrenamiento</p>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>





    <!-- RESEÑAS -->



    <section id="review" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">

                <div class="col-md-12 col-sm-12">
                    <div class="section-title">
                        <h2>Reseñas</h2>

                        <span class="line-bar">...</span>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <!-- WORK THUMB -->
                    <div class="work-thumb">
                        <a href="assets/images/acero_gym.jpeg" class="image-popup">
                            <img src="assets/images/acero_gym.jpeg" class="img-responsive" alt="Work">

                            <div class="work-info">
                                <h3>Acero Gym</h3>
                                <small>
                                    Me encanta que siempre estén al tanto de las últimas tendencias y productos del
                                    mercado. Además, tienen cinco sucursales, lo cual es súper conveniente. ¡Sin duda,
                                    seguiré siendo cliente fiel </small>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <!-- WORK THUMB -->
                    <div class="work-thumb">
                        <a href="assets/images/iron_gym.jpeg" class="image-popup">
                            <img src="assets/images/iron_gym.jpeg" class="img-responsive" alt="Work">

                            <div class="work-info">
                                <h3>Iron Addicts</h3>
                                <small>El equipo es altamente capacitado y siempre me brinda excelentes recomendaciones
                                    sobre los productos ideales a utilizar. ¡Un lugar imprescindible para cualquier
                                    entusiasta del fitness!</small>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <!-- WORK THUMB -->
                    <div class="work-thumb">
                        <a href="assets/images/warriors-gym.png" class="image-popup">
                            <img src="assets/images/warriors-gym.png" class="img-responsive" alt="Work">

                            <div class="work-info">
                                <h3>Warriors Gym</h3>
                                <small>El personal es muy conocedor y siempre me dan buenos consejos sobre qué
                                    productos utilizar. ¡Una tienda indispensable para cualquier amante del
                                    fitness!</small>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <!-- WORK THUMB -->
                    <div class="work-thumb">
                        <a href="assets/images/espartanos-gym.png" class="image-popup">
                            <img src="assets/images/espartanos-gym.png" class="img-responsive" alt="Work">

                            <div class="work-info">
                                <h3>Espartanos Gym</h3>
                                <small>Su dedicación al cliente es incomparable y siempre salgo satisfecho con mis
                                    compras. ¡Altamente recomendados!</small>
                            </div>
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </section>




    <!-- FOOTER -->
    <footer data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row">

                <div class="col-md-5 col-sm-12">
                    <div class="footer-thumb footer-info">
                        <h2>Grupo Progyms</h2>
                        <p>Con 8 años de experiencia en el mercado,ProGyms se ha convertido en la referencia definitiva
                            para todos tus suplementos alimenticios y refacciones de gimnasio. Contamos con 5 sucursales
                            estratégicamente ubicadas para brindarte el mejor servicio.</p>
                    </div>
                </div>



                <div class="col-md-5 col-sm-4">
                    <div class="footer-thumb">
                        <h2>Servicio al cliente</h2>
                        <ul class="footer-link">
                            <li><a href="preguntasfrecuentes">Preguntas Frecuentes</a></li>
                            <li><a href="politicadeusodirigido">Política de uso dirigido</a></li>
                            <li><a href="politicaenvio">Política de envío y devoluciones</a></li>
                            <li><a href="politicaprivacidad">Política de privacidad</a></li>
                        </ul>
                    </div>
                </div>


                <div class="col-md-12 col-sm-12">
                    <div class="footer-bottom">
                        <div class="col-md-6 col-sm-5">
                            <div class="copyright-text">
                                <p id="copyright">Copyright &copy; <span id="current-year"></span>Grupo Progyms</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-7">

                            <ul class="social-icon">
                                <li><a href="https://www.facebook.com/grupoprogyms/" class="fa fa-facebook-square"
                                        attr="facebook icon"></a></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </footer>


    <!-- MODAL -->
    <section class="modal fade" id="modal-form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content modal-popup">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">

                            <div class="col-md-12 col-sm-12">
                                <div class="modal-title">
                                    <h2>Grupo Progyms</h2>
                                </div>

                                <!-- NAV TABS -->
                                <!-- TAB PANES -->
                                <div role="tabpanel" class="tab-pane fade in" id="sign_in">
                                    <form id="loginForm" action="{{ route('login') }}" method="post">
                                        @csrf
                                        <input type="email" class="form-control" name="email"
                                            placeholder="Email" value="{{ old('email') }}" required>
                                        <input type="password" class="form-control" name="password"
                                            placeholder="Password" required>
                                        <input type="submit" class="form-control" name="submit"
                                            value="Iniciar Sesión">
                                    </form>

                                    <div id="error-messages"></div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <div class="modal fade modal-almacenes" id="almacenes" tabindex="-1" role="dialog"
        aria-labelledby="almacenesCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content modal-almacenes-content">
                <div class="modal-header modal-almacenes-header">
                    <h5 class="modal-title modal-almacenes-title" id="almacenesLongTitle">Detalle de almacenes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body modal-almacenes-body">
                    <table id="almacenestabla" class="table table-striped table-almacenes">
                        <thead class="table-almacenes-header">
                            <tr>

                                <th>Almacen</th>
                                <th>Existencias</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="imagenModal" tabindex="-1" aria-labelledby="imagenModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-almacenes-header">
                    <h5 class="modal-title modal-almacenes-title" id="almacenesLongTitle">Imagen Descriptiva</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img src="assets/images/productos/11120003.png" alt="Imagen de ejemplo" class="img-fluid"
                        width="350" height="350" style="object-fit: contain;">
                    <p class="mensaje-error" style="display: none; color: red; font-weight: bold;">Imagen no
                        disponible</p>
                </div>

            </div>
        </div>
    </div>


    <!-- SCRIPTS -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/smoothscroll.js"></script>
    <script src="js/custom.js"></script>
    <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {



            $('#loginForm').submit(function(event) {
                event.preventDefault(); // Evita el comportamiento por defecto del formulario
                var form = $(this);
                var url = form.attr('action');

                $.ajax({
                    type: 'POST',
                    url: url,
                    data: form.serialize(),
                    success: function(data) {
                        // Redirigir si es exitoso
                        window.location.href = "/dashboard";
                    },
                    error: function(xhr) {
                        // Mostrar los errores
                        var errors = xhr.responseJSON.errors;
                        var errorMessages = '<div class="alert alert-danger"><ul>';
                        errorMessages += '</ul> Los datos de acceso son incorrectos</div>';
                        $('#error-messages').html(errorMessages);
                    }
                });
            });
            /* SLIDE*/
            let index = 0;
            const slides = $(".slide");
            const totalSlides = slides.length;

            function showSlide(i) {
                if (i >= totalSlides) {
                    index = 0;
                } else if (i < 0) {
                    index = totalSlides - 1;
                } else {
                    index = i;
                }
                $(".slides").css("transform", "translateX(" + (-index * 100) + "%)");
            }

            $(".next").click(function() {
                showSlide(index + 1);
            });

            $(".prev").click(function() {
                showSlide(index - 1);
            });

            setInterval(function() {
                showSlide(index + 1);
            }, 3000); // Cambia cada 3 segundos
            /* SLIDE*/

            /*TABLA PRODUCTOS*/

            var products = @json($products);

            $('#table-products').DataTable({
                destroy: true,
                scrollX: true,
                scrollCollapse: true,
                "language": {
                    "url": "{{ asset('js/datatables/lang/Spanish.json') }}"
                },
                dom: 'Blfrtip',
                processing: true,
                sort: true,
                paging: true,
                lengthMenu: [
                    [10, 25, 50, -1],
                    [10, 25, 50, 'All']
                ],
                "data": products,
                "columns": [{
                        "data": "producto"
                    },
                    {
                        "data": "marca"
                    },
                    {
                        "data": "categoria"
                    },
                    {
                        "data": "publico",
                        "render": function(data) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "frecuente",
                        "render": function(data) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "mayoreo",
                        "render": function(data) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "distribuidor",
                        "render": function(data) {
                            return '$' + data;
                        }
                    },
                    {
                        "data": "existencias"
                    },
                    // Almacenes
                    {
                        "data": "codigo",
                        "render": function(data) {
                            return `<button class="btn btn-primary btn-sm btn-ver-almacenes" data-codigo="${data}">Ver</button>`;
                        }
                    },
                    // Imagenes
                    {
                        "data": "codigo",
                        "render": function(data) {
                            if (data === undefined || data === null) {
                                return '';
                            }
                            return `<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#imagenModal" data-codigo="${data}">Ver Imagen</button>`;
                        }
                    }


                ],
                initComplete: function() {
                    console.log("DataTable inicializado con los siguientes datos:", this.api().data()
                        .toArray());
                }
            });


            $('#table-products tbody').on('click', '.btn-ver-almacenes', function() {
                const codigo = $(this).data('codigo'); // Obtener el código del atributo data-codigo
                veralmacenes(codigo); // Llamar a la función con el código específico
            });

            $('#imagenModal').on('show.bs.modal', function(event) {
                var button = $(event.relatedTarget); // Botón que abrió el modal
                var codigo = button.data('codigo'); // Extrae el valor de data-codigo

                var modal = $(this);
                var img = modal.find('img');

                // Actualiza el src de la imagen
                img.attr('src', 'assets/images/productos/' + codigo + '.png').show();

                // Oculta el mensaje de "Imagen no disponible" inicialmente
                modal.find('.mensaje-error').hide();

                // Si la imagen no carga, muestra el mensaje
                img.on('error', function() {
                    img.hide(); // Oculta la imagen
                    modal.find('.mensaje-error').show(); // Muestra el mensaje de error
                });
            });




            /*TABLA PRODUCTOS*/

            // Evento change en el select
            $('select[name="categories"]').on('change', function() {
                // Limpia el filtro de búsqueda del DataTable
                var table = $('#table-products').DataTable();
                // table.search('').draw(); // Limpiar el filtro de búsqueda

                // Filtra los datos por la categoría seleccionada
                var selectedValue = $(this).val();

                // Aplicar el filtro a la columna correspondiente
                table.column(2).search(selectedValue)
                    .draw(); // Suponiendo que la columna "categoria" es la columna 2
            });




            document.addEventListener('DOMContentLoaded', (event) => {
                var currentYear = new Date().getFullYear();
                document.getElementById('current-year').textContent = currentYear;
            });




        });

        function veralmacenes(id) {
            $('#almacenes').modal('show');

            $.ajax({
                url: 'detalleamacenes', // URL de la solicitud
                type: 'GET',
                data: {
                    id_producto: id
                },
                dataType: 'json',
                success: function(data) {
                    // Primero destruye la tabla existente
                    $('#almacenestabla').DataTable().clear().destroy();

                    // Ahora inicializa la tabla con los datos recibidos
                    $('#almacenestabla').DataTable({
                        destroy: true,
                        data: data,
                        columns: [{
                                data: 'nombre'
                            },
                            {
                                data: 'existencias'
                            }
                        ]
                    });
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        }
    </script>
</body>

</html>
