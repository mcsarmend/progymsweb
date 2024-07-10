<?php

namespace App\Http\Controllers;

use App\Models\task;
use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {

        $type = Auth::user()->role;
        $iduser = Auth::user()->id;

        $tasks = Task::where('objetivo', $iduser)
            ->leftJoin('users', 'task.autor', '=', 'users.id')
            ->select('task.*', 'users.name as autor2')
            ->get();

        return view('home', ['type' => $type, 'tareas' => $tasks]);
    }
}
