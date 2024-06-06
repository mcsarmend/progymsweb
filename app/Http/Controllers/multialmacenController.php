<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\product;
use App\Models\productprice;
use App\Models\productwarehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\warehouse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Crypt;

class multialmacenController extends Controller
{
    public function multialmacen()
    {
        $type = $this->gettype();
        $products = DB::table('product as p')
            ->select(
                'p.id',
                'p.nombre',
                'b.nombre as marca',
                'c.nombre as categoria',
                DB::raw('SUM(pw.existencias) as existencias')
            )
            ->leftJoin('brand as b', 'p.marca', '=', 'b.id')
            ->leftJoin('category as c', 'p.categoria', '=', 'c.id')
            ->leftJoin('product_warehouse as pw', 'p.id', '=', 'pw.idproducto')
            ->groupBy('p.id', 'p.nombre', 'b.nombre', 'c.nombre')
            ->get();



        return view('almacen.multialmacen', ['type' => $type, 'products' => $products]);
    }
    public function altalmacen()
    {
        $type = $this->gettype();
        return view('almacen.alta', ['type' => $type]);
    }
    public function bajaalmacen()
    {
        $almacenes = warehouse::all();
        $type = $this->gettype();
        return view('almacen.baja', ['type' => $type, 'almacenes' => $almacenes]);
    }
    public function edicionalmacen()
    {
        $type = $this->gettype();
        return view('almacen.edicion', ['type' => $type]);
    }

    public function traspasos()
    {


        $type = $this->gettype();
        $almacenes = warehouse::all();
        $productos = product::all();

        return view('almacen.traspaso', ['type' => $type, 'almacenes' => $almacenes, 'productos' => $productos]);
    }


    public function crearalmacen(Request $request)
    {
        try {
            $almacen = new warehouse();
            $almacen->nombre = $request->almacen;
            $almacen->save();
            return response()->json(['message' => 'Almacén creado correctamente'], 200);
        } catch (\Throwable $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function eliminaralmacen(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;
            $almacenid = Crypt::decrypt($id);
            warehouse::findOrFail($almacenid)->delete();
            return response()->json(['message' => 'Almacén eliminado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function detalleamacenes(Request $request)
    {

        $productosAlmacen = DB::table('product_warehouse as pw')
            ->select('pw.idproducto', 'w.nombre', 'pw.existencias')
            ->leftJoin('warehouse as w', 'pw.idwarehouse', '=', 'w.id')
            ->where('pw.idproducto', '=', $request["id_producto"])
            ->get();

        return $productosAlmacen;
    }
    public function detalleprecios(Request $request)
    {

        $productPrices = ProductPrice::select('product_price.idproducto', 'prices.nombre', 'product_price.price')
            ->leftJoin('prices', 'product_price.idprice', '=', 'prices.id')
            ->where('product_price.idproducto', $request["id_producto"])
            ->orderBy('prices.id')
            ->get();
        return $productPrices;
    }
    public function obtenerproducto(Request $request)
    {

        $productos = Product::select('nombre')
            ->where('nombre', 'like', '%' . $request->term . '%')
            ->get();

        // Verificar si se encontraron productos
        if ($productos->isEmpty()) {
            // Devolver una respuesta indicando que no se encontraron resultados
            return response()->json(['message' => 'No se encontraron productos'], 404);
        }

        // Devolver los productos encontrados
        return response()->json($productos);
    }

    public function realizartraspaso(Request $request)
    {

        try {
            $almacen_origen = $request['almacen_origen'];
            $almacen_destino = $request['almacen_destino'];
            $cantidades =  $request['cantidades'];
            $productos =  $request['productos'];
            $idproductos = [];
            $existencias = 0;
            foreach ($productos as $producto) {
                array_push($idproductos, substr($producto, 0, 10));
            }


            $productosTraspaso = 0;
            $prodcutosNoTraspaso = 0;


            for ($i = 0; $i < count($cantidades); $i++) {
                for ($j = 0; $j < count($idproductos); $j++) {
                    if ($i == $j) {

                        // ACUTALIZAR ALMACEN ORIGEN
                        $existencias_origen = productwarehouse::select('existencias')
                            ->where('idproducto', 'like', '%' . $idproductos[$i] . '%')
                            ->where('idwarehouse', 'like', '%' . $almacen_origen . '%')
                            ->get();
                        $ExisOr = $existencias_origen[0]["existencias"];
                        if ($ExisOr  >= intval($cantidades[$i])) {
                            $nuevaExistenciaOrigen = $ExisOr - intval($cantidades[$i]);
                            ProductWarehouse::where('idproducto', 'like', '%' . $idproductos[$i] . '%')
                                ->where('idwarehouse', 'like', '%' . $almacen_origen . '%')
                                ->update(['existencias' => $nuevaExistenciaOrigen]);

                            // ACTUALIZAR ALMACEN DESTINO
                            $existencias_destino = productwarehouse::select('existencias')
                                ->where('idproducto', 'like', '%' . $idproductos[$i] . '%')
                                ->where('idwarehouse', 'like', '%' . $almacen_destino . '%')
                                ->get();

                            if ($existencias_destino != '[]') {
                                $ExisDest = $existencias_destino[0]["existencias"];
                                $nuevaExistenciaDestino = $ExisDest + intval($cantidades[$i]);
                                ProductWarehouse::where('idproducto', 'like', '%' . $idproductos[$i] . '%')
                                    ->where('idwarehouse', 'like', '%' . $almacen_destino . '%')
                                    ->update(['existencias' => $nuevaExistenciaDestino]);
                            } else {
                                $nueva_existencia_destino = new ProductWarehouse();
                                $nueva_existencia_destino->idproducto = $idproductos[$i];
                                $nueva_existencia_destino->idwarehouse = $almacen_destino;
                                $nueva_existencia_destino->existencias = $cantidades[$i];
                                $nueva_existencia_destino->save();
                                $productosTraspaso++;
                            }
                        } else {
                            $prodcutosNoTraspaso++;
                        }
                    }
                }
            }
            return response()->json(['message' => $productosTraspaso . " Productos traspasados, " . $prodcutosNoTraspaso . " No traspasados"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }

    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
