<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PROGYMS | Catálogo de Suplementos</title>
    <link href="{{ asset('vendor/bootstrap/css/bootstrap.min.css') }}" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('assets/css/fontawesome.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/templatemo-sixteen.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/owl.css') }}">
    <link rel="shortcut icon" href="favicons/favicon.ico">
    <style>
        /* Estilos para las tarjetas de productos */
        .product-item {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        .product-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .product-image-wrapper {
            position: relative;
            width: 100%;
            height: 250px;
            overflow: hidden;
            background: #f8f9fa;
            flex-shrink: 0;
        }

        .product-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .product-item:hover .product-image-wrapper img {
            transform: scale(1.05);
        }

        .no-image {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            background: #f0f0f0;
            color: #999;
        }

        .no-image i {
            font-size: 50px;
            margin-bottom: 10px;
            color: #ccc;
        }

        .badge-stock {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.75);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-stock i {
            margin-right: 5px;
        }

        .down-content {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .down-content h4 {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 5px;
            color: #1a1a1a;
            min-height: 40px;
        }

        .product-marca {
            font-size: 13px;
            color: #555;
            margin-bottom: 5px;
            display: block;
            font-weight: 600;
        }

        .product-marca i {
            color: #888;
            margin-right: 5px;
        }

        .product-categoria {
            font-size: 12px;
            color: #888;
            margin-bottom: 10px;
            display: block;
        }

        .product-categoria i {
            color: #aaa;
            margin-right: 5px;
        }

        /* Precios */
        .price-container {
            margin: 12px 0;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
            flex-shrink: 0;
        }

        .price-item {
            display: flex;
            justify-content: space-between;
            padding: 4px 0;
            font-size: 14px;
            border-bottom: 1px solid #eee;
        }

        .price-item:last-child {
            border-bottom: none;
        }

        .price-item .label {
            color: #666;
            font-weight: 500;
        }

        .price-item .value {
            font-weight: 700;
        }

        .price-item .value.publico {
            color: #e74c3c;
        }

        .price-item .value.frecuente {
            color: #27ae60;
        }

        .price-item .value.mayoreo {
            color: #2980b9;
        }

        .stars {
            margin: 8px 0 5px;
            padding: 0;
            list-style: none;
            flex-shrink: 0;
        }

        .stars li {
            display: inline-block;
            color: #f1c40f;
        }

        .btn-ver-precios {
            background: transparent;
            border: 1px solid #3498db;
            color: #3498db;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            transition: all 0.3s;
            cursor: pointer;
            margin-top: auto;
            width: 100%;
        }

        .btn-ver-precios:hover {
            background: #3498db;
            color: white;
        }

        /* Botón descargar Excel */
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 20px;
            padding: 0 15px;
            gap: 15px;
        }

        .btn-download-excel {
            background: linear-gradient(135deg, #28a745, #1e7e34);
            color: white;
            padding: 12px 25px;
            border-radius: 30px;
            border: none;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-download-excel:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(40, 167, 69, 0.4);
            color: white;
            text-decoration: none;
        }

        .btn-download-excel i {
            font-size: 20px;
        }

        /* Modal de precios */
        .price-modal .modal-body {
            padding: 20px 25px;
        }

        .price-modal .table-prices {
            width: 100%;
            margin: 10px 0;
        }

        .price-modal .table-prices tr {
            border-bottom: 1px solid #eee;
        }

        .price-modal .table-prices td {
            padding: 10px 5px;
        }

        .price-modal .table-prices .label {
            font-weight: 600;
            color: #555;
        }

        .price-modal .table-prices .value {
            font-weight: 700;
            text-align: right;
        }

        .price-modal .table-prices .value.publico {
            color: #e74c3c;
        }

        .price-modal .table-prices .value.frecuente {
            color: #27ae60;
        }

        .price-modal .table-prices .value.mayoreo {
            color: #2980b9;
        }

        .price-modal .table-prices .value.distribuidor {
            color: #8e44ad;
        }

        .price-modal .table-prices .value.platinum {
            color: #f39c12;
        }

        .stock-title {
            font-weight: 700;
            margin-top: 15px;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .stock-title i {
            margin-right: 5px;
        }

        /* Estilos para almacenes en el modal */
        .almacenes-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin: 10px 0;
        }

        .almacen-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 12px;
            text-align: center;
            border: 1px solid #e0e0e0;
            transition: transform 0.2s;
        }

        .almacen-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .almacen-card i {
            font-size: 24px;
            display: block;
            margin-bottom: 5px;
        }

        .almacen-card .nombre {
            font-size: 13px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .almacen-card .stock {
            font-size: 20px;
            font-weight: 700;
            color: #2980b9;
        }

        .almacen-card .stock.coacalco {
            color: #e74c3c;
        }

        .almacen-card .stock.naucalpan {
            color: #27ae60;
        }

        .almacen-card .stock.towncenter {
            color: #2980b9;
        }

        .total-stock {
            background: #1a1a1a;
            color: white;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            margin-top: 15px;
        }

        .total-stock .number {
            font-size: 24px;
            font-weight: 700;
        }

        /* Filtros mejorados */
        .filters-wrapper {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            align-items: center;
        }

        .filters {
            flex: 1;
            min-width: 200px;
        }

        .filters ul {
            padding: 0;
            margin: 0;
            list-style: none;
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .filters ul li {
            padding: 8px 20px;
            background: #f0f0f0;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
            font-weight: 500;
            border: 2px solid transparent;
            user-select: none;
            display: inline-flex;
            align-items: center;
        }

        .filters ul li.active,
        .filters ul li:hover {
            background: #1a1a1a;
            color: white;
        }

        .filters ul li.active {
            border-color: #1a1a1a;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .filters ul li .count {
            font-size: 11px;
            background: rgba(0, 0, 0, 0.1);
            padding: 1px 8px;
            border-radius: 12px;
            margin-left: 5px;
        }

        .filters ul li.active .count {
            background: rgba(255, 255, 255, 0.2);
        }

        /* Filtro de marca con autocompletado */
        .brand-filter-wrapper {
            position: relative;
            min-width: 200px;
            max-width: 300px;
        }

        .brand-filter-wrapper input {
            width: 100%;
            padding: 8px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            font-size: 14px;
            transition: all 0.3s;
            background: white;
        }

        .brand-filter-wrapper input:focus {
            outline: none;
            border-color: #1a1a1a;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .brand-suggestions {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid #e0e0e0;
            border-top: none;
            border-radius: 0 0 25px 25px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .brand-suggestions.active {
            display: block;
        }

        .brand-suggestions .suggestion-item {
            padding: 10px 15px;
            cursor: pointer;
            transition: background 0.2s;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand-suggestions .suggestion-item:hover {
            background: #f0f0f0;
        }

        .brand-suggestions .suggestion-item .count {
            font-size: 12px;
            color: #888;
            background: #f0f0f0;
            padding: 2px 10px;
            border-radius: 12px;
        }

        .brand-suggestions .no-results {
            padding: 15px;
            text-align: center;
            color: #888;
        }

        .selected-brand {
            display: inline-flex;
            align-items: center;
            background: #1a1a1a;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            margin-top: 5px;
            font-size: 13px;
        }

        .selected-brand .remove-brand {
            margin-left: 8px;
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.2s;
        }

        .selected-brand .remove-brand:hover {
            opacity: 1;
        }

        /* Filtro de búsqueda por producto */
        .product-search-wrapper {
            width: 100%;
            margin-top: 15px;
            margin-bottom: 35px;
            padding: 0 15px;
        }

        .product-search-wrapper input {
            width: 100%;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 30px;
            font-size: 15px;
            transition: all 0.3s;
            background: white;
            padding-left: 50px;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="%23999" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>');
            background-repeat: no-repeat;
            background-position: 20px center;
            background-size: 20px;
        }

        .product-search-wrapper input:focus {
            outline: none;
            border-color: #1a1a1a;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        .product-search-wrapper input::placeholder {
            color: #aaa;
            font-weight: 400;
        }

        .search-results-count {
            font-size: 14px;
            color: #888;
            margin-top: 10px;
            display: none;
            text-align: center;
        }

        .search-results-count.active {
            display: block;
        }

        .search-results-count strong {
            color: #1a1a1a;
        }

        .filter-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .filter-row .filters {
            flex: 2;
            min-width: 200px;
        }

        .filter-row .brand-filter-wrapper {
            flex: 1;
            min-width: 180px;
            max-width: 280px;
        }

        /* Separación extra para las tarjetas */
        .products-grid-container {
            margin-top: 10px;
        }

        .product-card {
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        /* Espaciado del grid */
        .grid {
            margin-top: 10px;
        }

        @media (max-width: 768px) {
            .header-actions {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }

            .btn-download-excel {
                justify-content: center;
            }

            .product-image-wrapper {
                height: 200px;
            }

            .filters ul {
                justify-content: center;
            }

            .filters ul li {
                padding: 6px 15px;
                font-size: 12px;
            }

            .almacenes-grid {
                grid-template-columns: 1fr;
            }

            .filters-wrapper {
                flex-direction: column;
                align-items: stretch;
            }

            .brand-filter-wrapper {
                max-width: 100%;
            }

            .filter-row {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-row .brand-filter-wrapper {
                max-width: 100%;
            }

            .product-search-wrapper input {
                font-size: 14px;
                padding: 12px 15px 12px 45px;
                background-position: 16px center;
                background-size: 18px;
            }

            .product-search-wrapper {
                margin-bottom: 25px;
                padding: 0 10px;
            }
        }

        /* Ajustes para la sección de filtros */
        .filter-section .filter-row {
            margin-bottom: 12px;
        }

        .filter-section .filter-row:last-child {
            margin-bottom: 0;
        }

        /* Estilo para productos ocultos por búsqueda */
        .product-card.hidden-by-search {
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
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/') }}">Inicio</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="{{ url('/productos') }}">Productos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/acerca') }}">Nosotros</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/contacto') }}">Contacto</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="{{ url('/logininit') }}">Iniciar Sesión</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- BANNER -->
    <div class="page-heading products-heading header-text">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-content">
                        <h4>SUPLEMENTOS PREMIUM</h4>
                        <h2>CATÁLOGO PROGYMS</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="products">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <!-- Header con filtros y botón de descarga -->
                    <div class="header-actions">
                        <div class="filters-wrapper">
                            <!-- Filtro por categoría -->
                            <div class="filters">
                                <ul id="filter-list">
                                    <li class="active" data-filter="all">
                                        Todos <span class="count">{{ count($products) }}</span>
                                    </li>
                                    @foreach ($categories as $category)
                                        @php
                                            $count = 0;
                                            foreach ($products as $product) {
                                                if ($product->categoria == $category->nombre) {
                                                    $count++;
                                                }
                                            }
                                        @endphp
                                        @if ($count > 0)
                                            <li data-filter="{{ $category->nombre }}">
                                                {{ $category->nombre }} <span
                                                    class="count">{{ $count }}</span>
                                            </li>
                                        @endif
                                    @endforeach
                                </ul>
                            </div>

                            <!-- Filtro por marca con autocompletado -->
                            <div class="brand-filter-wrapper">
                                <input type="text" id="brand-search" placeholder="🔍 Buscar por marca..."
                                    autocomplete="off">
                                <div class="brand-suggestions" id="brand-suggestions">
                                    @php
                                        $brandCounts = [];
                                        foreach ($products as $product) {
                                            $brand = $product->marca ?? 'Sin marca';
                                            if (!isset($brandCounts[$brand])) {
                                                $brandCounts[$brand] = 0;
                                            }
                                            $brandCounts[$brand]++;
                                        }
                                        arsort($brandCounts);
                                    @endphp
                                    @foreach ($brandCounts as $brand => $count)
                                        <div class="suggestion-item" data-brand="{{ $brand }}">
                                            <span>{{ $brand }}</span>
                                            <span class="count">{{ $count }}</span>
                                        </div>
                                    @endforeach
                                </div>
                                <div id="selected-brand" style="display: none;" class="selected-brand">
                                    <span id="selected-brand-name"></span>
                                    <span class="remove-brand" id="remove-brand">✕</span>
                                </div>
                            </div>
                        </div>

                        <a href="{{ url('/exportar-precios') }}" class="btn-download-excel">
                            <i class="fa fa-file-excel-o"></i>
                            Descargar Precios
                        </a>
                    </div>

                    <!-- Filtro de búsqueda por producto -->
                    <div class="product-search-wrapper">
                        <input type="text" id="product-search"
                            placeholder="🔍 Buscar producto por nombre o código..." autocomplete="off">
                        <div class="search-results-count" id="search-results-count">
                            Mostrando <strong id="visible-count">0</strong> de <strong id="total-count">0</strong>
                            productos
                        </div>
                    </div>
                </div>

                <div class="col-md-12 products-grid-container">
                    <div class="filters-content">
                        <div class="row grid" id="product-grid">
                            @forelse($products as $product)
                                <div class="col-lg-4 col-md-6 product-card"
                                    data-categoria="{{ $product->categoria }}"
                                    data-marca="{{ $product->marca ?? 'Sin marca' }}"
                                    data-nombre="{{ $product->producto }}"
                                    data-codigo="{{ $product->codigo ?? '' }}">
                                    <div class="product-item">
                                        <div class="product-image-wrapper">

                                            <img src="{{ asset('assets/images/productos/' . $product->codigo . '.jpg') }}"
                                                alt="{{ $product->producto }}" loading="lazy"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">

                                            <div class="no-image" style="display: none;">
                                                <i class="fa fa-image"></i>
                                                <span>Sin imagen</span>
                                            </div>


                                            <span class="badge-stock">
                                                <i class="fa fa-box"></i> {{ $product->totales ?? 0 }}
                                            </span>
                                        </div>

                                        <div class="down-content">
                                            <h4>{{ $product->producto }}</h4>

                                            <ul class="stars">
                                                <li><i class="fa fa-star"></i></li>
                                                <li><i class="fa fa-star"></i></li>
                                                <li><i class="fa fa-star"></i></li>
                                                <li><i class="fa fa-star"></i></li>
                                                <li><i class="fa fa-star"></i></li>
                                            </ul>

                                            <button class="btn-precios" data-toggle="modal"
                                                data-target="#priceModal{{ $product->codigo }}">
                                                <i class="fa fa-chevron-circle-down"></i> Ver todos los precios
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal con TODOS los precios y almacenes -->
                                <div class="modal fade price-modal" id="priceModal{{ $product->codigo }}"
                                    tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header" style="background: #1a1a1a; color: white;">
                                                <h5 class="modal-title">
                                                    <i class="fa fa-cube"></i>
                                                    <span>{{ $product->producto }}</span>
                                                    <span class="product-code">({{ $product->codigo }})</span>
                                                </h5>
                                                <button type="button" class="close" data-dismiss="modal"
                                                    style="color: white;">
                                                    <span>&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <!-- NOMBRE DEL PRODUCTO DESTACADO -->
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <h3
                                                            style="color: #1a1a1a; margin-bottom: 20px; font-weight: 700; border-bottom: 3px solid #3498db; padding-bottom: 10px;">
                                                            <i class="fa fa-cube" style="color: #3498db;"></i>
                                                            {{ $product->producto }}
                                                            <small
                                                                style="font-size: 14px; color: #888; font-weight: 400; display: block; margin-top: 5px;">
                                                                Código: {{ $product->codigo ?? 'N/A' }}
                                                            </small>
                                                        </h3>
                                                    </div>
                                                </div>

                                                <!-- Información del producto -->
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <p><strong><i class="fa fa-tag"></i> Marca:</strong>
                                                            {{ $product->marca ?? 'Sin marca' }}</p>
                                                        <p><strong><i class="fa fa-folder"></i> Categoría:</strong>
                                                            {{ $product->categoria ?? 'Sin categoría' }}</p>
                                                        <p><strong><i class="fa fa-barcode"></i> Código:</strong>
                                                            {{ $product->codigo ?? 'N/A' }}</p>
                                                    </div>
                                                    <div class="col-md-6 text-right">
                                                        <div class="total-stock"
                                                            style="background: #2980b9; padding: 15px; border-radius: 8px; display: inline-block;">
                                                            <span
                                                                style="font-size: 14px; color: rgba(255,255,255,0.8);">Stock
                                                                Total</span><br>
                                                            <span class="number"
                                                                style="font-size: 32px; font-weight: 700; color: white;">{{ $product->totales ?? 0 }}</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <hr>

                                                <!-- Tabla de Precios Completa -->
                                                <h6 class="stock-title"><i class="fa fa-money"></i> Todos los Precios
                                                </h6>
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover">
                                                        <thead class="thead-dark">
                                                            <tr>
                                                                <th>Tipo de Precio</th>
                                                                <th class="text-right">Monto</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td><i class="fa fa-users"
                                                                        style="color: #e74c3c;"></i>
                                                                    <strong>Público</strong>
                                                                </td>
                                                                <td class="text-right text-danger font-weight-bold">
                                                                    ${{ number_format($product->publico ?? 0, 2) }}
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><i class="fa fa-repeat"
                                                                        style="color: #27ae60;"></i>
                                                                    <strong>Frecuente</strong>
                                                                </td>
                                                                <td class="text-right text-success font-weight-bold">
                                                                    ${{ number_format($product->frecuente ?? 0, 2) }}
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><i class="fa fa-shopping-cart"
                                                                        style="color: #2980b9;"></i>
                                                                    <strong>Mayorista</strong>
                                                                </td>
                                                                <td class="text-right text-primary font-weight-bold">
                                                                    ${{ number_format($product->mayoreo ?? 0, 2) }}
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><i class="fa fa-star" style="color: #8e44ad;"></i>
                                                                    <strong>Distribuidor</strong>
                                                                </td>
                                                                <td class="text-right text-purple font-weight-bold"
                                                                    style="color: #8e44ad;">
                                                                    ${{ number_format($product->distribuidor ?? 0, 2) }}
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><i class="fa fa-diamond"
                                                                        style="color: #f39c12;"></i>
                                                                    <strong>Platinum</strong>
                                                                </td>
                                                                <td class="text-right text-warning font-weight-bold"
                                                                    style="color: #f39c12;">
                                                                    ${{ number_format($product->platinum ?? 0, 2) }}
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <hr>

                                                <!-- Stock por Almacén -->
                                                <h6 class="stock-title"><i class="fa fa-warehouse"></i> Stock por
                                                    Almacén</h6>
                                                <div class="almacenes-grid">
                                                    <!-- Coacalco -->
                                                    <div class="almacen-card">
                                                        <i class="fa fa-building" style="color: #e74c3c;"></i>
                                                        <div class="nombre">Coacalco</div>
                                                        <div class="stock coacalco">{{ $product->coacalco ?? 0 }}
                                                        </div>
                                                    </div>
                                                    <!-- Naucalpan -->
                                                    <div class="almacen-card">
                                                        <i class="fa fa-building" style="color: #27ae60;"></i>
                                                        <div class="nombre">Naucalpan</div>
                                                        <div class="stock naucalpan">{{ $product->naucalpan ?? 0 }}
                                                        </div>
                                                    </div>
                                                    <!-- TownCenter -->
                                                    <div class="almacen-card">
                                                        <i class="fa fa-building" style="color: #2980b9;"></i>
                                                        <div class="nombre">TownCenter</div>
                                                        <div class="stock towncenter">{{ $product->towncenter ?? 0 }}
                                                        </div>
                                                    </div>
                                                    <!-- Bodega -->
                                                    <div class="almacen-card">
                                                        <i class="fa fa-warehouse"></i>
                                                        <div class="nombre">Bodega</div>
                                                        <div class="stock">{{ $product->bodega ?? 0 }}</div>
                                                    </div>
                                                    <!-- Tienda Piso -->
                                                    <div class="almacen-card">
                                                        <i class="fa fa-store"></i>
                                                        <div class="nombre">Tienda Piso</div>
                                                        <div class="stock">{{ $product->tienda_piso ?? 0 }}</div>
                                                    </div>
                                                </div>

                                                <div class="total-stock"
                                                    style="background: #1a1a1a; padding: 15px; border-radius: 8px; margin-top: 15px;">
                                                    <span style="font-size: 14px; color: rgba(255,255,255,0.8);">Stock
                                                        Total en todos los almacenes</span><br>
                                                    <span class="number"
                                                        style="font-size: 28px; font-weight: 700; color: white;">{{ $product->totales ?? 0 }}</span>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-dismiss="modal">
                                                    <i class="fa fa-times"></i> Cerrar
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @empty
                                <div class="col-12">
                                    <div class="alert alert-info text-center" style="padding: 50px 20px;">
                                        <i class="fa fa-info-circle"
                                            style="font-size: 40px; display: block; margin-bottom: 15px;"></i>
                                        No hay productos disponibles en este momento.
                                    </div>
                                </div>
                            @endforelse
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

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

    <script src="{{ asset('vendor/jquery/jquery.min.js') }}"></script>
    <script src="{{ asset('vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
    <script src="{{ asset('assets/js/custom.js') }}"></script>
    <script src="{{ asset('assets/js/owl.js') }}"></script>
    <script src="{{ asset('assets/js/slick.js') }}"></script>
    <script src="{{ asset('assets/js/isotope.js') }}"></script>
    <script src="{{ asset('assets/js/accordions.js') }}"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

    <script>
        $(document).ready(function() {
            var productosExcel = @json($products);
            var $grid = $('#product-grid');
            var isotope = null;
            var currentBrandFilter = null;
            var currentCategoryFilter = 'all';
            var currentSearchQuery = '';

            // ============================================
            // FUNCIÓN PARA DESCARGAR EXCEL (CSV)
            // ============================================
            function downloadProductsExcel() {
                var productos = productosExcel || [];

                if (!productos || productos.length === 0) {
                    alert('No hay productos para exportar');
                    return;
                }

                // Crear los datos
                var data = [];

                // Encabezados
                data.push([
                    'Código',
                    'Nombre',
                    'Marca',
                    'Categoría',
                    'Distribuidor',
                    'Platinum',
                    'Existencias Totales'
                ]);

                // Datos de los productos
                productos.forEach(function(producto) {
                    data.push([
                        producto.codigo || '',
                        producto.producto || '',
                        producto.marca || 'Sin marca',
                        producto.categoria || 'Sin categoría',
                        producto.distribuidor || 0,
                        producto.platinum || 0,
                        producto.totales || 0
                    ]);
                });

                // Crear libro
                var wb = XLSX.utils.book_new();
                var ws = XLSX.utils.aoa_to_sheet(data);

                // Configurar ancho de columnas
                ws['!cols'] = [{
                        wch: 15
                    },
                    {
                        wch: 45
                    },
                    {
                        wch: 25
                    },
                    {
                        wch: 20
                    },
                    {
                        wch: 18
                    },
                    {
                        wch: 18
                    },
                    {
                        wch: 22
                    }
                ];

                // ESTILOS: Aplicar formato a la fila de encabezados
                var range = XLSX.utils.decode_range(ws['!ref']);

                // Aplicar estilos a la primera fila
                for (var C = range.s.c; C <= range.e.c; ++C) {
                    var address = XLSX.utils.encode_cell({
                        r: 0,
                        c: C
                    });
                    if (!ws[address]) continue;

                    if (ws[address].s === undefined) ws[address].s = {};

                    ws[address].s.font = {
                        bold: true,
                        sz: 11,
                        color: {
                            rgb: "FFFFFF"
                        }
                    };
                    ws[address].s.fill = {
                        fgColor: {
                            rgb: "2C3E50"
                        }
                    };
                    ws[address].s.alignment = {
                        horizontal: "center",
                        vertical: "center"
                    };
                }

                // Formato de moneda para las columnas de precios
                var priceColumns = [4, 5];
                for (var R = 1; R <= range.e.r; ++R) {
                    for (var C = 0; C < priceColumns.length; ++C) {
                        var col = priceColumns[C];
                        var address = XLSX.utils.encode_cell({
                            r: R,
                            c: col
                        });
                        if (!ws[address]) continue;

                        if (ws[address].s === undefined) ws[address].s = {};
                        ws[address].s.numFmt = '"$"#,##0.00';
                    }
                }

                // Formato de número para existencias
                var stockCol = 6;
                for (var R = 1; R <= range.e.r; ++R) {
                    var address = XLSX.utils.encode_cell({
                        r: R,
                        c: stockCol
                    });
                    if (!ws[address]) continue;

                    if (ws[address].s === undefined) ws[address].s = {};
                    ws[address].s.numFmt = '#,##0';
                    ws[address].s.alignment = {
                        horizontal: "center"
                    };
                }

                XLSX.utils.book_append_sheet(wb, ws, 'Productos');

                // Generar archivo
                var wbout = XLSX.write(wb, {
                    bookType: 'xlsx',
                    type: 'array',
                    bookSST: false
                });

                var blob = new Blob([wbout], {
                    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                });

                var link = document.createElement('a');
                var url = URL.createObjectURL(blob);
                link.href = url;
                link.download = 'catalogo_progyms_' + new Date().toISOString().split('T')[0] + '.xlsx';
                link.style.display = 'none';

                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);

                setTimeout(function() {
                    URL.revokeObjectURL(url);
                }, 100);
            }

            // ============================================
            // EVENTO PARA EL BOTÓN DE DESCARGA
            // ============================================
            $('.btn-download-excel').on('click', function(e) {
                e.preventDefault();
                downloadProductsExcel();
            });

            // ============================================
            // INICIALIZAR ISOTOPE
            // ============================================
            function initIsotope() {
                if (typeof Isotope !== 'undefined' && $grid.length && $grid.children().length > 0) {
                    try {
                        isotope = new Isotope($grid[0], {
                            itemSelector: '.product-card',
                            layoutMode: 'fitRows',
                            transitionDuration: '0.6s',
                            hiddenStyle: {
                                opacity: 0,
                                transform: 'scale(0.8)'
                            },
                            visibleStyle: {
                                opacity: 1,
                                transform: 'scale(1)'
                            }
                        });
                        console.log('Isotope inicializado correctamente');
                        return true;
                    } catch (e) {
                        console.error('Error al inicializar Isotope:', e);
                        return false;
                    }
                }
                return false;
            }

            // ============================================
            // APLICAR FILTROS (categoría + marca + búsqueda)
            // ============================================
            function applyFilters() {
                var searchQuery = currentSearchQuery.toLowerCase().trim();

                // Primero, mostrar/ocultar por búsqueda
                $('.product-card').each(function() {
                    var $card = $(this);
                    var nombre = String($card.data('nombre') || '').toLowerCase();
                    var codigo = String($card.data('codigo') || '').toLowerCase();

                    if (searchQuery.length > 0) {
                        if (nombre.includes(searchQuery) || codigo.includes(searchQuery)) {
                            $card.removeClass('hidden-by-search');
                        } else {
                            $card.addClass('hidden-by-search');
                        }
                    } else {
                        $card.removeClass('hidden-by-search');
                    }
                });

                // Actualizar contador
                updateSearchCount();

                if (!isotope) {
                    // Filtrado manual
                    $('.product-card').each(function() {
                        var $card = $(this);
                        var categoria = String($card.data('categoria') || '').toLowerCase();
                        var marca = String($card.data('marca') || '').toLowerCase();
                        var show = true;

                        // Si está oculto por búsqueda, no mostrar
                        if ($card.hasClass('hidden-by-search')) {
                            show = false;
                        }

                        if (currentCategoryFilter !== 'all' && categoria !== currentCategoryFilter
                            .toLowerCase()) {
                            show = false;
                        }

                        if (currentBrandFilter && marca !== currentBrandFilter.toLowerCase()) {
                            show = false;
                        }

                        $card.toggle(show);
                    });
                    return;
                }

                try {
                    var filter = '*';
                    var searchFilter = '.product-card:not(.hidden-by-search)';

                    if (currentCategoryFilter !== 'all' && currentBrandFilter) {
                        filter = searchFilter + '[data-categoria="' + currentCategoryFilter + '"][data-marca="' +
                            currentBrandFilter + '"]';
                    } else if (currentCategoryFilter !== 'all') {
                        filter = searchFilter + '[data-categoria="' + currentCategoryFilter + '"]';
                    } else if (currentBrandFilter) {
                        filter = searchFilter + '[data-marca="' + currentBrandFilter + '"]';
                    } else if (searchQuery.length > 0) {
                        filter = searchFilter;
                    }

                    isotope.arrange({
                        filter: filter
                    });
                } catch (e) {
                    console.error('Error al aplicar filtro:', e);
                    // Fallback a filtrado manual
                    $('.product-card').each(function() {
                        var $card = $(this);
                        var categoria = String($card.data('categoria') || '').toLowerCase();
                        var marca = String($card.data('marca') || '').toLowerCase();
                        var show = true;

                        if ($card.hasClass('hidden-by-search')) {
                            show = false;
                        }

                        if (currentCategoryFilter !== 'all' && categoria !== currentCategoryFilter
                            .toLowerCase()) {
                            show = false;
                        }

                        if (currentBrandFilter && marca !== currentBrandFilter.toLowerCase()) {
                            show = false;
                        }

                        $card.toggle(show);
                    });
                }
            }

            // ============================================
            // ACTUALIZAR CONTADOR DE BÚSQUEDA
            // ============================================
            function updateSearchCount() {
                var total = $('.product-card').length;
                var visible = $('.product-card:not(.hidden-by-search)').length;
                var $countEl = $('#search-results-count');

                if (currentSearchQuery.length > 0) {
                    $countEl.find('#visible-count').text(visible);
                    $countEl.find('#total-count').text(total);
                    $countEl.addClass('active');
                } else {
                    $countEl.removeClass('active');
                }
            }

            // ============================================
            // INICIALIZAR ISOTOPE DESPUÉS DE CARGAR
            // ============================================
            function initializeAfterLoad() {
                var success = initIsotope();
                if (!success) {
                    setTimeout(function() {
                        var retrySuccess = initIsotope();
                        if (!retrySuccess) {
                            console.warn('No se pudo inicializar Isotope, usando filtrado manual');
                        }
                    }, 500);
                }
            }

            if (document.readyState === 'complete') {
                initializeAfterLoad();
            } else {
                window.addEventListener('load', initializeAfterLoad);
            }

            // ============================================
            // FILTRO POR CATEGORÍA
            // ============================================
            $('#filter-list li').on('click', function() {
                currentCategoryFilter = String($(this).data('filter'));
                $('#filter-list li').removeClass('active');
                $(this).addClass('active');
                applyFilters();
            });

            // ============================================
            // FILTRO POR MARCA CON AUTOCOMPLETADO
            // ============================================
            var $brandSearch = $('#brand-search');
            var $brandSuggestions = $('#brand-suggestions');
            var $selectedBrand = $('#selected-brand');
            var $selectedBrandName = $('#selected-brand-name');
            var $removeBrand = $('#remove-brand');

            $brandSearch.on('focus', function() {
                if (!currentBrandFilter) {
                    $brandSuggestions.addClass('active');
                    filterSuggestions('');
                }
            });

            $(document).on('click', function(e) {
                if (!$(e.target).closest('.brand-filter-wrapper').length) {
                    $brandSuggestions.removeClass('active');
                }
            });

            $brandSearch.on('input', function() {
                var query = $(this).val().toLowerCase().trim();
                filterSuggestions(query);
                if (query.length > 0) {
                    $brandSuggestions.addClass('active');
                } else {
                    $brandSuggestions.removeClass('active');
                }
            });

            function filterSuggestions(query) {
                var $items = $brandSuggestions.find('.suggestion-item');
                var hasResults = false;

                $items.each(function() {
                    var brand = $(this).data('brand').toLowerCase();
                    if (brand.includes(query) && (!currentBrandFilter || brand !== currentBrandFilter
                            .toLowerCase())) {
                        $(this).show();
                        hasResults = true;
                    } else {
                        $(this).hide();
                    }
                });

                $brandSuggestions.find('.no-results').remove();
                if (!hasResults && query.length > 0) {
                    $brandSuggestions.append('<div class="no-results">No se encontraron marcas</div>');
                }
            }

            $brandSuggestions.on('click', '.suggestion-item', function() {
                var brand = $(this).data('brand');
                selectBrand(brand);
                $brandSuggestions.removeClass('active');
                $brandSearch.val('');
            });

            function selectBrand(brand) {
                currentBrandFilter = String(brand);
                $selectedBrandName.text(currentBrandFilter);
                $selectedBrand.show();
                $brandSearch.hide();
                $brandSuggestions.removeClass('active');
                applyFilters();
            }

            $removeBrand.on('click', function() {
                currentBrandFilter = null;
                $selectedBrand.hide();
                $brandSearch.show();
                $brandSearch.val('');
                $brandSuggestions.removeClass('active');
                applyFilters();
            });

            // Inicializar el filtro de marcas con todos los items visibles
            $brandSuggestions.find('.suggestion-item').show();

            // ============================================
            // FILTRO POR BÚSQUEDA DE PRODUCTO
            // ============================================
            var $productSearch = $('#product-search');
            var searchTimeout = null;

            $productSearch.on('input', function() {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(function() {
                    currentSearchQuery = $productSearch.val();
                    applyFilters();
                }, 300);
            });

            // Limpiar búsqueda con Escape
            $productSearch.on('keydown', function(e) {
                if (e.key === 'Escape') {
                    $productSearch.val('');
                    currentSearchQuery = '';
                    applyFilters();
                    $productSearch.blur();
                }
            });

            // ============================================
            // ANIMACIÓN DE ENTRADA
            // ============================================
            $('.product-card').each(function(index) {
                var card = $(this);
                card.css('opacity', '0');
                setTimeout(function() {
                    card.css({
                        'opacity': '1',
                        'transition': 'opacity 0.5s ease'
                    });
                }, 100 * index);
            });

            console.log('Filtros inicializados correctamente');
        });

        // ===== CONTROL DEL MODAL WHATSAPP =====
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
