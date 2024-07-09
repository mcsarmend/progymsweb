<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\adminsettingsController;
use App\Http\Controllers\clientesController;
use App\Http\Controllers\comprasController;
use App\Http\Controllers\dashboardController;
use App\Http\Controllers\inventarioController;
use App\Http\Controllers\multialmacenController;
use App\Http\Controllers\pedidosController;
use App\Http\Controllers\preciosController;
use App\Http\Controllers\proveedoresController;
use App\Http\Controllers\usersController;
use App\Http\Controllers\tokenController;
use App\Http\Controllers\vendedorController;
use App\Http\Controllers\ventasController;


/*
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    if (Auth::check()) {
        return redirect('/home');
    } else {
        return view('/welcome');
    }
});

Route::get('/dashboard', function () {
    if (Auth::check()) {
        return redirect('/home');
    } else {
        return view('/welcome');
    }
});



//Rutas
//REMISIONES
Route::get('remisionar', [ventasController::class, 'remisionar'])->middleware(['auth']);
Route::get('remisiones', [ventasController::class, 'remisiones'])->middleware(['auth']);
Route::get('ventasreportes', [ventasController::class, 'ventasreportes'])->middleware(['auth']);
Route::post('buscarprecio', [ventasController::class, 'buscarprecio'])->middleware(['auth']);
Route::post('buscaridprecio', [ventasController::class, 'buscaridprecio'])->middleware(['auth']);
Route::post('validarremision', [ventasController::class, 'validarremision'])->middleware(['auth']);
Route::get('verproductosremision', [ventasController::class, 'verproductosremision'])->middleware(['auth']);
Route::post('cancelarremision', [ventasController::class, 'cancelarremision'])->middleware(['auth']);
Route::get('reporteremisiones', [ventasController::class, 'reporteremisiones'])->middleware(['auth']);




//ALMACEN
Route::get('multialmacen', [multialmacenController::class, 'multialmacen'])->middleware(['auth']);
Route::get('altalmacen', [multialmacenController::class, 'altalmacen'])->middleware(['auth']);
Route::get('bajaalmacen', [multialmacenController::class, 'bajaalmacen'])->middleware(['auth']);
Route::get('edicionalmacen', [multialmacenController::class, 'edicionalmacen'])->middleware(['auth']);
Route::get('traspasos', [multialmacenController::class, 'traspasos'])->middleware(['auth']);
Route::get('multialmacenfiltros', [multialmacenController::class, 'multialmacenfiltros'])->middleware(['auth']);


Route::get('detalleamacenes', [multialmacenController::class, 'detalleamacenes'])->middleware(['auth']);
Route::get('detalleprecios', [multialmacenController::class, 'detalleprecios'])->middleware(['auth']);
Route::get('obtenerproducto', [multialmacenController::class, 'obtenerproducto'])->middleware(['auth']);
Route::post('realizartraspaso', [multialmacenController::class, 'realizartraspaso'])->middleware(['auth']);
Route::post('crearalmacen', [multialmacenController::class, 'crearalmacen'])->middleware(['auth']);
Route::post('eliminaralmacen', [multialmacenController::class, 'eliminaralmacen'])->middleware(['auth']);


//INVENTARIO
Route::get('altainventario', [inventarioController::class, 'altainventario'])->middleware(['auth']);
Route::get('multialtainventario', [inventarioController::class, 'multialtainventario'])->middleware(['auth']);
Route::get('bajainventario', [inventarioController::class, 'bajainventario'])->middleware(['auth']);
Route::get('edicioninventario', [inventarioController::class, 'edicioninventario'])->middleware(['auth']);


Route::post('enviareditarprecio', [inventarioController::class, 'enviareditarprecio'])->middleware(['auth']);
Route::post('enviareditaralmacenes', [inventarioController::class, 'enviareditaralmacenes'])->middleware(['auth']);
Route::post('altaproducto', [inventarioController::class, 'altaproducto'])->middleware(['auth']);
Route::post('eliminarproducto', [inventarioController::class, 'eliminarproducto'])->middleware(['auth']);
Route::post('multialtaproducto', [inventarioController::class, 'multialtaproducto'])->middleware(['auth']);


//CLIENTES
Route::get('clientes', [clientesController::class, 'clientes'])->middleware(['auth']);
Route::get('altacliente', [clientesController::class, 'altacliente'])->middleware(['auth']);
Route::get('bajacliente', [clientesController::class, 'bajacliente'])->middleware(['auth']);
Route::get('edicioncliente', [clientesController::class, 'edicioncliente'])->middleware(['auth']);


Route::post('crearcliente', [clientesController::class, 'crearcliente'])->middleware(['auth']);
Route::post('eliminarcliente', [clientesController::class, 'eliminarcliente'])->middleware(['auth']);
Route::post('editarcliente', [clientesController::class, 'editarcliente'])->middleware(['auth']);





//PROVEEDORES
Route::get('proveedores', [proveedoresController::class, 'proveedores'])->middleware(['auth']);
Route::get('altaproveedores', [proveedoresController::class, 'altaproveedores'])->middleware(['auth']);
Route::get('bajaproveedores', [proveedoresController::class, 'bajaproveedores'])->middleware(['auth']);
Route::get('edicionproveedores', [proveedoresController::class, 'edicionproveedores'])->middleware(['auth']);

Route::post('crearproveedor', [proveedoresController::class, 'crearproveedor'])->middleware(['auth']);
Route::post('eliminarproveedor', [proveedoresController::class, 'eliminarproveedor'])->middleware(['auth']);
Route::post('editarproveedor', [proveedoresController::class, 'editarproveedor'])->middleware(['auth']);


// PRECIOS
Route::get('precios', [preciosController::class, 'precios'])->middleware(['auth']);
Route::get('altaprecios', [preciosController::class, 'altaprecios'])->middleware(['auth']);
Route::get('bajaprecios', [preciosController::class, 'bajaprecios'])->middleware(['auth']);
Route::get('edicionprecios', [preciosController::class, 'edicionprecios'])->middleware(['auth']);

Route::post('crearprecio', [preciosController::class, 'crearprecio'])->middleware(['auth']);
Route::post('eliminarprecio', [preciosController::class, 'eliminarprecio'])->middleware(['auth']);
Route::post('editarprecio', [preciosController::class, 'editarprecio'])->middleware(['auth']);

// VENDEDORES
Route::get('vendedores', [vendedorController::class, 'vendedores'])->middleware(['auth']);
Route::get('altavendedores', [vendedorController::class, 'altavendedores'])->middleware(['auth']);
Route::get('bajavendedores', [vendedorController::class, 'bajavendedores'])->middleware(['auth']);
Route::get('edicionvendedores', [vendedorController::class, 'edicionvendedores'])->middleware(['auth']);

Route::post('crearvendedor', [vendedorController::class, 'crearvendedor'])->middleware(['auth']);
Route::post('eliminarvendedor', [vendedorController::class, 'eliminarvendedor'])->middleware(['auth']);
Route::post('editarvendedor', [vendedorController::class, 'editarvendedor'])->middleware(['auth']);


//COMPRAS
Route::get('altacompras', [comprasController::class, 'altacompras'])->middleware(['auth']);
Route::get('bajacompras', [comprasController::class, 'bajacompras'])->middleware(['auth']);
Route::get('edicioncompras', [comprasController::class, 'edicioncompras'])->middleware(['auth']);


//PEDIDOS
Route::get('altapedidos', [pedidosController::class, 'altapedidos'])->middleware(['auth']);



//OPCIONES
Route::get('admin/settings', [adminsettingsController::class, 'index'])->middleware(['auth']);
Route::get('recuperarcontrasena', [dashboardController::class, 'recuperarcontrasena']);

// Notificaciones
Route::get('notificaciones', [dashboardController::class, 'notificaciones']);
Route::post('crearnotificacion', [dashboardController::class, 'crearnotificacion']);







Route::get('profile/username', [usersController::class, 'usuarios']);
Route::post('guardar-usuario', [usersController::class, 'guardar']);
Route::post('actualizar-usuario', [usersController::class, 'actualizar']);
Route::post('actualizarext', [usersController::class, 'actualizarext']);
Route::post('eliminar', [usersController::class, 'eliminar']);
Route::get('obtener-tipo', [usersController::class, 'obtenerTipo']);


Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

