<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class backup_warehouse extends Model
{
    use HasFactory;
    protected $table = 'backup_warehouse';

	protected $primary_key = 'id';

	public $timestamps = false;

	protected $fillable = [
		'id',
		'datos',
		'total_compra',
		'fecha',
		'total_productos'
	];

	protected $guarded =[];
}
