<?php

namespace Database\Seeders;

use App\Models\Notification;
use App\Models\Order;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class NotificationsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $orders = Order::all();

        foreach ($orders as $order) {
            // Example of an order confirmation notification
            Notification::create([
                'type' => 'new_order',
                'related_id' => $order->id, // Assuming this relates to the order ID
                'status' => 'delivered',
                'message' => "Thank you for your order. Your order number is {$order->id}.",
                'created_at' => $order->created_at,
                'updated_at' => $order->created_at,
            ]);

            // Additional notifications for other events can be added here
        }
    }
}
