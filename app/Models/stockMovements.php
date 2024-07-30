<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class stockMovements extends Model
{
    use HasFactory;
    protected $table = 'stock_movements';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'movimiento',
        'autor',
        'productos',
        'documento',
        'importe',
        'fecha',
    ];
}
