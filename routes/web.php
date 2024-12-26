<?php

use App\Http\Controllers\adminsettingsController;
use App\Http\Controllers\asistenciasController;
use App\Http\Controllers\clientesController;
use App\Http\Controllers\comprasController;
use App\Http\Controllers\cuentasController;
use App\Http\Controllers\dashboardController;
use App\Http\Controllers\inventarioController;
use App\Http\Controllers\multialmacenController;
use App\Http\Controllers\pedidosController;
use App\Http\Controllers\preciosController;
use App\Http\Controllers\proveedoresController;
use App\Http\Controllers\reconocimientosController;
use App\Http\Controllers\reportesController;
use App\Http\Controllers\usersController;
use App\Http\Controllers\vendedorController;
use App\Http\Controllers\ventasController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

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

Route::get('/', [dashboardController::class, 'showDashboard']);
Route::get('/dashboard', [dashboardController::class, 'checkDashboard']);
Route::get('/preguntasfrecuentes', [dashboardController::class, 'preguntasfrecuentes']);
Route::get('/politicadeusodirigido', [dashboardController::class, 'politicadeusodirigido']);
Route::get('/politicaenvio', [dashboardController::class, 'politicaenvio']);
Route::get('/politicaprivacidad', [dashboardController::class, 'politicaprivacidad']);

//Rutas

//CUENTAS
Route::get('cxccliente', [cuentasController::class, 'cxccliente'])->middleware(['auth']);
Route::get('cxpcliente', [cuentasController::class, 'cxpcliente'])->middleware(['auth']);

//REMISIONES
Route::get('remisionar', [ventasController::class, 'remisionar'])->middleware(['auth']);
Route::get('remisiones', [ventasController::class, 'remisiones'])->middleware(['auth']);
Route::get('ventasreportes', [ventasController::class, 'ventasreportes'])->middleware(['auth']);
Route::get('verproductosremision', [ventasController::class, 'verproductosremision'])->middleware(['auth']);
Route::get('cortedecaja', [ventasController::class, 'cortedecaja'])->middleware(['auth']);

Route::post('enviarinfocortecaja', [ventasController::class, 'enviarinfocortecaja'])->middleware(['auth']);
Route::post('buscarprecio', [ventasController::class, 'buscarprecio'])->middleware(['auth']);
Route::post('buscaridprecio', [ventasController::class, 'buscaridprecio'])->middleware(['auth']);
Route::post('validarremision', [ventasController::class, 'validarremision'])->middleware(['auth']);
Route::post('cancelarremision', [ventasController::class, 'cancelarremision'])->middleware(['auth']);

//ALMACEN
Route::get('multialmacen', [multialmacenController::class, 'multialmacen'])->middleware(['auth']);
Route::get('altalmacen', [multialmacenController::class, 'altalmacen'])->middleware(['auth']);
Route::get('bajaalmacen', [multialmacenController::class, 'bajaalmacen'])->middleware(['auth']);
Route::get('edicionalmacen', [multialmacenController::class, 'edicionalmacen'])->middleware(['auth']);
Route::get('multialmacenfiltros', [multialmacenController::class, 'multialmacenfiltros'])->middleware(['auth']);

Route::get('detalleamacenes', [multialmacenController::class, 'detalleamacenes'])->middleware(['auth']);
Route::get('detalleprecios', [multialmacenController::class, 'detalleprecios'])->middleware(['auth']);
Route::get('obtenerproducto', [multialmacenController::class, 'obtenerproducto'])->middleware(['auth']);
Route::post('crearalmacen', [multialmacenController::class, 'crearalmacen'])->middleware(['auth']);
Route::post('eliminaralmacen', [multialmacenController::class, 'eliminaralmacen'])->middleware(['auth']);

