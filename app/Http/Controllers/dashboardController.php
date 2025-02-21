<?php
namespace App\Http\Controllers;

use App\Models\category;
use App\Models\task;
use App\Models\User;
use Carbon\Carbon; // Add this line
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;

class dashboardController extends Controller
{
    public function recuperarcontrasena()
    {
        $usuarios = User::select('id', 'name')->get();
        return view('recuperarcontrasena', ['usuarios' => $usuarios]);
    }

    public function tareas()
    {
        $type = $this->gettype();

        $usuarios = User::select('id', 'name')->get();
        return view('tareas.nueva', ['type' => $type, 'usuarios' => $usuarios]);
    }
    public function showDashboard()
    {
        if (Auth::check()) {

            $type   = Auth::user()->role;
            $iduser = Auth::user()->id;

            $tasks = Task::where('objetivo', $iduser)
                ->leftJoin('users', 'task.autor', '=', 'users.id')
                ->select('task.*', 'users.name as autor2')
                ->get();

            return view('home', ['type' => $type, 'tareas' => $tasks]);
        } else {
            $categories = Category::select('category.*')->get();

            $products = DB::select('CALL lista_precios_activos()');
            return view('welcome', ['products' => $products, 'categories' => $categories]);

        }
    }
    public function checkDashboard()
    {

        $type   = Auth::user()->role;
        $iduser = Auth::user()->id;

        $tasks = Task::leftJoin('users', 'task.autor', '=', 'users.id')
            ->select('task.*', 'users.name as autor')
            ->where('task.objetivo', $iduser)
            ->get();

        return view('dashboard', ['type' => $type, 'tareas' => $tasks]);
    }
    public function preguntasfrecuentes()
    {
        return view('preguntasfrecuentes');
    }
    public function politicadeusodirigido()
    {
        return view('politicadeusodirigido');
    }
    public function politicaenvio()
    {
        return view('politicaenvio');
    }
    public function politicaprivacidad()
    {
        return view('politicaprivacidad');
    }

    public function tareasdelegadas()
    {
        $type = $this->gettype();

        $iduser = Auth::user()->id;

        $tasks = Task::where('autor', $iduser)
            ->leftJoin('users', 'task.objetivo', '=', 'users.id')
            ->select('task.*', 'users.name as objetivo2')
            ->get();
        return view('tareas.delegadas', ['type' => $type, 'tareas' => $tasks]);
    }

    public function creartarea(Request $request)
    {
        try {
            $timezone = 'America/Mexico_City';
            $hoy      = Carbon::now($timezone)->format('Y-m-d H:i:s');
            // Create a new instance of the notification model
            $tarea = new task();

            $date = DateTime::createFromFormat('Y-m-d', $request->fechainicio);
            if ($date) {
                $tarea->fechainicio = $date->format('Y-m-d');
            } else {
                // Handle invalid date format for fechainicio
                return response()->json(['message' => 'Invalid date format for fechainicio'], 400);
            }

            $date = DateTime::createFromFormat('Y-m-d', $request->fechafin);

            if ($date) {
                $tarea->fechafin = $date->format('Y-m-d');
            } else {
                // Handle invalid date format for fechafin
                return response()->json(['message' => 'Invalid date format for fechafin'], 400);
            }

            $tarea->asunto      = $request->asunto;
            $tarea->descripcion = $request->descripcion;
            $tarea->fechaaccion = $request->fechaaccion;
            $tarea->autor       = Auth::user()->id;
            $tarea->objetivo    = Crypt::decrypt($request->usuario);

            // Save the notification in the database
            $tarea->save();
            // Return a success response
            return response()->json(['message' => 'Notificación creada correctamente'], 200);
        } catch (\Throwable $e) {
            // Return an error response
            return response()->json(['message' => 'Error al crear el notificacion ' . $e->getMessage()], 500);
        }
    }
    public function marcartarea(Request $request)
    {
        try {

            $idtask = $request->id;

            // Obtener la fecha y hora actual en la zona horaria especificada (Mexico City)
            $timezone = 'America/Mexico_City';
            $hoy      = Carbon::now($timezone)->format('Y-m-d H:i:s');

            // Actualizar la tarea con la fecha y hora actual
            task::where('id', $idtask)
                ->update([
                    'fechaaccion' => $hoy,
                ]);
            return response()->json(['message' => "Tarea actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
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
