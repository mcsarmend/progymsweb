<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\clients;
use App\Models\prices;
use App\Models\warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;

class clientesController extends Controller
{
    public function altacliente()
    {
        $type = $this->gettype();
        $prices = prices::all();
        $warehouse = warehouse::all();

        return view('clientes.alta', ['type' => $type, 'prices' => $prices, 'warehouses' => $warehouse]);
    }
    public function bajacliente()
    {
        $clients = clients::all();
        $type = $this->gettype();
        return view('clientes.baja', ['type' => $type, 'clients' => $clients]);
    }
    public function clientes()
    {
        $type = $this->gettype();
        $clients = clients::select('clients.nombre', 'clients.telefono', 'warehouse.nombre as sucursal', 'prices.nombre as precio')
            ->leftJoin('warehouse', 'clients.sucursal', '=', 'warehouse.id')
            ->leftJoin('prices', 'clients.precio', '=', 'prices.id')
            ->get();

        return view('clientes.clientes', ['type' => $type, 'clients' => $clients]);
    }
    public function edicioncliente()
    {
        $type = $this->gettype();
        $clients = clients::all();
        $prices = prices::all();
        $sucursales = warehouse::all();
        return view('clientes.edicion', ['type' => $type, 'clients' => $clients, 'prices' => $prices, 'sucursales' => $sucursales]);
    }

    public function crearcliente(Request $request)
    {
        try {


            // Crear una nueva instancia del modelo Usuario
            $cliente = new clients();
            $cliente->nombre = $request->cliente;
            $cliente->sucursal = intval($request->sucursal);
            $cliente->telefono = $request->telefono;
            $cliente->precio = intval($request->precio);

            // Guardar el usuario en la base de datos
            $cliente->save();
            // Devolver una respuesta de éxito
            return response()->json(['message' => 'Cliente creado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear el cliente'], 500);
        }
    }

    public function eliminarcliente(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;

            $clientid = Crypt::decrypt($id);
            clients::findOrFail($clientid)->delete();
            return response()->json(['message' => 'cliente eliminado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function editarcliente(Request $request)
    {
        try {
            $idcliente = intval(Crypt::decrypt($request->id));
            $nuevo_nombre = $request->nombre;
            $idsucursal = intval(Crypt::decrypt($request->id_sucursal));
            $idprecio = intval(Crypt::decrypt($request->id_price));
            $telefono = $request->telefono;
            clients::where('id', $idcliente)
                ->update([
                    'nombre' => $nuevo_nombre,
                    'sucursal' => $idsucursal,
                    'precio' => $idprecio,
                    'telefono' => $telefono
                ]);
            return response()->json(['message' => "Cliente actualizado correctamente"], 200);
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
