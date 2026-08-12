<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class accounts_payable_payments extends Model
{
    use HasFactory;

    protected $table = 'accounts_payable_payments';

    protected $primaryKey = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'proveedor_id',
        'cxp_id',
        'fecha',
        'monto',
        'metodo_pago',
        'acreedor_id',
    ];
}
