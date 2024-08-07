<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class notification extends Model
{
    use HasFactory;
    protected $table = 'notification';

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
    ];

    protected $guarded = [];
}