//INVENTARIO
Route::get('altainventario', [inventarioController::class, 'altainventario'])->middleware(['auth']);
Route::get('multialtainventario', [inventarioController::class, 'multialtainventario'])->middleware(['auth']);
Route::get('bajainventario', [inventarioController::class, 'bajainventario'])->middleware(['auth']);
Route::get('edicioninventario', [inventarioController::class, 'edicioninventario'])->middleware(['auth']);
Route::get('traspasos', [inventarioController::class, 'traspasos'])->middleware(['auth']);
Route::get('inventariocompras', [inventarioController::class, 'inventariocompras'])->middleware(['auth']);
Route::get('inventariomermas', [inventarioController::class, 'inventariomermas'])->middleware(['auth']);
Route::get('ingresoinventario', [inventarioController::class, 'ingresoinventario'])->middleware(['auth']);
Route::get('salidainventario', [inventarioController::class, 'salidainventario'])->middleware(['auth']);

Route::post('enviarsalida', [inventarioController::class, 'enviarsalida'])->middleware(['auth']);
Route::post('enviarentrada', [inventarioController::class, 'enviarentrada'])->middleware(['auth']);
Route::post('enviarmerma', [inventarioController::class, 'enviarmerma'])->middleware(['auth']);
Route::post('enviarcompra', [inventarioController::class, 'enviarcompra'])->middleware(['auth']);
Route::post('buscarpreciocompras', [inventarioController::class, 'buscarpreciocompras'])->middleware(['auth']);
Route::post('enviareditarprecio', [inventarioController::class, 'enviareditarprecio'])->middleware(['auth']);
Route::post('enviareditaralmacenes', [inventarioController::class, 'enviareditaralmacenes'])->middleware(['auth']);
Route::post('altaproducto', [inventarioController::class, 'altaproducto'])->middleware(['auth']);
Route::post('eliminarproducto', [inventarioController::class, 'eliminarproducto'])->middleware(['auth']);
Route::post('multialtaproducto', [inventarioController::class, 'multialtaproducto'])->middleware(['auth']);
Route::post('realizartraspaso', [inventarioController::class, 'realizartraspaso'])->middleware(['auth']);

//CLIENTES
Route::get('clientes', [clientesController::class, 'clientes'])->middleware(['auth']);
Route::get('altacliente', [clientesController::class, 'altacliente'])->middleware(['auth']);
Route::get('bajacliente', [clientesController::class, 'bajacliente'])->middleware(['auth']);
Route::get('edicioncliente', [clientesController::class, 'edicioncliente'])->middleware(['auth']);
Route::get('verdireccioncliente', [clientesController::class, 'verdireccioncliente'])->middleware(['auth']);

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

//ASISTENCIAS
Route::get('registroentrada', [asistenciasController::class, 'registroentrada'])->middleware(['auth']);
Route::get('registrosalida', [asistenciasController::class, 'registrosalida'])->middleware(['auth']);
Route::get('asistenciapersonal', [asistenciasController::class, 'asistenciapersonal'])->middleware(['auth']);
Route::get('asistenciageneral', [asistenciasController::class, 'asistenciageneral'])->middleware(['auth']);
Route::get('calendario', [asistenciasController::class, 'calendario'])->middleware(['auth']);
Route::get('vacaciones', [asistenciasController::class, 'vacaciones'])->middleware(['auth']);
Route::get('getvacaciones', [asistenciasController::class, 'getvacaciones'])->middleware(['auth']);
Route::get('obtenerincidencia', [asistenciasController::class, 'obtenerincidencia'])->middleware(['auth']);

Route::post('cancelarincidencia', [asistenciasController::class, 'cancelarincidencia'])->middleware(['auth']);
Route::post('calendarioincidencias', [asistenciasController::class, 'calendarioincidencias'])->middleware(['auth']);
Route::post('marcarincidencia', [asistenciasController::class, 'marcarincidencia'])->middleware(['auth']);
Route::post('asistencia_graficas', [asistenciasController::class, 'asistencia_graficas'])->middleware(['auth']);
Route::post('registrarentrada', [asistenciasController::class, 'registrarentrada'])->middleware(['auth']);
Route::post('registrarsalida', [asistenciasController::class, 'registrarsalida'])->middleware(['auth']);
Route::post('reporteasistenciaspersonal', [asistenciasController::class, 'reporteasistenciaspersonal'])->middleware(['auth']);

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

