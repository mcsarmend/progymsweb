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
use App\Http\Controllers\proveedoresController;
use App\Http\Controllers\usersController;
use App\Http\Controllers\tokenController;
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
Route::get('remisionar',[ventasController::class, 'remisionar'])->middleware(['auth']);
Route::get('remisiones',[ventasController::class, 'remisiones'])->middleware(['auth']);
Route::get('ventasreportes',[ventasController::class, 'ventasreportes'])->middleware(['auth']);


Route::get('multialmacen',[multialmacenController::class, 'multialmacen'])->middleware(['auth']);
Route::get('altalmacen',[multialmacenController::class, 'altalmacen'])->middleware(['auth']);
Route::get('bajaalmacen',[multialmacenController::class, 'bajaalmacen'])->middleware(['auth']);
Route::get('edicionalmacen',[multialmacenController::class, 'edicionalmacen'])->middleware(['auth']);
Route::get('traspasos',[multialmacenController::class, 'traspasos'])->middleware(['auth']);


Route::get('detalleamacenes',[multialmacenController::class, 'detalleamacenes'])->middleware(['auth']);
Route::get('detalleprecios',[multialmacenController::class, 'detalleprecios'])->middleware(['auth']);
Route::get('obtenerproducto',[multialmacenController::class, 'obtenerproducto'])->middleware(['auth']);
Route::post('realizartraspaso',[multialmacenController::class, 'realizartraspaso'])->middleware(['auth']);
Route::post('crearalmacen',[multialmacenController::class, 'crearalmacen'])->middleware(['auth']);
Route::post('eliminaralmacen',[multialmacenController::class, 'eliminaralmacen'])->middleware(['auth']);



Route::get('altainventario',[inventarioController::class, 'altainventario'])->middleware(['auth']);
Route::get('multialtainventario',[inventarioController::class, 'multialtainventario'])->middleware(['auth']);
Route::get('bajainventario',[inventarioController::class, 'bajainventario'])->middleware(['auth']);
Route::get('edicioninventario',[inventarioController::class, 'edicioninventario'])->middleware(['auth']);


Route::post('enviareditarprecio',[inventarioController::class, 'enviareditarprecio'])->middleware(['auth']);
Route::post('enviareditaralmacenes',[inventarioController::class, 'enviareditaralmacenes'])->middleware(['auth']);
Route::post('altaproducto',[inventarioController::class, 'altaproducto'])->middleware(['auth']);
Route::post('eliminarproducto',[inventarioController::class, 'eliminarproducto'])->middleware(['auth']);
Route::post('multialtaproducto',[inventarioController::class, 'multialtaproducto'])->middleware(['auth']);


Route::get('altacliente',[clientesController::class, 'altacliente'])->middleware(['auth']);
Route::get('bajacliente',[clientesController::class, 'bajacliente'])->middleware(['auth']);
Route::get('edicioncliente',[clientesController::class, 'edicioncliente'])->middleware(['auth']);

Route::get('altaproveedores',[proveedoresController::class, 'altaproveedores'])->middleware(['auth']);
Route::get('bajaproveedores',[proveedoresController::class, 'bajaproveedores'])->middleware(['auth']);
Route::get('edicionproveedores',[proveedoresController::class, 'edicionproveedores'])->middleware(['auth']);

Route::get('altacompras',[comprasController::class, 'altacompras'])->middleware(['auth']);
Route::get('bajacompras',[comprasController::class, 'bajacompras'])->middleware(['auth']);
Route::get('edicioncompras',[comprasController::class, 'edicioncompras'])->middleware(['auth']);

Route::get('altapedidos',[pedidosController::class, 'altapedidos'])->middleware(['auth']);




Route::get('admin/settings',[adminsettingsController::class, 'index'])->middleware(['auth']);
Route::get('recuperarcontrasena',[dashboardController::class, 'recuperarcontrasena']);







Route::get('profile/username', [usersController::class, 'usuarios']);
Route::post('guardar-usuario', [usersController::class, 'guardar']);
Route::post('actualizar-usuario', [usersController::class, 'actualizar']);
Route::post('actualizarext', [usersController::class, 'actualizarext']);
Route::post('eliminar', [usersController::class, 'eliminar']);
Route::get('obtener-tipo', [usersController::class, 'obtenerTipo']);


Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

