<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAccountsReceivableTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('accounts_receivable', function (Blueprint $table) {
            $table->id();
            $table->integer('cliente_id')->unsigned()->nullable(false);
            $table->date('fecha')->nullable(false);
            $table->decimal('monto', 12, 2)->nullable(false);
            $table->decimal('saldo_restante', 12, 2)->nullable(false);

            // Nullable fields
            $table->integer('remision_id')->unsigned()->nullable();
            $table->integer('vendedor_id')->unsigned()->nullable();

            // Enum field
            $table->enum('estado', ['Pendiente', 'Pagada', 'Cancelada'])->default('Pendiente');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('accounts_receivable');
    }
}
