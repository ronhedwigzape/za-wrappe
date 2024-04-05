<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\Payment;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PaymentsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = \Faker\Factory::create();

        $orders = Order::all();

        foreach ($orders as $order) {
            Payment::create([
                'order_id' => $order->id,
                'amount' => $order->total_price,
                'transaction_status' => $faker->randomElement(['Pending', 'Completed']),
                'payment_method' => $faker->randomElement(['Cash', 'Credit Card', 'Online']),
                'transaction_id' => strtoupper($faker->bothify('??###???##')),
                'processed_at' => now(),
            ]);
        }
    }
}
