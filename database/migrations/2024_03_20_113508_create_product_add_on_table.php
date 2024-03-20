<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('product_add_on', function (Blueprint $table) {
            $table->foreignId('product_id')->constrained();
            $table->foreignId('add_on_id')->constrained();
            $table->primary(['product_id', 'add_on_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('product_add_on');
    }
};
