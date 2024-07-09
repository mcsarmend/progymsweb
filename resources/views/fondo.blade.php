<style>
    .content-header {
        z-index: 10;
        position: relative;

    }

    /*     h1 {

        background: -webkit-radial-gradient(center, ellipse cover, #ffffff, #aabbcc) !important;

        background: radial-gradient(ellipse at center, #ffffff, #aabbcc) !important;
    } */

    .content-wrapper {
        position: relative;
        overflow: hidden;
        padding: 20px;
        background-color: #f4f4f4;
        /* Fondo gris claro por defecto */
    }

    .card {
        z-index: 1;
        background-color: #FFF;
    }

    canvas {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
</style>

<script>
    function drawTriangles() {
        const contentWrapper = document.querySelector(".content-wrapper");
        const canvas = document.createElement("canvas");
        const ctx = canvas.getContext("2d");

        contentWrapper.appendChild(canvas);

        canvas.width = contentWrapper.clientWidth;
        canvas.height = contentWrapper.clientHeight;

        const colors = ["#3498db", "#ffffff", "#ecf0f1", "#bdc3c7"];

        function drawRandomTriangle() {
            const sideLength = Math.random() * 50 + 10;
            const x = Math.random() * (canvas.width - sideLength);
            const y = Math.random() * (canvas.height - sideLength);
            const color = colors[Math.floor(Math.random() * colors.length)];

            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x + sideLength, y);
            ctx.lineTo(x + sideLength / 2, y + sideLength * Math.sqrt(3) / 2);
            ctx.closePath();

            ctx.fillStyle = color;
            ctx.fill();
        }

        function drawRandomTriangles(numTriangles) {
            for (let i = 0; i < numTriangles; i++) {
                drawRandomTriangle();
            }
        }

        window.addEventListener('resize', function() {
            canvas.width = contentWrapper.clientWidth;
            canvas.height = contentWrapper.clientHeight;
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            drawRandomTriangles(50);
        });

        drawRandomTriangles(100);
    }

    function showUsersSections() {
        var type = @json($type);
        switch (type) {
            case 4:
                // Quitar cuentas de usuario
                $('.user-footer a').each(function() {
                    if ($(this).text().includes('Cuentas')) {
                        $(this).hide();
                        $(this).css('display', 'none !important'); // Añadir !important
                        $(this).remove(); // Eliminar el enlace del DOM
                    }
                });
                // Cambiar nombre
                $('small').each(function() {
                    if ($(this).text().includes('Administrador')) {
                        $(this).text('Vendedor');

                    }
                });
                // Quitar Inventario
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Inventario');
                }).remove();
                //Quitar Almacén
                $('li.nav-item.dropdown .dropdown-menu li a').filter(function() {
                    return $(this).text().trim() === 'Alta' ||
                        $(this).text().trim() === 'Baja' ||
                        $(this).text().trim() === 'Traspasos';
                }).closest('li').hide();

                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Clientes');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Proveedores');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Compras');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Precios');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Vendedores');
                }).remove();
                break;
            case 3:
                // Quitar cuentas de usuario
                $('.user-footer a').each(function() {
                    if ($(this).text().includes('Cuentas')) {
                        $(this).hide();
                        $(this).css('display', 'none !important'); // Añadir !important
                        $(this).remove(); // Eliminar el enlace del DOM
                    }
                });
                // Cambiar nombre
                $('small').each(function() {
                    if ($(this).text().includes('Administrador')) {
                        $(this).text('Supervisor');

                    }
                });
                // Quitar Inventario
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Inventario');
                }).remove();
                //Quitar Almacén
                $('li.nav-item.dropdown .dropdown-menu li a').filter(function() {
                    return $(this).text().trim() === 'Alta' ||
                        $(this).text().trim() === 'Baja' ||
                        $(this).text().trim() === 'Traspasos';
                }).closest('li').hide();

                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Clientes');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Proveedores');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Compras');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Precios');
                }).remove();

                break;
            case 2:
                // Cambiar nombre
                $('small').each(function() {
                    if ($(this).text().includes('Administrador')) {
                        $(this).text('Jefatura');

                    }
                });
                // Quitar Inventario
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Inventario');
                }).remove();
                //Quitar Almacén
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Clientes');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Proveedores');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Compras');
                }).remove();
                $('li.nav-item.dropdown').filter(function() {
                    return $(this).text().trim().includes('Precios');
                }).remove();
                break;
            default:
                break;
        }
    }
</script>
