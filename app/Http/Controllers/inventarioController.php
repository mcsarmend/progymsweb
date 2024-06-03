<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\brand;
use App\Models\category;
use App\Models\prices;
use App\Models\warehouse;
use App\Models\product;
use App\Models\productprice;
use App\Models\productwarehouse;

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

    public function multialtainventario()
    {
        $type = $this->gettype();
        return view('inventario.multialta', ['type' => $type]);
    }
    public function bajainventario()
    {
        $type = $this->gettype();
        return view('inventario.baja', ['type' => $type]);
    }

    public function edicioninventario()
    {
        $type = $this->gettype();
        return view('inventario.edicion', ['type' => $type]);
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

            return response()->json(['message' => $th->getMessage()], 500);
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
                    $product_price->idprice =  $i;
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

            return response()->json(['message' => $th->getMessage()], 500);
        }
    }

    function extraerNumero($cadena)
    {
        // Buscar la posición del guion bajo
        $posicionGuion = strpos($cadena, '_');
        // Extraer el número después del guion bajo
        $numero = substr($cadena, $posicionGuion + 1);
        return $numero;
    }



    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
