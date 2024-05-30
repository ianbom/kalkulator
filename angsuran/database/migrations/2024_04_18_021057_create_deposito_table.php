<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('deposito_table', function (Blueprint $table) {
            $table->id();
            $table->string('nama');
            $table->decimal('deposito', 20, 2);
            $table->integer('jangka_waktu');
            $table->decimal('bunga_deposito');
            $table->decimal('pajak_bank');
            $table->decimal('bunga_sebelum', 20, 2);
            $table->decimal('bunga_sesudah', 20, 2);
            $table->decimal('deposito_akhir', 20, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('deposito');
    }
};
