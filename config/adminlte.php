<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Title
    |--------------------------------------------------------------------------
    |
    | Here you can change the default title of your admin panel.
    |
    | For detailed instructions you can look the title section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'title' => '',
    'title_prefix' => '',
    'title_postfix' => '| SELI Net',

    /*
    |--------------------------------------------------------------------------
    | Favicon
    |--------------------------------------------------------------------------
    |
    | Here you can activate the favicon.
    |
    | For detailed instructions you can look the favicon section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'use_ico_only' => true,
    'use_full_favicon' => false,

    /*
    |--------------------------------------------------------------------------
    | Google Fonts
    |--------------------------------------------------------------------------
    |
    | Here you can allow or not the use of external google fonts. Disabling the
    | google fonts may be useful if your admin panel internet access is
    | restricted somehow.
    |
    | For detailed instructions you can look the google fonts section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'google_fonts' => [
        'allowed' => true,
    ],

    /*
    |--------------------------------------------------------------------------
    | Admin Panel Logo
    |--------------------------------------------------------------------------
    |
    | Here you can change the logo of your admin panel.
    |
    | For detailed instructions you can look the logo section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'logo' => '<b>SELI</b>Net',
    'logo_img' => 'assets/images/logo.png',
    'logo_img_class' => 'brand-image img-circle elevation-3',
    'logo_img_xl' => null,
    'logo_img_xl_class' => 'brand-image-xs',
    'logo_img_alt' => 'Admin Logo',

    /*
    |--------------------------------------------------------------------------
    | Authentication Logo
    |--------------------------------------------------------------------------
    |
    | Here you can setup an alternative logo to use on your login and register
    | screens. When disabled, the admin panel logo will be used instead.
    |
    | For detailed instructions you can look the auth logo section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'auth_logo' => [
        'enabled' => false,
        'img' => [
            'path' => 'assets/images/logo.png',
            'alt' => 'Auth Logo',
            'class' => '',
            'width' => 50,
            'height' => 50,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Preloader Animation
    |--------------------------------------------------------------------------
    |
    | Here you can change the preloader animation configuration.
    |
    | For detailed instructions you can look the preloader section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'preloader' => [
        'enabled' => true,
        'img' => [
            'path' => 'assets/images/logo.png',
            'alt' => 'AdminLTE Preloader Image',
            'effect' => 'animation__shake',
            'width' => 60,
            'height' => 60,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | User Menu
    |--------------------------------------------------------------------------
    |
    | Here you can activate and change the user menu.
    |
    | For detailed instructions you can look the user menu section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'usermenu_enabled' => true,
    'usermenu_header' => true,
    'usermenu_header_class' => 'bg-secondary',
    'usermenu_image' => false,
    'usermenu_desc' => true,
    'usermenu_profile_url' => true,

    /*
    |--------------------------------------------------------------------------
    | Layout
    |--------------------------------------------------------------------------
    |
    | Here we change the layout of your admin panel.
    |
    | For detailed instructions you can look the layout section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Layout-and-Styling-Configuration
    |
     */

    'layout_topnav' => false,
    'layout_boxed' => null,
    'layout_fixed_sidebar' => true,
    'layout_fixed_navbar' => null,
    'layout_fixed_footer' => null,
    'layout_dark_mode' => null,

    /*
    |--------------------------------------------------------------------------
    | Authentication Views Classes
    |--------------------------------------------------------------------------
    |
    | Here you can change the look and behavior of the authentication views.
    |
    | For detailed instructions you can look the auth classes section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Layout-and-Styling-Configuration
    |
     */

    'classes_auth_card' => '',
    'classes_auth_header' => 'd-none',
    'classes_auth_body' => '',
    'classes_auth_footer' => 'd-none',
    'classes_auth_icon' => 'fa-lg text-info',
    'classes_auth_btn' => 'btn-flat btn-primary',

    /*
    |--------------------------------------------------------------------------
    | Admin Panel Classes
    |--------------------------------------------------------------------------
    |
    | Here you can change the look and behavior of the admin panel.
    |
    | For detailed instructions you can look the admin panel classes here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Layout-and-Styling-Configuration
    |
     */

    'classes_body' => '',
    'classes_brand' => '',
    'classes_brand_text' => '',
    'classes_content_wrapper' => '',
    'classes_content_header' => '',
    'classes_content' => '',
    'classes_sidebar' => 'sidebar-dark-success elevation-4',
    'classes_sidebar_nav' => '',
    'classes_topnav' => 'navbar-dark  navbar-light',
    'classes_topnav_nav' => 'navbar-expand',
    'classes_topnav_container' => 'container',

    /*
    |--------------------------------------------------------------------------
    | Sidebar
    |--------------------------------------------------------------------------
    |
    | Here we can modify the sidebar of the admin panel.
    |
    | For detailed instructions you can look the sidebar section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Layout-and-Styling-Configuration
    |
     */

    'sidebar_mini' => 'lg',
    'sidebar_collapse' => false,
    'sidebar_collapse_auto_size' => false,
    'sidebar_collapse_remember' => false,
    'sidebar_collapse_remember_no_transition' => true,
    'sidebar_scrollbar_theme' => 'os-theme-light',
    'sidebar_scrollbar_auto_hide' => 'l',
    'sidebar_nav_accordion' => true,
    'sidebar_nav_animation_speed' => 300,

    /*
    |--------------------------------------------------------------------------
    | Control Sidebar (Right Sidebar)
    |--------------------------------------------------------------------------
    |
    | Here we can modify the right sidebar aka control sidebar of the admin panel.
    |
    | For detailed instructions you can look the right sidebar section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Layout-and-Styling-Configuration
    |
     */

    'right_sidebar' => false,
    'right_sidebar_icon' => 'fas fa-cogs',
    'right_sidebar_theme' => 'dark',
    'right_sidebar_slide' => true,
    'right_sidebar_push' => true,
    'right_sidebar_scrollbar_theme' => 'os-theme-light',
    'right_sidebar_scrollbar_auto_hide' => 'l',

    /*
    |--------------------------------------------------------------------------
    | URLs
    |--------------------------------------------------------------------------
    |
    | Here we can modify the url settings of the admin panel.
    |
    | For detailed instructions you can look the urls section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Basic-Configuration
    |
     */

    'use_route_url' => false,
    'dashboard_url' => 'home',
    'logout_url' => 'logout',
    'login_url' => 'login',
    'register_url' => 'register',
    'password_reset_url' => 'password/reset',
    'password_email_url' => 'password/email',
    'profile_url' => false,

    /*
    |--------------------------------------------------------------------------
    | Laravel Mix
    |--------------------------------------------------------------------------
    |
    | Here we can enable the Laravel Mix option for the admin panel.
    |
    | For detailed instructions you can look the laravel mix section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Other-Configuration
    |
     */

    'enabled_laravel_mix' => false,
    'laravel_mix_css_path' => 'css/app.css',
    'laravel_mix_js_path' => 'js/app.js',

    /*
    |--------------------------------------------------------------------------
    | Menu Items
    |--------------------------------------------------------------------------
    |
    | Here we can modify the sidebar/top navigation of the admin panel.
    |
    | For detailed instructions you can look here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Menu-Configuration
    |
     */

    'menu' => [
        // Navbar items:
        // [
        //     'type'         => 'navbar-search',
        //     'text'         => 'search',
        //     'topnav_right' => true,
        // ],
        [
            'type' => 'fullscreen-widget',
            'topnav_right' => true,
        ],

        // Sidebar items:
        // [
        //     'text' => 'Reglas de etiquetado',
        //     'url' => 'admin/settings',
        //     'icon' => 'fas fa-fw fa-pencil-ruler',
        // ],
        // ['header' => 'account_settings'],

        [
            'text' => 'Ventas',
            'icon' => 'fas fa-shopping-cart',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Remisiones',
                    'icon' => 'fas fa-file-alt',
                    'url' => '#',
                    'submenu' => [
                        [
                            'text' => 'Remisionar',
                            'icon' => 'fas fa-file-alt',
                            'url' => 'remisionar',
                        ],
                        [
                            'text' => 'Remisionar Lista',
                            'icon' => 'fas fa-file-alt',
                            'url' => 'remisionarlista',
                        ],
                        [
                            'text' => 'Remisiones',
                            'icon' => 'fas fa-file-signature',
                            'url' => 'remisiones',
                        ],
                        [
                            'text' => 'Corte de caja',
                            'icon' => 'fas fa-money-bill-wave',
                            'url' => 'cortedecaja',
                        ],
                    ],
                ],
                // [
                //     'text' => 'Pedidos',
                //     'icon' => 'fas fa-shopping-cart',
                //     'url' => '#',
                //     'submenu' => [
                //         [
                //             'text' => 'Nuevo',
                //             'icon' => 'fas fa-plus-circle',
                //             'url' => 'altapedidos',
                //         ],
                //     ],
                // ],
            ],
        ],
        [
            'text' => 'CxC',
            'icon' => 'fas fa-money-bill-wave',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Crear CxC',
                    'icon' => 'fas fa-file-invoice-dollar', // Ideal para creación
                    'url' => 'crearcxc',
                ],
                [
                    'text' => 'Abono CxC',
                    'icon' => 'fas fa-hand-holding-usd', // Dinero recibido
                    'url' => 'abonocxc',
                ],
                [
                    'text' => 'Reporte CxC',
                    'icon' => 'fas fa-chart-line', // Gráficos o reportes
                    'url' => 'reportecxc',
                ],
                // [
                //     'text' => 'CxP Cliente',
                //     'icon' => 'fas fa-file-invoice-dollar',
                //     'url'  => 'cxpcliente',
                // ],
            ],
        ],
        [
            'text' => 'Almacén',
            'icon' => 'fas fa-warehouse',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Multialmacen',
                    'icon' => 'fas fa-dolly-flatbed',
                    'url' => 'multialmacen',
                ],
                [
                    'text' => 'Alta',
                    'icon' => 'fas fa-plus-square',
                    'url' => 'altalmacen',
                ],
                [
                    'text' => 'Baja',
                    'icon' => 'fas fa-minus-square',
                    'url' => 'bajaalmacen',
                ],

            ],
        ],
        [
            'text' => 'Inventario',
            'icon' => 'fas fa-archive',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Acciones',
                    'icon' => 'fas fa-tasks',

                    'submenu' => [
                        [
                            'text' => 'Alta Producto',
                            'url' => 'altainventario',
                            'icon' => 'fas fa-plus-square',
                        ],
                        [
                            'text' => 'Multi Alta',
                            'url' => 'multialtainventario',
                            'icon' => 'fas fa-file-import',
                        ],
                        [
                            'text' => 'Baja',
                            'url' => 'bajainventario',
                            'icon' => 'fas fa-minus-square',
                        ],
                        [
                            'text' => 'Edición',
                            'url' => 'edicioninventario',
                            'icon' => 'fas fa-edit',
                        ],
                    ],
                ],
                [
                    'text' => 'Movimientos inventario',
                    'icon' => 'fas fa-user-friends',
                    'submenu' => [
                        [
                            'text' => 'Compras',
                            'url' => 'inventariocompras',
                            'icon' => 'fas fa-shopping-bag',
                        ],
                        [
                            'text' => 'Traspasos',
                            'url' => 'traspasos',
                            'icon' => 'fas fa-exchange-alt',
                        ],
                        [
                            'text' => 'Mermas',
                            'url' => 'inventariomermas',
                            'icon' => 'fas fa-trash-alt',
                        ],
                        [
                            'text' => 'Entrada',
                            'url' => 'ingresoinventario',
                            'icon' => 'fas fa-sign-in-alt',
                        ],
                        [
                            'text' => 'Salida',
                            'url' => 'salidainventario',
                            'icon' => 'fas fa-sign-out-alt',
                        ],
                    ],
                ],
            ],

        ],
        [
            'text' => 'Clientes',
            'icon' => 'fas fa-user-friends',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Alta',
                    'url' => 'altacliente',
                    'icon' => 'fas fa-plus-square',
                ],
                [
                    'text' => 'Baja',
                    'url' => 'bajacliente',
                    'icon' => 'fas fa-minus-square',
                ],
                [
                    'text' => 'Edicion',
                    'url' => 'edicioncliente',
                    'icon' => 'fas fa-edit',
                ],
                [
                    'text' => 'Lista',
                    'url' => 'clientes',
                    'icon' => 'fas fa-user-friends',
                ],

            ],

        ],

        [
            'text' => 'Proveedores',
            'icon' => 'fas fa-truck-loading',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Alta',
                    'url' => 'altaproveedores',
                    'icon' => 'fas fa-plus-square',
                ],
                [
                    'text' => 'Baja',
                    'url' => 'bajaproveedores',
                    'icon' => 'fas fa-minus-square',
                ],
                [
                    'text' => 'Edición',
                    'url' => 'edicionproveedores',
                    'icon' => 'fas fa-edit',
                ],
                [
                    'text' => 'Lista',
                    'url' => 'reporteproveedoreslista',
                    'icon' => 'fas fa-truck-loading',
                ],

            ],
        ],

        [
            'text' => 'Vendedores',
            'icon' => 'fas fa-user-tie',

            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Vendedores',
                    'url' => 'vendedores',
                    'icon' => 'fas fa-user-tie',
                ],
                [
                    'text' => 'Edición',
                    'url' => 'edicionvendedores',
                    'icon' => 'fas fa-edit',
                ],
            ],
        ],
        [
            'text' => 'Asistencias',
            'icon' => 'fas fa-user-tie',

            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Registro Entrada',
                    'url' => 'registroentrada',
                    'icon' => 'fas fas fa-clock',
                ],
                [
                    'text' => 'Registro Salida',
                    'url' => 'registrosalida',
                    'icon' => 'fas fa-sign-out-alt',
                ],
                [
                    'text' => 'Asistencia',
                    'url' => 'asistenciapersonal',
                    'icon' => 'fas fa-file-alt',
                ],
                [
                    'text' => 'Asistencia General',
                    'url' => 'asistenciageneral',
                    'icon' => 'fas fa-file',
                ],
                [
                    'text' => 'Calendario',
                    'url' => 'calendario',
                    'icon' => 'fas fa-calendar',
                ],
                [
                    'text' => 'Vacaciones',
                    'url' => 'vacaciones',
                    'icon' => 'fas fa-sun',
                ],
            ],
        ],
        [
            'text' => 'Precios',
            'icon' => 'fas fa-tag',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Precios',
                    'url' => 'precios',
                    'icon' => 'fas fa-tag',
                ],
                [
                    'text' => 'Alta',
                    'url' => 'altaprecios',
                    'icon' => 'fas fa-plus-square',
                ],
                [
                    'text' => 'Baja',
                    'url' => 'bajaprecios',
                    'icon' => 'fas fa-minus-square',
                ],
                [
                    'text' => 'Edición',
                    'url' => 'edicionprecios',
                    'icon' => 'fas fa-edit',
                ],

            ],
        ],

        [
            'text' => 'Reportes',
            'icon' => 'fas fa-chart-bar',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Movimientos',
                    'icon' => 'fas fa-user-friends',
                    'submenu' => [
                        [
                            'text' => 'Compras',
                            'url' => 'reportemovimientoscompras',
                            'icon' => 'fas fa-shopping-bag',
                        ],
                        [
                            'text' => 'Traspasos',
                            'url' => 'reportemovimientostraspasos',
                            'icon' => 'fas fa-exchange-alt',
                        ],
                        [
                            'text' => 'Mermas',
                            'url' => 'reportemovimientosmermas',
                            'icon' => 'fas fa-trash-alt'
                        ],
                        [
                            'text' => 'Entradas',
                            'url' => 'reportemovimientosentradas',
                            'icon' => 'fas fa-sign-in-alt'
                        ],
                        [
                            'text' => 'Salidas',
                            'url' => 'reportemovimientossalidas',
                            'icon' => 'fas fa-sign-out-alt'
                        ],
                    ],
                ],
                [
                    'text' => 'Inventario',
                    'icon' => 'fas fa-archive',
                    'submenu' => [

                        [
                            'text' => 'Existencias y costos actuales',
                            'url' => 'reporteinventarioexistenciascostos',
                            'icon' => 'fas fa-boxes',
                        ],

                    ],
                ],
                [
                    'text' => 'Remisiones',
                    'icon' => 'fas fa-file-alt',
                    'submenu' => [
                        [
                            'text' => 'Remisiones',
                            'url' => 'reporteremisiones',
                            'icon' => 'fas fa-file-alt',
                        ],
                        [
                            'text' => 'Corte de Caja',
                            'url' => 'reportecortecaja',
                            'icon' => 'fas fa-money-bill-wave',
                        ],

                    ],
                ],

            ],
        ],
        [
            'text' => 'Tareas',
            'icon' => 'fas fa-tasks',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Nueva',
                    'icon' => 'fas fa-plus',
                    'url' => 'tareas',
                ],
                [
                    'text' => 'Delegadas',
                    'icon' => 'fas fa-user-cog',
                    'url' => 'tareasdelegadas',
                ],
            ],
        ],
        [
            'text' => 'Reconocimientos',
            'icon' => 'fas fa-trophy',
            'url' => '#',
            'submenu' => [
                [
                    'text' => 'Nueva',
                    'icon' => 'fas fa-plus',
                    'url' => 'nuevoreconocimiento',
                ],
                [
                    'text' => 'Reconocimientos',
                    'icon' => 'fas fa-trophy',
                    'url' => 'reconocimientos',
                ],
            ],
        ],

    ],

    /*
    |--------------------------------------------------------------------------
    | Menu Filters
    |--------------------------------------------------------------------------
    |
    | Here we can modify the menu filters of the admin panel.
    |
    | For detailed instructions you can look the menu filters section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Menu-Configuration
    |
     */

    'filters' => [
        JeroenNoten\LaravelAdminLte\Menu\Filters\GateFilter::class,
        JeroenNoten\LaravelAdminLte\Menu\Filters\HrefFilter::class,
        JeroenNoten\LaravelAdminLte\Menu\Filters\SearchFilter::class,
        JeroenNoten\LaravelAdminLte\Menu\Filters\ActiveFilter::class,
        JeroenNoten\LaravelAdminLte\Menu\Filters\ClassesFilter::class,
        JeroenNoten\LaravelAdminLte\Menu\Filters\LangFilter::class,
        JeroenNoten\LaravelAdminLte\Menu\Filters\DataFilter::class,
    ],

    /*
    |--------------------------------------------------------------------------
    | Plugins Initialization
    |--------------------------------------------------------------------------
    |
    | Here we can modify the plugins used inside the admin panel.
    |
    | For detailed instructions you can look the plugins section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Plugins-Configuration
    |
     */

    'plugins' => [
        'Datatables' => [
            'active' => true,
            'files' => [
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/1.13.4/js/dataTables.bootstrap4.min.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js',
                ],
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/buttons/2.2.3/js/buttons.print.min.js',
                ],
                [
                    'type' => 'css',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/1.13.4/css/dataTables.bootstrap4.min.css',
                ],
                [
                    'type' => 'css',
                    'asset' => true,
                    'location' => '//cdn.datatables.net/buttons/2.2.3/css/buttons.dataTables.min.css',
                ],
            ],
        ],
        'Select2' => [
            'active' => false,
            'files' => [
                [
                    'type' => 'js',
                    'asset' => false,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js',
                ],
                [
                    'type' => 'css',
                    'asset' => false,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.css',
                ],
            ],
        ],
        'Chartjs' => [
            'active' => false,
            'files' => [
                [
                    'type' => 'js',
                    'asset' => false,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.min.js',
                ],
            ],
        ],
        'Sweetalert2' => [
            'active' => true,
            'files' => [
                [
                    'type' => 'js',
                    'asset' => true,
                    'location' => 'https://cdn.jsdelivr.net/npm/sweetalert2@11',
                ],
            ],
        ],
        'Pace' => [
            'active' => false,
            'files' => [
                [
                    'type' => 'css',
                    'asset' => false,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/pace/1.0.2/themes/blue/pace-theme-center-radar.min.css',
                ],
                [
                    'type' => 'js',
                    'asset' => false,
                    'location' => '//cdnjs.cloudflare.com/ajax/libs/pace/1.0.2/pace.min.js',
                ],
            ],
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | IFrame
    |--------------------------------------------------------------------------
    |
    | Here we change the IFrame mode configuration. Note these changes will
    | only apply to the view that extends and enable the IFrame mode.
    |
    | For detailed instructions you can look the iframe mode section here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/IFrame-Mode-Configuration
    |
     */

    'iframe' => [
        'default_tab' => [
            'url' => null,
            'title' => null,
        ],
        'buttons' => [
            'close' => true,
            'close_all' => true,
            'close_all_other' => true,
            'scroll_left' => true,
            'scroll_right' => true,
            'fullscreen' => true,
        ],
        'options' => [
            'loading_screen' => 1000,
            'auto_show_new_tab' => true,
            'use_navbar_items' => true,
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Livewire
    |--------------------------------------------------------------------------
    |
    | Here we can enable the Livewire support.
    |
    | For detailed instructions you can look the livewire here:
    | https://github.com/jeroennoten/Laravel-AdminLTE/wiki/Other-Configuration
    |
     */

    'livewire' => false,
];
