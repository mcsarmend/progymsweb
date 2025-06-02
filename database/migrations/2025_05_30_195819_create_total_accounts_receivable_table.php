<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTotalAccountsReceivableTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('total_accounts_receivable', function (Blueprint $table) {
            $table->id();
            $table->integer('idcliente')->unsigned()->nullable(false);
            $table->decimal('total', 10, 2)->nullable(false);
            $table->timestamp('fecha_actualizacion');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('total_accounts_receivable');
    }
}
