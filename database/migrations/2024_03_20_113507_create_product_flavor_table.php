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
        Schema::create('product_flavor', function (Blueprint $table) {
            $table->foreignId('product_id')->constrained()->onDelete('cascade');
            $table->foreignId('flavor_id')->constrained()->onDelete('cascade');
            $table->primary(['product_id', 'flavor_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('product_flavor');
    }
};
