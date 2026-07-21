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

        /* Estilos extra para el formulario de contacto */
        .contact-section {
            padding: 60px 0;
            background-color: #f9f9f9;
        }

        .contact-card {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
            height: 100%;
        }

        .contact-card h4 {
            color: #1a6692;
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .contact-card .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .contact-card .info-item i {
            font-size: 22px;
            color: #f33f3f;
            width: 40px;
            margin-top: 2px;
        }

        .contact-card .info-item .info-text {
            flex: 1;
        }

        .contact-card .info-item .info-text strong {
            display: block;
            font-weight: 600;
            color: #1a1a1a;
        }

        .contact-card .info-item .info-text p {
            margin: 0;
            color: #666;
        }

        .contact-form input,
        .contact-form textarea {
            font-size: 14px;
            width: 100%;
            padding: 12px 18px;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 20px;
            transition: all 0.3s;
            font-family: "Poppins", sans-serif;
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            border-color: #f33f3f;
            box-shadow: 0 0 0 3px rgba(243, 63, 63, 0.1);
            outline: none;
        }

        .contact-form textarea {
            min-height: 130px;
            resize: vertical;
        }

        .contact-form .filled-button {
            background-color: #f33f3f;
            color: #fff;
            font-size: 14px;
            text-transform: capitalize;
            font-weight: 500;
            padding: 14px 30px;
            border-radius: 8px;
            display: inline-block;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        .contact-form .filled-button:hover {
            background-color: #121212;
            color: #fff;
        }

        /* Redes sociales en contacto */
        .social-contact {
            display: flex;
            gap: 15px;
            margin-top: 15px;
        }

        .social-contact a {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: #333;
            transition: all 0.3s;
        }

        .social-contact a:hover {
            background: #f33f3f;
            color: #fff;
            transform: translateY(-3px);
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

    <!-- BANNER DE CONTACTO -->
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

    <!-- SECCIÓN DE CONTACTO - FORMULARIO + INFORMACIÓN -->
    <div class="contact-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Escríbenos</h2>
                        <p style="color:#666;margin-top:-10px;">Estamos aquí para ayudarte, respóndemos en menos de 24
                            horas</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- FORMULARIO -->
                <div class="col-lg-7">
                    <div class="contact-card">
                        <h4><i class="fa fa-envelope" style="color:#f33f3f;margin-right:10px;"></i>Envíanos un mensaje
                        </h4>
                        <form class="contact-form" action="#" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" placeholder="Nombre completo" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="email" placeholder="Correo electrónico" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <input type="text" placeholder="Asunto">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <textarea placeholder="Cuéntanos cómo podemos ayudarte..." required></textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <button type="submit" class="filled-button">
                                        <i class="fa fa-paper-plane" style="margin-right:8px;"></i>Enviar mensaje
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- INFORMACIÓN DE CONTACTO -->
                <div class="col-lg-5">
                    <div class="contact-card">
                        <h4><i class="fa fa-phone" style="color:#f33f3f;margin-right:10px;"></i>Datos de contacto</h4>

                        <div class="info-item">
                            <i class="fa fa-map-marker"></i>
                            <div class="info-text">
                                <strong>Dirección</strong>
                                <p>Av. Principal #123,<br>Ciudad de México, CDMX</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <i class="fa fa-phone"></i>
                            <div class="info-text">
                                <strong>Teléfono</strong>
                                <p>+52 55 1234 5678</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <i class="fa fa-envelope"></i>
                            <div class="info-text">
                                <strong>Correo</strong>
                                <p>info@progyms.com</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <i class="fa fa-clock-o"></i>
                            <div class="info-text">
                                <strong>Horario de atención</strong>
                                <p>Lunes a Sábado: 9:00 AM - 8:00 PM<br>Domingo: 10:00 AM - 4:00 PM</p>
                            </div>
                        </div>

                        <div style="margin-top:20px;padding-top:20px;border-top:1px solid #eee;">
                            <strong style="display:block;margin-bottom:10px;">Síguenos en redes:</strong>
                            <div class="social-contact">
                                <a href="https://www.facebook.com/people/Progyms/61582073803156/?locale=es_LA"
                                    target="_blank"><i class="fa fa-facebook"></i></a>
                                <a href="https://www.instagram.com/gprogyms?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw=="
                                    target="_blank"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa fa-youtube"></i></a>
                                <a href="#"><i class="fa fa-tiktok"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- UBICACIÓN -->
    <div class="find-us" style="padding-top:0;">
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

    <!-- CLIENTES SATISFECHOS -->
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

            floatBtn.addEventListener('click', function(e) {
                e.preventDefault();
                modal.classList.add('active');
                document.body.style.overflow = 'hidden';
            });

            function closeModal() {
                modal.classList.remove('active');
                document.body.style.overflow = '';
            }

            closeBtn.addEventListener('click', closeModal);

            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    closeModal();
                }
            });

            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('active')) {
                    closeModal();
                }
            });

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
