<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Progyms</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500&family=Jost:wght@500;600;700&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body data-bs-spy="scroll" data-bs-target=".navbar" data-bs-offset="51">
    <div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner"
            class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar & Hero Start -->
        <div class="container-xxl position-relative p-0" id="Inicio">
            <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
                <a href="" class="navbar-brand p-0">
                    <h1 class="m-0">Progyms</h1>
                    <!-- <img src="img/logo.png" alt="Logo"> -->
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav mx-auto py-0">
                        <a href="#Inicio" class="nav-item nav-link active">Inicio</a>
                        <a href="#about" class="nav-item nav-link">Acerca de nosotros</a>
                        <a href="#pricing" class="nav-item nav-link">Precios</a>
                        <a href="#review" class="nav-item nav-link">Reseñas</a>
                        <a href="#contact" class="nav-item nav-link">Contacto</a>

                    </div>
                    <a href="{{ route('login') }}"
                        class="btn btn-primary-gradient rounded-pill py-2 px-4 ms-3 d-none d-lg-block">Log in</a>
                </div>
            </nav>

            <div class="container-xxl bg-primary hero-header">
                <div class="container px-lg-5">
                    <div class="row g-5">
                        <div class="col-lg-8 text-center text-lg-start">
                            <h1 class="text-white mb-4 animated slideInDown">PROGYMS: La Revolucionaria Tienda para tu
                                Bienestar Físico</h1>
                            <p class="text-white pb-3 animated slideInDown">Con 8 años de experiencia en el mercado,
                                ProGyms se ha convertido en la referencia definitiva para todos tus suplementos
                                alimenticios y refacciones de gimnasio. Contamos con 5 sucursales estratégicamente
                                ubicadas para brindarte el mejor servicio.</p>
                            <a href="#contact"
                                class="btn btn-secondary-gradient py-sm-3 px-4 px-sm-5 rounded-pill animated slideInRight">Contactanos</a>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                            <br>
                        </div>
                        <br>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 d-flex justify-content-center justify-content-lg-end wow fadeInUp"
                data-wow-delay="0.3s">
                <div class="owl-carousel screenshot-carousel">
                    <img class="img-fluid" src="img/screenshot-1.png" alt="">
                    <img class="img-fluid" src="img/screenshot-2.png" alt="">
                    <img class="img-fluid" src="img/screenshot-3.png" alt="">
                    <img class="img-fluid" src="img/screenshot-4.png" alt="">
                    <img class="img-fluid" src="img/screenshot-5.png" alt="">
                </div>
            </div>
        </div>
        <!-- Navbar & Hero End -->


        <!-- About Start -->
        <div class="container-xxl py-5" id="about">
            <div class="container py-5 px-lg-5">
                <div class="row g-5 align-items-center">
                    <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
                        <h1 class="mb-4">La tienda #1 de la zona metropolitana</h1>
                        <p class="mb-4">En PROGYMS, sabemos lo importante que es mantener un estilo de vida saludable
                            y alcanzar tus objetivos físicos. Por eso, ofrecemos una amplia gama de productos de alta
                            calidad que te ayudarán a mejorar tu rendimiento y bienestar. Desde proteínas y vitaminas
                            hasta equipamiento y accesorios de gimnasio, tenemos todo lo que necesitas para llevar tu
                            entrenamiento al siguiente nivel.</p>
                        <div class="row g-4 mb-4">
                            <div class="col-sm-6 wow fadeIn" data-wow-delay="0.5s">
                                <div class="d-flex">
                                    <i class="fa fa-cogs fa-2x text-primary-gradient flex-shrink-0 mt-1"></i>
                                    <h2 class="mb-0"> +</h2>
                                    <div class="ms-3">

                                        <h2 class="mb-0" data-toggle="counter-up">+500</h2>
                                        <p class="text-primary-gradient mb-0">Productos</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 wow fadeIn" data-wow-delay="0.7s">
                                <div class="d-flex">
                                    <i class="fa fa-comments fa-2x text-secondary-gradient flex-shrink-0 mt-1"></i>
                                    <h2 class="mb-0"> +</h2>
                                    <div class="ms-3">

                                        <h2 class="mb-0" data-toggle="counter-up">100</h2>
                                        <p class="text-secondary-gradient mb-0">Clientes activos</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="" class="btn btn-primary-gradient py-sm-3 px-4 px-sm-5 rounded-pill mt-3">Read
                            More</a>
                    </div>
                    <div class="col-lg-6">
                        <img class="img-fluid wow fadeInUp" data-wow-delay="0.5s" src="img/about.png">
                    </div>
                </div>
            </div>
        </div>
        <!-- About End -->


        <!-- Pricing Start -->
        <div class="container-xxl py-5" id="pricing">
            <div class="container py-5 px-lg-5">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="text-primary-gradient fw-medium">Tipos de precio</h5>
                    <h1 class="mb-5">Elige tus descuentos</h1>
                </div>
                <div class="tab-class text-center pricing wow fadeInUp" data-wow-delay="0.1s">
                    <div class="tab-content text-start">
                        <div id="tab-1" class="tab-pane fade show p-0 active">
                            <div class="row g-4">
                                <div class="col-lg-4">
                                    <div class="bg-light rounded">
                                        <div class="border-bottom p-4 mb-4">
                                            <h4 class="text-primary-gradient mb-1">Precio Publico</h4>
                                            <span>Cualquier compra realizada en mostrador</span>
                                        </div>
                                        <div class="p-4 pt-0">

                                            <div class="d-flex justify-content-between mb-3"><span>HELLBOY AMINO 30
                                                    SERV INS</span><small
                                                    class="d-flex justify-content-between mb-3">$420</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3"><span> PSYCHOTIC SAW
                                                    SERIES 30 SERV</span><small
                                                    class="d-flex justify-content-between mb-3">$510</small>
                                            </div>
                                            <a href="https://wa.me/5215512415377"
                                                class="btn btn-primary-gradient rounded-pill py-2 px-4 mt-4"
                                                target="_blank">
                                                <i class="fab fa-whatsapp"></i> Contactanos
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="bg-light rounded border">
                                        <div class="border-bottom p-4 mb-4">
                                            <h4 class="text-primary-gradient mb-1">Precio Frecuente</h4>
                                            <span>Compras entre $1 a $1500 en un mes y contando con historial con
                                                nostros</span>
                                        </div>
                                        <div class="p-4 pt-0">
                                            <div class="d-flex justify-content-between mb-3"><span>HELLBOY AMINO 30
                                                    SERV INS</span><small
                                                    class="d-flex justify-content-between mb-3">$390</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3"><span> PSYCHOTIC SAW
                                                    SERIES 30 SERV</span><small
                                                    class="d-flex justify-content-between mb-3">$480</small>
                                            </div>
                                            <a href="https://wa.me/5215512415377"
                                                class="btn btn-primary-gradient rounded-pill py-2 px-4 mt-4"
                                                target="_blank">
                                                <i class="fab fa-whatsapp"></i> Contactanos
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="bg-light rounded">
                                        <div class="border-bottom p-4 mb-4">
                                            <h4 class="text-primary-gradient mb-1">Precio Mayoreo</h4>
                                            <span>Compras de entre $1501 a $3000 y contando con historial con
                                                nostros</span>
                                        </div>
                                        <div class="p-4 pt-0">
                                            <div class="d-flex justify-content-between mb-3"><span>HELLBOY AMINO 30
                                                    SERV INS</span><small
                                                    class="d-flex justify-content-between mb-3">$360</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3"><span> PSYCHOTIC SAW
                                                    SERIES 30 SERV</span><small
                                                    class="d-flex justify-content-between mb-3">$450</small>
                                            </div>
                                            <a href="https://wa.me/5215512415377"
                                                class="btn btn-primary-gradient rounded-pill py-2 px-4 mt-4"
                                                target="_blank">
                                                <i class="fab fa-whatsapp"></i> Contactanos
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="bg-light rounded">
                                        <div class="border-bottom p-4 mb-4">
                                            <h4 class="text-primary-gradient mb-1">Precio Distribuidor</h4>
                                            <span>Compras de entre superiores a $3000 y contando con historial con
                                                nostros</span>
                                        </div>
                                        <div class="p-4 pt-0">
                                            <div class="d-flex justify-content-between mb-3"><span>HELLBOY AMINO 30
                                                    SERV INS</span><small
                                                    class="d-flex justify-content-between mb-3">$330</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3"><span> PSYCHOTIC SAW
                                                    SERIES 30 SERV</span><small
                                                    class="d-flex justify-content-between mb-3">$420</small>
                                            </div>
                                            <a href="https://wa.me/5215512415377"
                                                class="btn btn-primary-gradient rounded-pill py-2 px-4 mt-4"
                                                target="_blank">
                                                <i class="fab fa-whatsapp"></i> Contactanos
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Pricing End -->


        <!-- Testimonial Start -->
        <div class="container-xxl py-5" id="review">
            <div class="container py-5 px-lg-5">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="text-primary-gradient fw-medium">Testimonios</h5>
                    <h1 class="mb-5">¡Qué dicen nuestros clientes!</h1>
                </div>
                <div class="owl-carousel testimonial-carousel wow fadeInUp" data-wow-delay="0.1s">
                    <div class="testimonial-item rounded p-4">
                        <div class="d-flex align-items-center mb-4">
                            <img class="img-fluid bg-white rounded flex-shrink-0 p-1"
                                src="assets/images/acero_gym.jpg" style="width: 85px; height: 85px;">
                            <div class="ms-4">
                                <h5 class="mb-1">Acero Gym</h5>
                                <div>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                </div>
                            </div>
                        </div>
                        <p class="mb-0">PROGYMS es mi tienda de confianza para todos mis suplementos alimenticios y
                            equipo de gimnasio. La variedad de productos es impresionante y siempre encuentro lo que
                            necesito.</p>
                    </div>
                    <div class="testimonial-item rounded p-4">
                        <div class="d-flex align-items-center mb-4">
                            <img class="img-fluid bg-white rounded flex-shrink-0 p-1" src="assets/images/iron_gym.jpg"
                                style="width: 85px; height: 85px;">
                            <div class="ms-4">
                                <h5 class="mb-1">IRON ADDICTS</h5>
                                <div>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                </div>
                            </div>
                        </div>
                        <p class="mb-0">Me encanta que siempre estén al tanto de las últimas tendencias y productos
                            del mercado. Además, tienen cinco sucursales, lo cual es súper conveniente. ¡Sin duda,
                            seguiré siendo cliente fiel!</p>
                    </div>
                    <div class="testimonial-item rounded p-4">
                        <div class="d-flex align-items-center mb-4">
                            <img class="img-fluid bg-white rounded flex-shrink-0 p-1"
                                src="assets/images/muscle_gym.jpg" style="width: 85px; height: 85px;">
                            <div class="ms-4">
                                <h5 class="mb-1">MUSCLE POWER GYM</h5>
                                <div>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                </div>
                            </div>
                        </div>
                        <p class="mb-0">El personal es muy conocedor y siempre me dan buenos consejos sobre qué
                            productos utilizar. ¡Una tienda indispensable para cualquier amante del fitness!</p>
                    </div>
                    <div class="testimonial-item rounded p-4">
                        <div class="d-flex align-items-center mb-4">
                            <img class="img-fluid bg-white rounded flex-shrink-0 p-1" src="assets/images/mondeles.jpg"
                                style="width: 85px; height: 85px;">
                            <div class="ms-4">
                                <h5 class="mb-1">Mondelez</h5>
                                <div>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                    <small class="fa fa-star text-warning"></small>
                                </div>
                            </div>
                        </div>
                        <p class="mb-0">Su dedicación al cliente es incomparable y siempre salgo satisfecho con mis
                            compras. ¡Altamente recomendados!</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Testimonial End -->


        <!-- Contact Start -->
        <div class="container-xxl py-5" id="contact">
            <div class="container py-5 px-lg-5">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="text-primary-gradient fw-medium">Contactanos</h5>
                    <h1 class="mb-5">!Escribenos un mensaje!</h1>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="col-12 text-center">
                            <a href="https://wa.me/5215512415377" class="whatsapp-button" target="_blank">
                                <i class="fab fa-whatsapp"></i> Progyms Viveros
                            </a>
                        </div>
                    </div>
                    <div class="col">
                        <div class="col-12 text-center">
                            <a href="https://wa.me/5215578397643" class="whatsapp-button" target="_blank">
                                <i class="fab fa-whatsapp"></i> Progyms Nicolás Romero
                            </a>
                        </div>
                    </div>
                    <div class="col">
                        <div class="col-12 text-center">
                            <a href="https://wa.me/5215531216226" class="whatsapp-button" target="_blank">
                                <i class="fab fa-whatsapp"></i> Progyms Coacalco
                            </a>
                        </div>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col">
                        <div class="col-12 text-center">
                            <a href="https://wa.me/5214423658824" class="whatsapp-button" target="_blank">
                                <i class="fab fa-whatsapp"></i> Progyms Queretaro
                            </a>
                        </div>
                    </div>
                    <div class="col">
                        <div class="col-12 text-center">
                            <a href="https://wa.me/5215639037435" class="whatsapp-button" target="_blank">
                                <i class="fab fa-whatsapp"></i> Progyms Naucalpan
                            </a>
                        </div>
                    </div>
                    <div class="col">
                        <div class="col-12 text-center">
                            <a href="https://wa.me/5215531216226" class="whatsapp-button" target="_blank">
                                <i class="fab fa-whatsapp"></i> Progyms Villas de la Hacienda
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- Contact End -->


        <!-- Footer Start -->
        <div class="container-fluid bg-primary text-light footer wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5 px-lg-5">
                <div class="row g-5">
                    <div class="col-md-6 col-lg-3">
                        <h4 class="text-white mb-4">Dirección</h4>
                        <p><i class="fa fa-map-marker-alt me-3"></i>Viveros de Asís 1-b, Viveros de la Loma, 54080
                            Tlalnepantla, Méx.</p>
                        <p><i class="fa fa-phone-alt me-3"></i>55 6834 1113</p>
                        <p><i class="fa fa-envelope me-3"></i>info@example.com</p>
                        {{--                         <div class="d-flex pt-2">
                            <a class="btn btn-outline-light btn-social" href=""><i
                                    class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i
                                    class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i
                                    class="fab fa-instagram"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i
                                    class="fab fa-linkedin-in"></i></a>
                        </div> --}}
                    </div>
                    {{--                     <div class="col-md-6 col-lg-3">
                        <h4 class="text-white mb-4">Quick Link</h4>
                        <a class="btn btn-link" href="">About Us</a>
                        <a class="btn btn-link" href="">Contact Us</a>
                        <a class="btn btn-link" href="">Privacy Policy</a>
                        <a class="btn btn-link" href="">Terms & Condition</a>
                        <a class="btn btn-link" href="">Career</a>
                    </div> --}}

                </div>
            </div>
            <div class="container px-lg-5">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#">Progyms</a>, Todos los derechos reservados.

                            <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                            Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                        {{--                         <div class="col-md-6 text-center text-md-end">
                            <div class="footer-menu">
                                <a href="">Inicio</a>
                                <a href="">Cookies</a>
                                <a href="">Help</a>
                                <a href="">FQAs</a>
                            </div>
                        </div> --}}
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-lg-square back-to-top pt-2"><i
                class="bi bi-arrow-up text-white"></i></a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>
