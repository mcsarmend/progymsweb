<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReferralsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('referrals', function (Blueprint $table) {
            $table->id();
            $table->dateTime('fecha')->nullable();
            $table->string('nota', 100)->nullable();
            $table->string('forma_pago', 100)->nullable();
            $table->integer('almacen')->nullable();
            $table->integer('vendedor')->nullable();
            $table->integer('cliente')->nullable();
            $table->string('productos', 2000)->nullable();
            $table->integer('total')->nullable();
            $table->string('estatus', 100)->nullable();
            $table->integer('tipo_de_precio')->nullable();
            $table->boolean('isar')->default(false);
            $table->boolean('reparto')->default(false);
            $table->integer('vendedor_reparto')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('referrals');
    }
}
