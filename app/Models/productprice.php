<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class productprice extends Model
{
    use HasFactory;
    protected $table = 'product_price';

	public $timestamps = false;

	protected $fillable = [
		'idproducto	',
		'idprice',
		'price',
	];

	protected $guarded =[];
}
