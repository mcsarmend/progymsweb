<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class task extends Model
{
    use HasFactory;
    protected $table = 'task';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'fechainicio',
        'fechafin',
        'asunto',
        'descripcion',
        'autor',
        'objetivo',
        'techaaccion',
    ];

    protected $guarded = [];
}
