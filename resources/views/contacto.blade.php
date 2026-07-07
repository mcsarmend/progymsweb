<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>PROGYMS | Contacto</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap"
        rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-sixteen.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="shortcut icon" href="favicons/favicon.ico">

    <style>
        /* ===== BOTÓN FLOTANTE WHATSAPP ===== */
        .whatsapp-float {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 9999;
            background: #25D366;
            color: #fff;
            width: 65px;
            height: 65px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
            box-shadow: 0 4px 20px rgba(37, 211, 102, 0.5);
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            outline: none;
            text-decoration: none;
        }

        .whatsapp-float:hover {
            transform: scale(1.12);
            background: #1da851;
            box-shadow: 0 6px 30px rgba(37, 211, 102, 0.7);
            color: #fff;
        }

        .whatsapp-float i {
            line-height: 1;
        }

        /* Pequeño badge con el número de sucursales */
        .whatsapp-badge {
            position: absolute;
            top: -6px;
            right: -6px;
            background: #ff4d4d;
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #fff;
        }

        /* ===== MODAL ===== */
        .whatsapp-modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }

        .whatsapp-modal.active {
            display: flex;
        }

        .whatsapp-modal-content {
            background: #fff;
            border-radius: 24px;
            max-width: 500px;
            width: 92%;
            padding: 30px 25px 25px;
            position: relative;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.4);
            animation: slideUp 0.35s ease;
            max-height: 90vh;
            overflow-y: auto;
        }

        .whatsapp-modal-close {
            position: absolute;
            top: 14px;
            right: 18px;
            font-size: 28px;
            font-weight: 300;
            color: #888;
            cursor: pointer;
            transition: color 0.2s;
            background: none;
            border: none;
            outline: none;
            line-height: 1;
        }

        .whatsapp-modal-close:hover {
            color: #222;
        }

        .whatsapp-modal-title {
            text-align: center;
            margin-bottom: 25px;
        }

        .whatsapp-modal-title i {
            color: #25D366;
            font-size: 38px;
            display: block;
            margin-bottom: 6px;
        }

        .whatsapp-modal-title h4 {
            font-weight: 700;
            color: #1a1a1a;
            margin: 0;
            font-size: 22px;
        }

        .whatsapp-modal-title p {
            color: #777;
            font-size: 14px;
            margin: 4px 0 0;
        }

        .whatsapp-btn-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .whatsapp-btn-list a {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            background: #f0f8f2;
            border-radius: 14px;
            color: #1a1a1a;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
            border: 1.5px solid transparent;
            font-size: 16px;
        }

        .whatsapp-btn-list a i {
            font-size: 28px;
            color: #25D366;
            margin-right: 16px;
            width: 32px;
            text-align: center;
        }

        .whatsapp-btn-list a:hover {
            background: #e2f3e6;
            border-color: #25D366;
            transform: translateX(4px);
            color: #1a1a1a;
        }

        .whatsapp-btn-list a .branch-tag {
            margin-left: auto;
            font-size: 12px;
            background: #25D366;
            color: #fff;
            padding: 3px 12px;
            border-radius: 30px;
            font-weight: 500;
        }

        /* ===== ANIMACIONES ===== */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes slideUp {
            from {
                transform: translateY(40px);
                opacity: 0;
            }

            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 576px) {
            .whatsapp-float {
                width: 56px;
                height: 56px;
                font-size: 30px;
                bottom: 20px;
                right: 20px;
            }

            .whatsapp-modal-content {
                padding: 22px 18px 20px;
            }

            .whatsapp-btn-list a {
                font-size: 14px;
                padding: 12px 16px;
            }

            .whatsapp-btn-list a i {
                font-size: 24px;
                margin-right: 12px;
                width: 28px;
            }

            .whatsapp-modal-title h4 {
                font-size: 19px;
            }
        }

        /* Ocultar la sección original de WhatsApp */
        .send-message .row .col-md-6.mb-4,
        .send-message .row .col-md-12.mt-3 {
            display: none !important;
        }

        /* Ocultar el título "Contacta a tu sucursal" de la sección original */
        .send-message .section-heading {
            display: none !important;
        }
    </style>
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
                    <h2>PRO<em>GYMS</em></h2>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link" href="{{ url('/') }}">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="{{ url('/productos') }}">Productos</a></li>
                        <li class="nav-item"><a class="nav-link" href="{{ url('/acerca') }}">Nosotros</a></li>
                        <li class="nav-item active"><a class="nav-link" href="{{ url('/contacto') }}">Contacto</a></li>
                        <li class="nav-item"><a class="nav-link" href="{{ url('/logininit') }}">Iniciar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- BANNER -->
    <div class="page-heading contact-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>PROGYMS</h4>
                        <h2>CONTÁCTANOS</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- UBICACIÓN -->
    <div class="find-us">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Nuestra Ubicación</h2>
                    </div>
                </div>
                <div class="col-md-8">
                    <div id="map">
                        <iframe
                            src="https://maps.google.com/maps?q=19.593965,-99.2530777&t=&z=17&ie=UTF8&iwloc=&output=embed"
                            width="100%" height="330" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="left-content">
                        <h4>PROGYMS</h4>
                        <p>
                            Somos una tienda especializada en suplementos deportivos. Ofrecemos proteínas, creatinas,
                            vitaminas, pre entrenos y asesoría para ayudarte a alcanzar tus objetivos.
                            <br><br>
                            Atención personalizada. Envíos locales. Productos originales.
                        </p>
                        <ul class="social-icons">
                            <li><a href="https://www.facebook.com/people/Progyms/61582073803156/?locale=es_LA"
                                    target="_blank"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="https://www.instagram.com/gprogyms?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw=="
                                    target="_blank"><i class="fa fa-instagram"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FORMULARIO (sección oculta visualmente pero mantenida para estructura) -->
    <div class="send-message">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Contacta a tu sucursal</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- Estos botones ahora están dentro del modal flotante -->
                <div class="col-md-6 mb-4 text-center">
                    <a href="https://wa.me/5215578397643" target="_blank" class="filled-button"
                        style="width:100%;padding:18px;display:block;">
                        <i class="fa fa-whatsapp" style="font-size:28px;margin-right:10px;"></i>
                        Town Center Nicolás Romero
                    </a>
                </div>
                <div class="col-md-6 mb-4 text-center">
                    <a href="https://wa.me/5215648149566" target="_blank" class="filled-button"
                        style="width:100%;padding:18px;display:block;">
                        <i class="fa fa-whatsapp" style="font-size:28px;margin-right:10px;"></i>
                        San Esteban Naucalpan
                    </a>
                </div>
                <div class="col-md-6 mb-4 text-center">
                    <a href="https://wa.me/5215531216226" target="_blank" class="filled-button"
                        style="width:100%;padding:18px;display:block;">
                        <i class="fa fa-whatsapp" style="font-size:28px;margin-right:10px;"></i>
                        Serviplaza Coacalco
                    </a>
                </div>
                <div class="col-md-6 mb-4 text-center">
                    <a href="https://wa.me/5215512415377" target="_blank" class="filled-button"
                        style="width:100%;padding:18px;display:block;">
                        <i class="fa fa-whatsapp" style="font-size:28px;margin-right:10px;"></i>
                        Bodega Atizapán
                    </a>
                </div>
                <div class="col-md-12 mt-3 text-center">
                    <a href="https://wa.me/5215665110366" target="_blank" class="filled-button"
                        style="padding:18px 40px;">
                        <i class="fa fa-whatsapp" style="font-size:28px;margin-right:10px;"></i>
                        Platinum
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- CLIENTES -->
    <div class="happy-clients">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Nuestros Clientes Satisfechos</h2>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="owl-clients owl-carousel">
                        <div class="client-item"><img src="assets/images/espartanos-gym.png"></div>
                        <div class="client-item"><img src="assets/images/iron_gym.png"></div>
                        <div class="client-item"><img src="assets/images/mondeles.png"></div>
                        <div class="client-item"><img src="assets/images/muscle_gym.png"></div>
                        <div class="client-item"><img src="assets/images/acero_gym.png"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="inner-content">
                        <p>Copyright © 2026 PROGYMS | Suplementación Deportiva Premium</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

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

            // Cerrar al hacer clic en un enlace (opcional: se cierra después de redirigir)
            // Los enlaces ya abren en nueva pestaña, no es necesario cerrar, pero lo hacemos por si acaso
            const links = modal.querySelectorAll('a');
            links.forEach(link => {
                link.addEventListener('click', function() {
                    // Pequeño delay para que el modal no se cierre antes de la redirección
                    setTimeout(closeModal, 300);
                });
            });
        })();

        // ===== PRELOADER (mantenido del original) =====
        // (El preloader ya está manejado por custom.js)
    </script>
</body>

</html>
