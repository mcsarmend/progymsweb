<!-- index.html -->
<!-- PROGYMS - Basado en TemplateMo Sixteen Clothing -->
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>PROGYMS | Suplementación Deportiva</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap"
        rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-sixteen.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="shortcut icon" href="favicons/favicon.ico">
</head>

<body>
    <!-- PRELOADER -->
    <div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <!-- HEADER -->
    <header>
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="{{ url('/') }}">
                    <h2>
                        PRO
                        <em>GYMS</em>
                    </h2>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="{{ url('/') }}">
                                Inicio
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/productos') }}">
                                Productos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/acerca') }}">
                                Nosotros
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/contacto') }}">
                                Contacto
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/logininit') }}">
                                Iniciar Sesión
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <!-- BANNER -->
    <div class="banner header-text">
        <div class="owl-banner owl-carousel">
            <div class="banner-item-01">
                <div class="text-content">
                    <h4>
                        PROTEÍNAS PREMIUM
                    </h4>
                    <h2>
                        Transforma tu rendimiento
                    </h2>
                </div>
            </div>
            <div class="banner-item-02">
                <div class="text-content">
                    <h4>
                        CREATINAS Y AMINOS
                    </h4>
                    <h2>
                        Máxima fuerza y recuperación
                    </h2>
                </div>
            </div>
            <div class="banner-item-03">
                <div class="text-content">
                    <h4>
                        PRE ENTRENO
                    </h4>
                    <h2>
                        Energía para cada sesión
                    </h2>
                </div>
            </div>
        </div>
    </div>
    <!-- PRODUCTOS DESTACADOS -->
    <div class="latest-products">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>
                            Productos Destacados
                        </h2>
                        <a href="{{ url('/productos') }}">
                            Ver catálogo completo
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </div>
                </div>
                <!-- PRODUCTO 1 -->
                <div class="col-md-4">
                    <div class="product-item">
                        <a href="#">
                            <img src="assets/images/goldstandard.jpeg">
                        </a>
                        <div class="down-content">
                            <a href="#">
                                <h4>
                                    Gold Standard 5.6Lb
                                </h4>
                            </a>
                            <h6>
                                $1,290 MXN
                            </h6>
                            <p>
                                24 gramos de proteína por servicio.Ideal para ganar masa muscular.
                            </p>
                            <ul class="stars">
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                            </ul>
                            <span></span>
                        </div>
                    </div>
                </div>
                <!-- PRODUCTO 2 -->
                <div class="col-md-4">
                    <div class="product-item">
                        <a href="#">
                            <img src="assets/images/creatinaxs.jpeg">
                        </a>
                        <div class="down-content">
                            <a href="#">
                                <h4>
                                    Creatina XS 1kg Ronnie
                                </h4>
                            </a>
                            <h6>
                                $450 MXN
                            </h6>
                            <p>
                                Incrementa fuerza,potencia y recuperación.
                            </p>
                            <ul class="stars">
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                            </ul>
                            <span></span>
                        </div>
                    </div>
                </div>
                <!-- PRODUCTO 3 -->
                <div class="col-md-4">
                    <div class="product-item">
                        <a href="#">
                            <img src="assets/images/monster.jpeg">
                        </a>
                        <div class="down-content">
                            <a href="#">
                                <h4>
                                    Monster 473
                                </h4>
                            </a>
                            <h6>
                                $30 MXN
                            </h6>
                            <p>
                                Energía instantánea, mayor concentración y resistencia para afrontar cualquier reto.
                            </p>
                            <ul class="stars">
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                                <li>
                                    <i class="fa fa-star"></i>
                                </li>
                            </ul>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- NOSOTROS -->
    <div class="best-features">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>
                            ¿Por qué elegir PROGYMS?
                        </h2>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="left-content">
                        <h4>
                            Tu aliado en nutrición deportiva
                        </h4>
                        <p>
                            En PROGYMS ofrecemos suplementos originales de las mejores marcas internacionales.
                            <br>
                            <br>
                            Nuestro objetivo es ayudarte a desarrollar músculo, mejorar tu rendimiento y alcanzar tus
                            metas fitness.
                        </p>
                        <ul class="featured-list">
                            <li>
                                <a href="#">
                                    Proteínas Premium
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Creatinas Micronizadas
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Pre Entrenos
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Aminoácidos BCAA
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Asesoría personalizada
                                </a>
                            </li>
                        </ul>

                        <a class="filled-button" href="{{ url('/contacto') }}">
                            Conócenos
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="right-image">
                        <img src="assets/images/feature-image.jpg">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- CTA -->
    <div class="call-to-action">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="inner-content">
                        <div class="row">
                            <div class="col-md-8">
                                <h4>
                                    Comienza hoy tu transformación con
                                    <em>PROGYMS</em>
                                </h4>
                                <p>
                                    Proteínas, creatinas, aminoácidos y suplementos originales con envíos a todo México.
                                </p>
                            </div>
                            <div class="col-md-4">
                                <a href="{{ url('/productos') }}" class="filled-button">
                                    Comprar Ahora
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== BOTÓN FLOTANTE WHATSAPP ===== -->
    <button class="whatsapp-float" id="whatsappFloatBtn" aria-label="Contactar por WhatsApp">
        <i class="fa fa-whatsapp"></i>
        <span class="whatsapp-badge">5</span>
    </button>

    <!-- ===== MODAL WHATSAPP ===== -->
    <div class="whatsapp-modal" id="whatsappModal">
        <div class="whatsapp-modal-content">
            <button class="whatsapp-modal-close" id="whatsappModalClose">&times;</button>
            <div class="whatsapp-modal-title">
                <i class="fa fa-whatsapp"></i>
                <h4>Contacta tu sucursal</h4>
                <p>Elige la ubicación más cercana</p>
            </div>
            <div class="whatsapp-btn-list">
                <a href="https://wa.me/5215578397643" target="_blank">
                    <i class="fa fa-whatsapp"></i>
                    Town Center Nicolás Romero
                    <span class="branch-tag">NR</span>
                </a>
                <a href="https://wa.me/5215648149566" target="_blank">
                    <i class="fa fa-whatsapp"></i>
                    San Esteban Naucalpan
                    <span class="branch-tag">Naucalpan</span>
                </a>
                <a href="https://wa.me/5215531216226" target="_blank">
                    <i class="fa fa-whatsapp"></i>
                    Serviplaza Coacalco
                    <span class="branch-tag">Coacalco</span>
                </a>
                <a href="https://wa.me/5215512415377" target="_blank">
                    <i class="fa fa-whatsapp"></i>
                    Bodega Atizapán
                    <span class="branch-tag">Atizapán</span>
                </a>
                <a href="https://wa.me/5215665110366" target="_blank">
                    <i class="fa fa-whatsapp"></i>
                    Platinum
                    <span class="branch-tag">Platinum</span>
                </a>
            </div>
        </div>
    </div>
    <!-- FOOTER -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="inner-content">
                        <p>
                            Copyright © 2026 PROGYMS
                            <br>
                            Accesorios y Suplementos para gyimnasio
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/custom.js"></script>
    <script src="assets/js/owl.js"></script>
    <script src="assets/js/slick.js"></script>
    <script src="assets/js/isotope.js"></script>
    <script src="assets/js/accordions.js"></script>
    <script>
        // ===== CONTROL DEL MODAL =====
        (function() {
            const floatBtn = document.getElementById('whatsappFloatBtn');
            const modal = document.getElementById('whatsappModal');
            const closeBtn = document.getElementById('whatsappModalClose');

            // Abrir modal
            floatBtn.addEventListener('click', function(e) {
                e.preventDefault();
                modal.classList.add('active');
                document.body.style.overflow = 'hidden';
            });

            // Cerrar modal
            function closeModal() {
                modal.classList.remove('active');
                document.body.style.overflow = '';
            }

            closeBtn.addEventListener('click', closeModal);

            // Cerrar al hacer clic fuera del contenido
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    closeModal();
                }
            });

            // Cerrar con tecla ESC
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('active')) {
                    closeModal();
                }
            });

            // Cerrar al hacer clic en un enlace
            const links = modal.querySelectorAll('a');
            links.forEach(link => {
                link.addEventListener('click', function() {
                    setTimeout(closeModal, 300);
                });
            });
        })();
    </script>
</body>



</html>
