<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class creditors extends Model
{
    use HasFactory;
    protected $table = 'creditors';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'nombre',
        'telefono',
    ];
}
