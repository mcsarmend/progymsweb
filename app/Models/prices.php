<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class prices extends Model
{
    use HasFactory;
    protected $table = 'prices';

	protected $primary_key = 'id';

	public $timestamps = false;

	protected $fillable = [
		'id',
		'nombre'
	];

	protected $guarded =[];
}
