<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\brand;
use App\Models\category;
use App\Models\prices;
use App\Models\product;
use App\Models\productprice;
use App\Models\productwarehouse;
use App\Models\stockMovements;
use App\Models\supplier;
use App\Models\warehouse;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;

class inventarioController extends Controller
{
    public function altainventario()
    {
        $type = $this->gettype();
        $marcas = Brand::select('id', 'nombre')
            ->orderBy('nombre', 'asc')
            ->get();
        $categorias = category::select('id', 'nombre')
            ->orderBy('nombre', 'asc')
            ->get();
        $almacenes = warehouse::select('id', 'nombre')
            ->orderBy('nombre', 'asc')
            ->get();
        $precios = prices::select('id', 'nombre')
            ->orderBy('nombre', 'asc')
            ->get();

        return view('inventario.alta', ['type' => $type, 'marcas' => $marcas, 'categorias' => $categorias, 'almacenes' => $almacenes, 'precios' => $precios]);
    }
    public function traspasos()
    {

        $type = $this->gettype();
        $almacenes = warehouse::all();
        $productos = product::all();

        return view('inventario.traspaso', ['type' => $type, 'almacenes' => $almacenes, 'productos' => $productos]);
    }

    public function inventariocompras()
    {

        $type = $this->gettype();
        $sucursales = warehouse::all();
        $productos = product::all();
        $proveedores = supplier::all();

        return view('inventario.compras', ['type' => $type, 'productos' => $productos, 'proveedores' => $proveedores, 'sucursales' => $sucursales]);
    }

    public function inventariomermas()
    {

        $type = $this->gettype();
        $almacenes = warehouse::all();
        $productos = product::all();

        return view('inventario.mermas', ['type' => $type, 'sucursales' => $almacenes, 'productos' => $productos]);
    }

    public function multialtainventario()
    {
        $type = $this->gettype();
        return view('inventario.multialta', ['type' => $type]);
    }
    public function bajainventario()
    {
        $type = $this->gettype();

        $products = DB::table('product as p')
            ->select(
                'p.id',
                'p.nombre',
                'b.nombre as marca',
                'c.nombre as categoria',

            )
            ->leftJoin('brand as b', 'p.marca', '=', 'b.id')
            ->leftJoin('category as c', 'p.categoria', '=', 'c.id')
            ->get();

        return view('inventario.baja', ['type' => $type, 'productos' => $products]);
    }

    public function edicioninventario()
    {
        $type = $this->gettype();

        $products = DB::table('product as p')
            ->select(
                'p.id',
                'p.nombre',
                'b.nombre as marca',
                'c.nombre as categoria',

            )
            ->leftJoin('brand as b', 'p.marca', '=', 'b.id')
            ->leftJoin('category as c', 'p.categoria', '=', 'c.id')
            ->get();

        $almacenes = warehouse::all();

        return view('inventario.edicion', ['type' => $type, 'productos' => $products, 'almacenes' => $almacenes]);
    }
    public function ingresoinventario()
    {
        $type = $this->gettype();
        $almacenes = warehouse::all();
        $productos = product::all();
        return view('inventario.ingreso', ['type' => $type, 'sucursales' => $almacenes, 'productos' => $productos]);
    }
    public function salidainventario()
    {
        $type = $this->gettype();

        $almacenes = warehouse::all();
        $productos = product::all();
        return view('inventario.salida', ['type' => $type, 'sucursales' => $almacenes, 'productos' => $productos]);
    }

