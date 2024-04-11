<?php

namespace Database\Seeders;

use App\Models\AddOn;
use App\Models\Flavor;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OrderItemsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $orders = Order::all();
        $products = Product::all();

        foreach ($orders as $order) {
            foreach ($products->random(rand(1, 3)) as $product) {
                $quantity = rand(1, 5);

                if (in_array($product->id, [1, 2])) {
                    $add_ons = AddOn::find([1, 2]);
                } elseif (in_array($product->id, [5, 6])) {
                    $add_ons = AddOn::find([3]);
                } else {
                    $add_ons = collect([]);
                }

                $add_ons_ids = $add_ons->pluck('id')->toArray();
                $add_ons_price = $add_ons->sum('price') * $quantity;

                $flavor = Flavor::inRandomOrder()->first();

                $subtotal = ($product->price * $quantity) + $add_ons_price;

                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'flavor_id' => optional($flavor)->id,
                    'quantity' => $quantity,
                    'subtotal' => $subtotal,
                    'add_on_ids' => json_encode($add_ons_ids),
                ]);
            }
        }
    }
}
