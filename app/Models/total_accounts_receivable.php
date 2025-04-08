<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class total_accounts_receivable extends Model
{
    use HasFactory;
    protected $table = 'total_accounts_receivable ';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'idcliente ',
        'total ',
        'fecha_actualizacion',
    ];

    protected $guarded = [];
}
