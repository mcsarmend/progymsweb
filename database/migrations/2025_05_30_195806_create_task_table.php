<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTaskTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('task', function (Blueprint $table) {
            $table->id();
            $table->date('fechainicio')->nullable();
            $table->date('fechafin')->nullable();
            $table->string('asunto', 100)->nullable();
            $table->string('descripcion', 1000)->nullable();
            $table->integer('autor')->nullable();  // Typically references users.id
            $table->integer('objetivo')->nullable(); // Could reference any entity
            $table->dateTime('fechaaccion')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('task');
    }
}
