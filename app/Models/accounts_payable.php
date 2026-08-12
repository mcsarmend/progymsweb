<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class accounts_payable extends Model
{
    use HasFactory;

    protected $table = 'accounts_payable';

    protected $primaryKey = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'fecha',
        'monto',
        'saldo_restante', // Nota: en tu BD es 'saldo restante' con espacio
        'estado',
        'proveedor_id',
        'acreedor_id',
    ];
}
