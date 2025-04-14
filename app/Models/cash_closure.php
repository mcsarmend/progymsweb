<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class cash_closure extends Model
{
    use HasFactory;
    protected $table = 'cash_closure';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'nombretotal_efectivo_entregar',
        'total_general',
        'formas_pago',
        'inputs_adicionales',
        'vendedor',
        'fecha_cierre',
        'estado',
        'observaciones',
    ];

    protected $guarded = [];

}
