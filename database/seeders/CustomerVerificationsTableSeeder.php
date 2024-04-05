<?php

namespace Database\Seeders;

use App\Models\CustomerVerification;
use App\Models\Order;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CustomerVerificationsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $orders = Order::all();

        foreach ($orders as $order) {
            CustomerVerification::create([
                'order_id' => $order->id,
                'customer_contact' => $order->customer_contact, // Assuming order has a customer_contact field
                'verification_code' => mt_rand(100000, 999999), // Example verification code
                'verified_at' => now(),
                'attempts' => rand(1, 3), // Number of attempts before verification
            ]);
        }
    }
}
