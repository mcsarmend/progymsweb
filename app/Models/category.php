<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class category extends Model
{
    use HasFactory;
    protected $table = 'category';

	protected $primary_key = 'id';

	public $timestamps = false;

	protected $fillable = [
		'id',
		'nombre'
	];

	protected $guarded =[];
}