    // OTRAS FUNCIONES
    public function altaproducto(Request $request)
    {
        $numero = 0;

        try {

            /* Registra el producto */
            $product = new Product;
            $product->id = $request['codigo'];
            $product->nombre = $request['name'];
            $product->marca = $request['marca'];
            $product->categoria = $request['categoria'];
            $product->costo = $request['costo'];
            $product->save();

            /* Registrar los precios */

            $json_content = $request->getContent();
            parse_str($json_content, $data);
            $precios = [];
            foreach ($data as $key => $value) {
                if (strpos($key, 'precio_') === 0) {
                    $precios[$key] = $value;
                }
            }
            $json_precios = json_encode($precios);
            $arrayprecios = json_decode($json_precios, true);

            foreach ($arrayprecios as $key => $value) {
                $product_price = new productprice();
                $numero = $this->extraerNumero($key);
                $product_price->idproducto = $request['codigo'];
                $product_price->idprice = $numero;
                $product_price->price = $value;
                $product_price->save();
            }

            /* Registrar inventario */

            $productwarehouse = new productwarehouse();
            $productwarehouse->idproducto = $request['codigo'];
            $productwarehouse->idwarehouse = 1;
            $productwarehouse->existencias = $request['existencia'];
            $productwarehouse->save();

            return response()->json(['message' => 'Producto creado correctamente'], 200);
        } catch (\Throwable $th) {

            return response()->json(['error' => $th->getMessage()], 500);
        }
    }
    public function eliminarproducto(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;

            $productid = Crypt::decrypt($id);
            product::findOrFail($productid)->delete();
            return response()->json(['message' => 'Producto eliminado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function multialtaproducto(Request $request)
    {
        $productos = $request->data;

        try {
            foreach ($productos as $producto) {
                $numero = 0;
                /* Registra el producto */
                $product = new Product;
                $product->id = $producto[0];
                $product->nombre = $producto[1];
                $product->marca = $producto[2];
                $product->categoria = $producto[3];
                $product->save();

                /* Registrar los precios */
                for ($i = 1; $i < 5; $i++) {
                    $product_price = new productprice();
                    $product_price->idproducto = $producto[0];
                    $product_price->idprice = $i;
                    $product_price->price = $producto[$i + 4];
                    $product_price->save();
                }

                /* Registrar inventario */

                $productwarehouse = new productwarehouse();
                $productwarehouse->idproducto = $producto[0];
                $productwarehouse->idwarehouse = 1;
                $productwarehouse->existencias = $producto[4];
                $productwarehouse->save();
            }
            return response()->json(['message' => 'Productos creado correctamente'], 200);
        } catch (\Throwable $th) {

            return response()->json(['error' => $th->getMessage()], 500);
        }
    }

    public function extraerNumero($cadena)
    {
        // Buscar la posición del guion bajo
        $posicionGuion = strpos($cadena, '_');
        // Extraer el número después del guion bajo
        $numero = substr($cadena, $posicionGuion + 1);
        return $numero;
    }

    public function enviareditaralmacenes(Request $request)
    {

        try {
            $idproducto = intval($request->id);
            $almacen = $request->almacen;
            $nueva_existencia = floatval($request->nueva_existencia);

            $id_warehouse = warehouse::select('id')
                ->where('nombre', "=", $almacen)
                ->first();

            $idwarehouse = $id_warehouse->id;
            productwarehouse::where('idproducto', '=', $idproducto)
                ->where('idwarehouse', '=', $idwarehouse)
                ->update(['existencias' => $nueva_existencia]);
            return response()->json(['message' => "Producto actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => $th->getMessage()], 500);
        }
    }
    public function enviareditarprecio(Request $request)
    {
        try {
            $idproducto = intval($request->id);
            $tipo = $request->tipo;
            $nuevo_precio = floatval($request->nuevo_precio);

            $idPrice = prices::select('id')
                ->where('nombre', "=", $tipo)
                ->first();

            $id_price = $idPrice->id;
            productprice::where('idproducto', '=', $idproducto)
                ->where('idprice', '=', $id_price)
                ->update(['price' => $nuevo_precio]);
            return response()->json(['message' => "Producto actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => $th->getMessage()], 500);
        }
    }

    public function realizartraspaso(Request $request)
    {
        date_default_timezone_set('America/Mexico_City');
        try {
            $productosTraspaso = 0;
            $prodcutosNoTraspaso = 0;
            $almacen_origen = $request->almacen_origen;
            $almacen_destino = $request->almacen_destino;
            $movimiento = new stockMovements();
            $movimiento->movimiento = $request->movimiento;
            $autor = Auth::user()->id;
            $movimiento->autor = $autor;
            $productos = $request->productos;
            $movimiento->documento = $request->documento;
            $movimiento->importe = $request->importe;
            $now = new DateTime();
            $fdate = $now->format('Y-m-d H:i:s');
            $fechaMysql = $fdate;
            $movimiento->fecha = $fechaMysql;
            $almacen = $request->sucursal;
            $productos = json_decode($request->productos);
            $movimiento->productos = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->save();

            foreach ($productos as $producto) {
                $idproducto = $producto->Codigo;
                $cantidad = $producto->Cantidad;
                // ACUTALIZAR ALMACEN ORIGEN
                $existencias_origen = productwarehouse::select('existencias')
                    ->where('idproducto', 'like', '%' . $idproducto . '%')
                    ->where('idwarehouse', 'like', '%' . $almacen_origen . '%')
                    ->get();

                if ($existencias_origen != '[]') {
                    $ExisOr = $existencias_origen[0]["existencias"];
                    $nuevaExistenciaOrigen = $ExisOr - intval($cantidad);
                    ProductWarehouse::where('idproducto', 'like', '%' . $idproducto . '%')
                        ->where('idwarehouse', 'like', '%' . $almacen_origen . '%')
                        ->update(['existencias' => $nuevaExistenciaOrigen]);

                    // ACTUALIZAR ALMACEN DESTINO
                    $existencias_destino = productwarehouse::select('existencias')
                        ->where('idproducto', 'like', '%' . $idproducto . '%')
                        ->where('idwarehouse', 'like', '%' . $almacen_destino . '%')
                        ->get();

                    if ($existencias_destino != '[]') {
                        $ExisDest = $existencias_destino[0]["existencias"];
                        $nuevaExistenciaDestino = $ExisDest + intval($cantidad);
                        ProductWarehouse::where('idproducto', 'like', '%' . $idproducto . '%')
                            ->where('idwarehouse', 'like', '%' . $almacen_destino . '%')
                            ->update(['existencias' => $nuevaExistenciaDestino]);
                    } else {
                        $nueva_existencia_destino = new ProductWarehouse();
                        $nueva_existencia_destino->idproducto = $idproducto;
                        $nueva_existencia_destino->idwarehouse = $almacen_destino;
                        $nueva_existencia_destino->existencias = $cantidad;
                        $nueva_existencia_destino->save();
                        $productosTraspaso++;
                    }
                } else {
                    return response()->json(['message' => "No cuentas con unidades en el almacen origen"], 500);
                    $prodcutosNoTraspaso++;
                }

            }

            return response()->json(['message' => "Traspaso realizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => "Error: " . $th->getMessage()], 500);
        }

    }

    public function buscarpreciocompras(Request $request)
    {
        $idproducto = $request->id_producto;
        $cantidad = $request->cantidad;
        $idcliente = $request->idcliente;
        $nombre = product::where('id', '=', $idproducto)->value('nombre');
        $costo = product::where('id', '=', $idproducto)->value('costo');
        $idsucursal = $request->sucursal;

        return response()->json([
            'idproducto' => $idproducto,
            'costo' => $costo,
            'nombre' => $nombre,
            'cantidad' => $cantidad,
        ]);

    }

    public function enviarcompra(Request $request)
    {
        date_default_timezone_set('America/Mexico_City');
        try {
            $movimiento = new stockMovements();
            $movimiento->movimiento = $request->movimiento;
            $autor = Auth::user()->id;
            $movimiento->autor = $autor;
            $productos = $request->productos;
            $movimiento->documento = $request->documento;
            $movimiento->importe = $request->importe;
            $now = new DateTime();
            $fdate = $now->format('Y-m-d H:i:s');
            $fechaMysql = $fdate;
            $movimiento->fecha = $fechaMysql;
            $almacen = $request->sucursal;
            $productos = json_decode($request->productos);
            $movimiento->productos = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->save();

            foreach ($productos as $producto) {
                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadDSumar = $producto->Cantidad;

                if ($existenciasActual == "") {
                    $nuevaexistencia = intVal($CantidadDSumar);
                    productwarehouse::insert([
                        'idproducto' => intval($idproducto),
                        'idwarehouse' => intval(1),
                        'existencias' => $nuevaexistencia,
                    ]);
                } else {
                    $nuevaexistencia = $existenciasActual->existencias + intVal($CantidadDSumar);
                    productwarehouse::where('idproducto', intVal($idproducto))
                        ->where('idwarehouse', intVal(1))
                        ->update([
                            'existencias' => $nuevaexistencia,
                        ]);
                }

            }

            return response()->json(['message' => "Entrada realizada correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => "Error: " . $th->getMessage()], 500);
        }

    }
    public function enviarentrada(Request $request)
    {

        try {
            date_default_timezone_set('America/Mexico_City');
            $movimiento = new stockMovements();
            $movimiento->movimiento = $request->movimiento;
            $autor = Auth::user()->id;
            $movimiento->autor = $autor;
            $productos = $request->productos;
            $movimiento->documento = $request->documento;
            $movimiento->importe = $request->importe;
            $now = new DateTime();
            $fdate = $now->format('Y-m-d H:i:s');
            $fechaMysql = $fdate;
            $movimiento->fecha = $fechaMysql;
            $almacen = $request->sucursal;
            $productos = json_decode($request->productos);
            $movimiento->productos = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->save();

            foreach ($productos as $producto) {
                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadDSumar = $producto->Cantidad;

                if ($existenciasActual == "") {
                    $nuevaexistencia = intVal($CantidadDSumar);
                    productwarehouse::insert([
                        'idproducto' => intval($idproducto),
                        'idwarehouse' => intval(1),
                        'existencias' => $nuevaexistencia,
                    ]);
                } else {
                    $nuevaexistencia = $existenciasActual->existencias + intVal($CantidadDSumar);
                    productwarehouse::where('idproducto', intVal($idproducto))
                        ->where('idwarehouse', intVal(1))
                        ->update([
                            'existencias' => $nuevaexistencia,
                        ]);
                }

            }

            return response()->json(['message' => "Compra realizada correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => "Error: " . $th->getMessage()], 500);
        }

    }
    public function enviarmerma(Request $request)
    {
        date_default_timezone_set('America/Mexico_City');
        try {
            $movimiento = new stockMovements();
            $movimiento->movimiento = $request->movimiento;
            $autor = Auth::user()->id;
            $movimiento->autor = $autor;
            $productos = $request->productos;
            $movimiento->documento = $request->documento;
            $movimiento->importe = $request->importe;
            $now = new DateTime();
            $fdate = $now->format('Y-m-d H:i:s');
            $fechaMysql = $fdate;
            $movimiento->fecha = $fechaMysql;
            $almacen = $request->sucursal;
            $productos = json_decode($request->productos);
            $movimiento->productos = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->save();

            foreach ($productos as $producto) {
                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadDSumar = $producto->Cantidad;
                $nuevaexistencia = $existenciasActual->existencias - intVal($CantidadDSumar);

                productwarehouse::where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->update([
                        'existencias' => $nuevaexistencia,
                    ]);
            }

            return response()->json(['message' => "Merma realizada correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => "Error: " . $th->getMessage()], 500);
        }

    }
    public function enviarsalida(Request $request)
    {
        date_default_timezone_set('America/Mexico_City');
        try {
            $movimiento = new stockMovements();
            $movimiento->movimiento = $request->movimiento;
            $autor = Auth::user()->id;
            $movimiento->autor = $autor;
            $productos = $request->productos;
            $movimiento->documento = $request->documento;
            $movimiento->importe = $request->importe;
            $now = new DateTime();
            $fdate = $now->format('Y-m-d H:i:s');
            $fechaMysql = $fdate;
            $movimiento->fecha = $fechaMysql;
            $almacen = $request->sucursal;
            $productos = json_decode($request->productos);
            $movimiento->productos = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->save();

            foreach ($productos as $producto) {
                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadDSumar = $producto->Cantidad;
                $nuevaexistencia = $existenciasActual->existencias - intVal($CantidadDSumar);

                productwarehouse::where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->update([
                        'existencias' => $nuevaexistencia,
                    ]);
            }

            return response()->json(['message' => "Salida realizada correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => "Error: " . $th->getMessage()], 500);
        }

    }

    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
