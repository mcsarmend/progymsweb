<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAccountPayments extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('account_payments', function (Blueprint $table) {
            $table->id();
            $table->integer('cliente_id');
            $table->integer('cxc_id');
            $table->dateTime('fecha')->nullable();
            $table->decimal('monto', 10, 2)->default(0);
            $table->string('metodo_pago', 50)->nullable();

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('account_payments');
    }
}
