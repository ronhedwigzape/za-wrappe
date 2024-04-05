<?php

namespace Database\Seeders;

use App\Models\Payment;
use App\Models\Receipt;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ReceiptsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $payments = Payment::all();

        foreach ($payments as $payment) {
            Receipt::create([
                'payment_id' => $payment->id,
                'issued_at' => now(),
                'details' => "Payment received for Order ID: {$payment->order_id}. Total amount: {$payment->amount}.", // Simplified example
            ]);
        }
    }
}
