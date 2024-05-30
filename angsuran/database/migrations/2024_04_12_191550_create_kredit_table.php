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
        Schema::create('kredit', function (Blueprint $table) {
            $table->id();
            $table->string('nama');
            $table->decimal('jumlah_pinjaman', 20, 2);
            $table->integer('tenor');
            $table->decimal('bunga_floating');
            $table->decimal('bunga');
            $table->decimal('angsuran_perbulan', 20, 2);
            $table->decimal('angsuran_total', 20, 2);
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
        Schema::dropIfExists('kredit');
    }
};
