<?php
namespace App\Http\Controllers;

use App\Models\brand;
use App\Models\category;
use App\Models\task;
use App\Models\User;
use Carbon\Carbon; // Add this line
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

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
    public function editarbanners()
    {
        $type = Auth::user()->role;
        return view('editarbanners', ['type' => $type]);

    }
    public function enviareditarbanners(Request $request)
    {
        try {
            // Validar que los archivos sean imágenes
            $rules    = [];
            $messages = [];

            for ($i = 1; $i <= 6; $i++) {
                $rules["banner{$i}_imagen"]          = 'nullable|image|mimes:jpg,jpeg|max:2048';
                $messages["banner{$i}_imagen.mimes"] = "El banner {$i} debe ser una imagen JPG o JPEG";
                $messages["banner{$i}_imagen.max"]   = "El banner {$i} no debe pesar más de 2MB";
                $messages["banner{$i}_imagen.image"] = "El banner {$i} debe ser una imagen válida";
            }

            $request->validate($rules, $messages);

            // Procesar cada banner
            $updatedBanners = [];
            $errors         = [];

            for ($i = 1; $i <= 6; $i++) {
                if ($request->hasFile("banner{$i}_imagen")) {
                    $imagen = $request->file("banner{$i}_imagen");

                    // Nombre fijo del archivo
                    $nombreImagen = "slide_0{$i}.jpg";

                    // Ruta específica para producción (similar a tu ejemplo)
                    $rutaImagenes = public_path('assets/images/');

                    // Crear directorio si no existe
                    if (! file_exists($rutaImagenes)) {
                        mkdir($rutaImagenes, 0777, true);
                    }

                    // Eliminar imagen anterior si existe (solo JPG)
                    $rutaAnterior = $rutaImagenes . $nombreImagen;
                    if (file_exists($rutaAnterior)) {
                        unlink($rutaAnterior);
                    }

                    // Validar dimensiones
                    try {
                        list($width, $height) = getimagesize($imagen->getPathname());

                        // Validar dimensiones exactas
                        if ($width != 1600 || $height != 697) {
                            $errors[] = "El banner {$i} debe tener dimensiones de 1600x697 píxeles (actual: {$width}x{$height})";
                            continue;
                        }
                    } catch (\Exception $e) {
                        $errors[] = "El banner {$i} no es una imagen válida";
                        continue;
                    }

                    // Mover la imagen a la carpeta
                    $imagen->move($rutaImagenes, $nombreImagen);
                    $updatedBanners[] = "Banner {$i} actualizado correctamente";
                }
            }

            // Verificar si hubo errores
            if (! empty($errors)) {
                if (! empty($updatedBanners)) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Algunos banners se actualizaron correctamente, pero otros fallaron',
                        'errors'  => $errors,
                        'updated' => $updatedBanners,
                    ], 422);
                }

                return response()->json([
                    'success' => false,
                    'message' => 'No se pudo actualizar ningún banner',
                    'errors'  => $errors,
                ], 422);
            }

            // Si no se actualizó ningún banner
            if (empty($updatedBanners)) {
                return response()->json([
                    'success' => false,
                    'message' => 'No se seleccionó ninguna imagen para actualizar',
                ], 422);
            }

            return response()->json([
                'success' => true,
                'message' => 'Banners actualizados correctamente',
                'updated' => $updatedBanners,
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors'  => $e->errors(),
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar los banners: ' . $e->getMessage(),
            ], 500);
        }
    }
    public function productos()
    {
        $categories = Category::select('category.*')->get();
        $products   = DB::select('CALL lista_precios_activos()');
        $brands     = Brand::select('brand.*')->get();
        return view('productos', ['products' => $products, 'categories' => $categories, 'brands' => $brands]);
    }
    public function acerca()
    {
        return view('acerca');
    }
    public function contacto()
    {
        return view('contacto');
    }
    public function logininit()
    {
        return view('logininit');
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
