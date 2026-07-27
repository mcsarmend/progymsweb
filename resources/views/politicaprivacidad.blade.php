<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>PROGYMS | Política de Privacidad</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap"
        rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-sixteen.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="shortcut icon" href="favicons/favicon.ico">

    <style>
        /* Estilos para la página de políticas */
        .policy-section {
            padding: 100px 0 60px 0;
        }

        .policy-section .section-heading {
            margin-bottom: 40px;
        }

        .policy-section .section-heading h2 {
            font-size: 32px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .policy-section .section-heading p {
            color: #666;
            font-size: 16px;
            margin-top: 5px;
        }

        .policy-card {
            background: #fff;
            border-radius: 12px;
            padding: 35px 40px;
            margin-bottom: 30px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.06);
            border-left: 4px solid #f33f3f;
        }

        .policy-card h3 {
            font-size: 20px;
            font-weight: 600;
            color: #1a6692;
            margin-bottom: 18px;
        }

        .policy-card h3 i {
            color: #f33f3f;
            margin-right: 12px;
        }

        .policy-card p {
            color: #4a4a4a;
            line-height: 1.8;
            font-size: 15px;
            margin-bottom: 12px;
        }

        .policy-card ul {
            padding-left: 20px;
            margin-bottom: 15px;
        }

        .policy-card ul li {
            color: #4a4a4a;
            line-height: 1.8;
            font-size: 15px;
            margin-bottom: 6px;
            list-style: disc;
        }

        .policy-card ul li strong {
            color: #1a1a1a;
        }

        .policy-card .highlight-box {
            background: #f8f9fa;
            padding: 18px 22px;
            border-radius: 8px;
            border-left: 3px solid #f33f3f;
            margin: 15px 0;
        }

        .policy-card .highlight-box p {
            margin-bottom: 0;
            font-size: 14px;
        }

        .policy-card .highlight-box i {
            color: #f33f3f;
            margin-right: 10px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #f33f3f;
            font-weight: 500;
            transition: all 0.3s;
        }

        .back-link:hover {
            color: #121212;
            transform: translateX(-5px);
        }

        .back-link i {
            margin-right: 8px;
        }

        .last-updated {
            color: #888;
            font-size: 14px;
            font-style: italic;
            margin-top: 10px;
            text-align: right;
        }

        @media (max-width: 768px) {
            .policy-section {
                padding: 80px 0 40px 0;
            }

            .policy-card {
                padding: 25px 20px;
            }

            .policy-card h3 {
                font-size: 18px;
            }

            .policy-card ul li {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            .policy-card {
                padding: 20px 15px;
            }

            .policy-card h3 {
                font-size: 16px;
            }
        }

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
                        <li class="nav-item"><a class="nav-link" href="{{ url('/contacto') }}">Contacto</a></li>
                        <li class="nav-item"><a class="nav-link" href="{{ url('/logininit') }}">Iniciar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- BANNER DE POLÍTICA -->
    <div class="page-heading contact-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>PROGYMS</h4>
                        <h2>POLÍTICA DE PRIVACIDAD</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- CONTENIDO DE POLÍTICA DE PRIVACIDAD -->
    <div class="policy-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Política de Privacidad</h2>
                        <p>En PROGYMS nos comprometemos a proteger tu información personal y tu privacidad</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">

                    <!-- RECOPILACIÓN DE INFORMACIÓN -->
                    <div class="policy-card">
                        <h3><i class="fa fa-user"></i>Recopilación de su información personal</h3>
                        <p>Para brindarle mejor los productos y servicios ofrecidos en nuestro Sitio,
                            <strong>PROGYMS</strong> puede recopilar información de identificación personal, como su:
                        </p>
                        <ul>
                            <li>Nombre y Apellido</li>
                            <li>Dirección de envío</li>
                            <li>Dirección de correo electrónico</li>
                            <li>Número de teléfono</li>
                        </ul>
                        <p>Si compra productos y servicios de <strong>PROGYMS</strong>, recopilamos información de
                            facturación y tarjeta de crédito. Esta información se utiliza para completar la transacción
                            de compra.</p>
                        <p><strong>PROGYMS</strong> también puede recopilar información demográfica anónima, que no es
                            exclusiva de usted, como su:</p>
                        <ul>
                            <li>Edad</li>
                            <li>Género</li>
                        </ul>
                        <div class="highlight-box">
                            <p><i class="fa fa-shield"></i>Tenga en cuenta que si divulga directamente información de
                                identificación personal o datos personales confidenciales a través de los foros de
                                mensajes públicos de <strong>PROGYMS</strong>, esta información puede ser recopilada y
                                utilizada por otros.</p>
                        </div>
                    </div>

                    <!-- CÓMO RECOPILAMOS -->
                    <div class="policy-card">
                        <h3><i class="fa fa-database"></i>¿Cómo recopilamos su información?</h3>
                        <p>No recopilamos ninguna información personal sobre usted a menos que nos la proporcione
                            voluntariamente. Sin embargo, es posible que deba proporcionarnos cierta información
                            personal cuando elija usar ciertos productos o servicios disponibles en el Sitio. Estos
                            pueden incluir:</p>
                        <ul>
                            <li>Registrarse para obtener una cuenta en nuestro Sitio</li>
                            <li>Participar en un sorteo o concurso patrocinado por nosotros o uno de nuestros socios
                            </li>
                            <li>Suscribirse a ofertas especiales de terceros seleccionados</li>
                            <li>Enviarnos un mensaje de correo electrónico</li>
                            <li>Enviar su tarjeta de crédito u otra información de pago al ordenar y comprar productos y
                                servicios en nuestro Sitio</li>
                        </ul>
                        <p>A saber, utilizaremos su información para, entre otros, comunicarnos con usted en relación
                            con los servicios y/o productos que nos ha solicitado. También podemos recopilar información
                            personal o no personal adicional en el futuro.</p>
                    </div>

                    <!-- USO DE LA INFORMACIÓN -->
                    <div class="policy-card">
                        <h3><i class="fa fa-cogs"></i>¿Qué hacemos con su información?</h3>
                        <p>Cuando compra algo en nuestra tienda, como parte del proceso de compra y venta, recopilamos
                            la información personal que nos proporciona, como su nombre, dirección y dirección de correo
                            electrónico.</p>
                        <p>Cuando navega por nuestra tienda, también recibimos automáticamente la dirección de protocolo
                            de Internet (IP) de su computadora para brindarnos información que nos ayude a conocer su
                            navegador y sistema operativo.</p>

                        <div class="highlight-box">
                            <p><i class="fa fa-envelope"></i><strong>Marketing por correo electrónico:</strong> Con su
                                permiso, podemos enviarle correos electrónicos sobre nuestra tienda, nuevos productos y
                                otras actualizaciones.</p>
                        </div>

                        <div class="highlight-box" style="border-left-color: #25D366;">
                            <p><i class="fa fa-mobile" style="color:#25D366;"></i><strong>Marketing de texto:</strong>
                                Con su permiso, podemos enviar mensajes de texto sobre nuestra tienda, nuevos productos
                                y otras actualizaciones. Las actualizaciones incluyen recordatorios de pago. Los
                                webhooks se utilizarán para activar el sistema de mensajería de recordatorios de pago.
                            </p>
                        </div>
                    </div>

                    <!-- FECHA DE ACTUALIZACIÓN -->
                    <div class="last-updated">
                        <i class="fa fa-calendar"></i> Última actualización: <span id="updateDate"></span>
                    </div>

                    <!-- BOTÓN DE VOLVER -->
                    <div class="text-center" style="margin-top:20px;">
                        <a href="{{ url('/') }}" class="back-link">
                            <i class="fa fa-arrow-left"></i> Volver al inicio
                        </a>
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

        // ===== FECHA DE ACTUALIZACIÓN =====
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const options = {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            };
            document.getElementById('updateDate').textContent = today.toLocaleDateString('es-ES', options);
        });
    </script>
</body>

</html>
