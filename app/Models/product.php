<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class product extends Model
{
    use HasFactory;
    protected $table = 'product';

	protected $primary_key = 'id';

	public $timestamps = false;

	protected $fillable = [
		'id',
		'nombre',
		'marca',
		'categoria',
		'almacen1',
		'almacen2',
		'almacen3',
		'almacen4',
		'almacen5',
		'almacen6',
		'almacen7',
		'precio1',
		'precio2',
		'precio3',
		'precio4',
	];

	protected $guarded =[];
}
