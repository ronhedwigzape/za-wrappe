<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\TransactionSlip;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class TransactionSlipsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $orders = Order::all();

        foreach ($orders as $order) {
            TransactionSlip::create([
                'order_id' => $order->id,
                'issued_at' => now(),
                'code' => strtoupper(Str::random(10)),
            ]);
        }
    }
}
