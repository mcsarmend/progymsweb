<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class incidents extends Model
{
    use HasFactory;
    protected $table = 'incidents';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'iduser',
        'fecha',
        'tipo',
        'descripcion',
    ];

    protected $guarded = [];
}
