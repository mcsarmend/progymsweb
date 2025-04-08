<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class accounts_receivable extends Model
{
    use HasFactory;
    protected $table = 'accounts_receivable ';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'remision',
        'abono',
        'fecha_abono',
        'forma_pago ',
        'iduser',
    ];

    protected $guarded = [];
}
