<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class vacation extends Model
{
    use HasFactory;
    protected $table = 'vacation';

    protected $primary_key = 'id';

    public $timestamps = false;

    protected $fillable = [

        'id',
        'id_user',
        'fecha',
        'no_vacacion',
    ];

}
