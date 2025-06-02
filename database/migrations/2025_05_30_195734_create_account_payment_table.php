<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAccountPaymentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('account_payment', function (Blueprint $table) {
            $table->id();
            $table->integer('cliente_id')->unsigned()->nullable(false);
            $table->integer('cxc_id')->unsigned()->nullable(false);
            $table->date('fecha')->nullable(false);
            $table->integer('monto')->nullable(false);
            $table->string('metodo_pago', 50)->nullable(false);

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('account_payment');
    }
}
