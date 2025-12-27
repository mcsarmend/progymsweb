<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class orders extends Model
{
    use HasFactory;
    protected $table = 'orders';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'fecha',
        'nota',
        'vendedor',
        'cliente',
        'productos',
        'total',
        'estatus',
        'metodo_pago'
    ];

    protected $guarded = [];
}
