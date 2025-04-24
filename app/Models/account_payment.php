<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class account_payment extends Model
{
    use HasFactory;
    protected $table = 'account_payments';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'cliente_id',
        'cxc_id',
        'fecha',
        'monto',
        'metodo_pago',
    ];
}
