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
        Schema::create('financial_reports', function (Blueprint $table) {
            $table->id();
            $table->foreignId('merchant_id')->constrained('users');
            $table->date('period');
            $table->decimal('total_sales', 8, 2);
            $table->integer('total_transactions');
            $table->decimal('refunds', 8, 2)->default(0);
            $table->decimal('net_revenue', 8, 2);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('financial_reports');
    }
};
