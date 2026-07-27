<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>PROGYMS | Preguntas Frecuentes</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap"
        rel="stylesheet">
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-sixteen.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="shortcut icon" href="favicons/favicon.ico">

    <style>
        /* Estilos para la página de FAQ */
        .faq-section {
            padding: 100px 0 60px 0;
        }

        .faq-section .section-heading {
            margin-bottom: 40px;
        }

        .faq-section .section-heading h2 {
            font-size: 32px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .faq-section .section-heading p {
            color: #666;
            font-size: 16px;
            margin-top: 5px;
        }

        .faq-item {
            background: #fff;
            border-radius: 12px;
            padding: 30px 35px;
            margin-bottom: 20px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.06);
            border-left: 4px solid #f33f3f;
            transition: all 0.3s ease;
        }

        .faq-item:hover {
            box-shadow: 0 8px 35px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .faq-item .faq-question {
            display: flex;
            align-items: flex-start;
            cursor: pointer;
            user-select: none;
        }

        .faq-item .faq-question .icon {
            color: #f33f3f;
            font-size: 22px;
            width: 40px;
            min-width: 40px;
            margin-top: 2px;
        }

        .faq-item .faq-question h3 {
            font-size: 18px;
            font-weight: 600;
            color: #1a6692;
            margin: 0;
            line-height: 1.4;
            flex: 1;
        }

        .faq-item .faq-question .arrow {
            color: #aaa;
            font-size: 18px;
            transition: transform 0.3s ease;
            margin-left: 15px;
            min-width: 20px;
            text-align: right;
        }

        .faq-item .faq-question .arrow.open {
            transform: rotate(180deg);
        }

        .faq-item .faq-answer {
            margin-top: 0;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.4s ease, margin-top 0.3s ease;
            padding-left: 40px;
        }

        .faq-item .faq-answer.open {
            max-height: 500px;
            margin-top: 15px;
        }

        .faq-item .faq-answer p {
            color: #4a4a4a;
            line-height: 1.8;
            font-size: 15px;
            margin-bottom: 0;
        }

        .faq-item .faq-answer p strong {
            color: #1a1a1a;
        }

        .faq-item .faq-answer .highlight-text {
            color: #f33f3f;
            font-weight: 600;
        }

        .faq-item .faq-answer ul {
            padding-left: 20px;
            margin-top: 10px;
        }

        .faq-item .faq-answer ul li {
            color: #4a4a4a;
            line-height: 1.8;
            font-size: 15px;
            margin-bottom: 5px;
            list-style: disc;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
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

        .faq-footer-text {
            text-align: center;
            margin-top: 40px;
            padding: 25px;
            background: #f8f9fa;
            border-radius: 12px;
        }

        .faq-footer-text p {
            color: #666;
            font-size: 15px;
            margin-bottom: 0;
        }

        .faq-footer-text a {
            color: #f33f3f;
            font-weight: 600;
        }

        .faq-footer-text a:hover {
            color: #121212;
        }

        @media (max-width: 768px) {
            .faq-section {
                padding: 80px 0 40px 0;
            }

            .faq-item {
                padding: 20px 20px;
            }

            .faq-item .faq-question h3 {
                font-size: 16px;
            }

            .faq-item .faq-answer {
                padding-left: 0;
            }

            .faq-item .faq-question .icon {
                width: 30px;
                min-width: 30px;
                font-size: 18px;
            }
        }

        @media (max-width: 576px) {
            .faq-item {
                padding: 18px 15px;
            }

            .faq-item .faq-question h3 {
                font-size: 15px;
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

    <!-- BANNER DE FAQ -->
    <div class="page-heading contact-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>PROGYMS</h4>
                        <h2>PREGUNTAS FRECUENTES</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- CONTENIDO DE FAQ -->
    <div class="faq-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-heading">
                        <h2>Preguntas Frecuentes</h2>
                        <p>Encuentra respuestas a las preguntas más comunes sobre nuestros productos y servicios</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">

                    <!-- FAQ 1 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span class="icon"><i class="fa fa-question-circle"></i></span>
                            <h3>PROGYMS® actualmente no patrocina atletas.</h3>
                            <span class="arrow"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="faq-answer">
                            <p>Actualmente PROGYMS® no cuenta con un programa de patrocinio para atletas. Sin embargo,
                                nos encanta apoyar a la comunidad fitness y deportiva. Si tienes alguna propuesta o
                                colaboración, no dudes en <a href="{{ url('/contacto') }}"
                                    style="color:#f33f3f;font-weight:600;">contactarnos</a>.</p>
                        </div>
                    </div>

                    <!-- FAQ 2 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span class="icon"><i class="fa fa-credit-card"></i></span>
                            <h3>Mi tarjeta muestra que se cargó, pero no he recibido un número de pedido.</h3>
                            <span class="arrow"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="faq-answer">
                            <p>Si se rechaza una tarjeta, es posible que aún se muestre que se cargó a su tarjeta; sin
                                embargo, el pedido no se procesará, por lo tanto, no se proporcionará un número de
                                pedido.</p>
                            <p>En la mayoría de los casos, los emisores de tarjetas colocan la transacción rechazada en
                                una <strong>"etapa pendiente"</strong> que puede verse igual en su cuenta. Las tarjetas
                                rechazadas pueden ser el resultado de:</p>
                            <ul>
                                <li>Falta de fondos</li>
                                <li>Información incorrecta</li>
                                <li>El instituto que emitió esta tarjeta</li>
                            </ul>
                            <p>Si no ha recibido un número de pedido, le recomendamos que se comunique con el emisor de
                                su tarjeta antes de intentar realizar el pedido nuevamente.</p>
                        </div>
                    </div>

                    <!-- FAQ 3 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span class="icon"><i class="fa fa-clock-o"></i></span>
                            <h3>¿Cuánto tarda mi pedido una vez enviado?</h3>
                            <span class="arrow"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="faq-answer">
                            <p>Cuando realice un pedido en <strong>PROGYMS</strong>, se le proporcionará un número de
                                seguimiento. Si por algún motivo no recibe información de seguimiento, la mayoría de los
                                pedidos llegarán en un plazo de <strong>3 a 5 días</strong>, a menos que seleccione una
                                opción de envío más rápida.</p>
                            <p>Una vez que se envía un producto, <strong>PROGYMS</strong> no tiene control sobre el
                                tiempo que tarda en llegar a usted. Para más información, consulta nuestra <a
                                    href="{{ url('/politicaenvio') }}" style="color:#f33f3f;font-weight:600;">Política
                                    de Envío</a>.</p>
                        </div>
                    </div>

                    <!-- FAQ 4 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span class="icon"><i class="fa fa-flask"></i></span>
                            <h3>¿Aparecerá este producto en una prueba de drogas?</h3>
                            <span class="arrow"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="faq-answer">
                            <p>Si le preocupan las pruebas, le recomendamos enfáticamente que investigue las pautas de
                                su organización o evento y las compare con las etiquetas de los productos.</p>
                            <p>Si aún no está seguro, comuníquese con su <strong>profesional de la salud</strong> para
                                obtener una orientación personalizada.</p>
                        </div>
                    </div>

                    <!-- FAQ 5 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span class="icon"><i class="fa fa-user-md"></i></span>
                            <h3>Tengo ciertos problemas de salud y no estoy seguro si debo tomar un determinado
                                producto. ¿A quién debo contactar?</h3>
                            <span class="arrow"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="faq-answer">
                            <p><span class="highlight-text">¡CON TU DOCTOR!</span> Ni siquiera el Químico está
                                calificado para responder preguntas sobre su salud individual.</p>
                            <p>La información proporcionada tiene únicamente fines informativos y no pretende sustituir
                                el consejo de su médico u otro profesional de la salud. <strong>Siempre consulta a un
                                    profesional de la salud</strong> antes de comenzar cualquier suplemento.</p>
                        </div>
                    </div>

                    <!-- BOTÓN DE VOLVER -->
                    <div class="text-center">
                        <a href="{{ url('/') }}" class="back-link">
                            <i class="fa fa-arrow-left"></i> Volver al inicio
                        </a>
                    </div>

                    <!-- TEXTO ADICIONAL -->
                    <div class="faq-footer-text">
                        <p><i class="fa fa-comments" style="color:#f33f3f;margin-right:8px;"></i>¿No encontraste lo
                            que buscabas? <a href="{{ url('/contacto') }}">Contáctanos</a> y con gusto te ayudaremos.
                        </p>
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

        // ===== TOGGLE FAQ =====
        function toggleFaq(element) {
            const answer = element.nextElementSibling;
            const arrow = element.querySelector('.arrow');

            // Cerrar otras preguntas abiertas (opcional)
            // Si quieres que solo una pregunta esté abierta a la vez, descomenta esto:
            // const allAnswers = document.querySelectorAll('.faq-answer');
            // const allArrows = document.querySelectorAll('.faq-question .arrow');
            // allAnswers.forEach(ans => {
            //     if (ans !== answer && ans.classList.contains('open')) {
            //         ans.classList.remove('open');
            //         ans.previousElementSibling.querySelector('.arrow').classList.remove('open');
            //     }
            // });

            answer.classList.toggle('open');
            arrow.classList.toggle('open');
        }

        // ===== ABRIR PRIMERA PREGUNTA POR DEFECTO =====
        document.addEventListener('DOMContentLoaded', function() {
            const firstQuestion = document.querySelector('.faq-question');
            if (firstQuestion) {
                // Abrir la primera pregunta por defecto
                const answer = firstQuestion.nextElementSibling;
                const arrow = firstQuestion.querySelector('.arrow');
                answer.classList.add('open');
                arrow.classList.add('open');
            }
        });
    </script>
</body>

</html>