// TAREAS
Route::get('tareas', [dashboardController::class, 'tareas']);
Route::post('creartarea', [dashboardController::class, 'creartarea']);
Route::get('tareasdelegadas', [dashboardController::class, 'tareasdelegadas']);
Route::post('marcartarea', [dashboardController::class, 'marcartarea']);

// LAN DING PAGE
Route::get('table-products', [dashboardController::class, 'get_productos']);

// RECONOCIMIENTOS
Route::get('reconocimientos', [reconocimientosController::class, 'reconocimientos']);
Route::get('nuevoreconocimiento', [reconocimientosController::class, 'nuevoreconocimiento']);

// REPORTES
Route::get('reportemovimientoscompras', [reportesController::class, 'reportemovimientoscompras'])->middleware(['auth']);
Route::get('reportemovimientostraspasos', [reportesController::class, 'reportemovimientostraspasos'])->middleware(['auth']);
Route::get('reportemovimientosmermas', [reportesController::class, 'reportemovimientosmermas'])->middleware(['auth']);
Route::get('reportemovimientosentradas', [reportesController::class, 'reportemovimientosentradas'])->middleware(['auth']);
Route::get('reportemovimientossalidas', [reportesController::class, 'reportemovimientossalidas'])->middleware(['auth']);
Route::get('reporteremisiones', [reportesController::class, 'reporteremisiones'])->middleware(['auth']);
Route::get('reporteinventariolistaprecios', [reportesController::class, 'reporteinventariolistaprecios'])->middleware(['auth']);
Route::get('reporteinventarioexistenciascostos', [reportesController::class, 'reporteinventarioexistenciascostos'])->middleware(['auth']);
Route::get('reporteclienteslista', [reportesController::class, 'reporteclienteslista'])->middleware(['auth']);
Route::get('reporteclientescompras', [reportesController::class, 'reporteclientescompras'])->middleware(['auth']);
Route::get('reporteproveedoreslista', [reportesController::class, 'reporteproveedoreslista'])->middleware(['auth']);
Route::get('verproductosmovimiento', [reportesController::class, 'verproductosmovimiento'])->middleware(['auth']);

Route::get('generarreporteremisiones', [reportesController::class, 'generarreporteremisiones'])->middleware(['auth']);
Route::get('generarreportecompras', [reportesController::class, 'generarreportecompras'])->middleware(['auth']);
Route::get('generarreportetraspasos', [reportesController::class, 'generarreportetraspasos'])->middleware(['auth']);
Route::get('generarreportemermas', [reportesController::class, 'generarreportemermas'])->middleware(['auth']);
Route::get('generarreporteentradas', [reportesController::class, 'generarreporteentradas'])->middleware(['auth']);
Route::get('generarreportesalidas', [reportesController::class, 'generarreportesalidas'])->middleware(['auth']);

//OPCIONES
Route::get('admin/settings', [adminsettingsController::class, 'index'])->middleware(['auth']);
Route::get('recuperarcontrasena', [dashboardController::class, 'recuperarcontrasena']);

Route::get('profile/username', [usersController::class, 'usuarios']);
Route::post('crearusuario', [usersController::class, 'crearusuario']);
Route::post('actualizarusuario', [usersController::class, 'actualizarusuario']);
Route::post('actualizarext', [usersController::class, 'actualizarext']);
Route::post('eliminar', [usersController::class, 'eliminarusuario']);
Route::get('obtener-tipo', [usersController::class, 'obtenerTipo']);

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
