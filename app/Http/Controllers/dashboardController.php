<?php

namespace App\Http\Controllers;

use App\Models\notification;
use App\Models\User;
use DateTime; // Add this line
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class dashboardController extends Controller
{
    public function recuperarcontrasena()
    {
        $usuarios = User::select('id', 'name')->get();
        return view('recuperarcontrasena', ['usuarios' => $usuarios]);
    }

    public function notificaciones()
    {
        $type = $this->gettype();

        return view('notificaciones.nueva', ['type' => $type]);
    }

    public function crearnotificacion(Request $request)
    {
        try {

            // Create a new instance of the notification model
            $notificacion = new notification();

            $date = DateTime::createFromFormat('Y-m-d', $request->fechainicio);
            if ($date) {
                $notificacion->fechainicio = $date->format('Y-m-d');
            } else {
                // Handle invalid date format for fechainicio
                return response()->json(['message' => 'Invalid date format for fechainicio'], 400);
            }

            $date = DateTime::createFromFormat('Y-m-d', $request->fechafin);

            if ($date) {
                $notificacion->fechafin = $date->format('Y-m-d');
            } else {
                // Handle invalid date format for fechafin
                return response()->json(['message' => 'Invalid date format for fechafin'], 400);
            }

            $notificacion->asunto = $request->asunto;
            $notificacion->descripcion = $request->descripcion;
            $notificacion->autor = Auth::user()->id;
            $notificacion->objetivo = $request->objetivo;

            // Save the notification in the database
            $notificacion->save();
            // Return a success response
            return response()->json(['message' => 'Notificación creada correctamente'], 200);
        } catch (\Throwable $e) {
            // Return an error response
            return response()->json(['message' => 'Error al crear el notificacion ' . $e->getMessage()], 500);
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
