<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Flavor;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Product::query()->delete();
        DB::statement('ALTER TABLE products AUTO_INCREMENT = 1;');

        // Categories retrieval
        $shawarmaCategory = Category::where('name', 'Shawarma')->first();
        $fruitSodaTeaCategory = Category::where('name', 'Fruit Soda & Tea')->first();
        $yakultSeriesCategory = Category::where('name', 'Yakult Series')->first();

        // Flavors retrieval
        $shawarmaFlavors = Flavor::whereIn('name', ['Pork', 'Chicken', 'Tilapia'])->get();
        $beverageFlavors = Flavor::whereIn('name', ['Kiwi', 'Green Apple', 'Strawberry'])->get();

        // Shawarma Products
        $shawarmaProducts = [
            ['name' => 'Shawarma Single Order', 'price' => 49.00],
            ['name' => 'Shawarma Buy One, Take One', 'price' => 95.00],
            ['name' => 'Shawarma Rice Single Order', 'price' => 49.00],
            ['name' => 'Shawarma Nachos Single Order', 'price' => 49.00],
        ];

        foreach ($shawarmaProducts as $product) {
            $newProduct = $shawarmaCategory->products()->create([
                'name' => $product['name'],
                'price' => $product['price'],
                'description' => '',
                'active' => true,
            ]);

            // REMIND: We don't attach flavors to Shawarma directly; it's just a template for possible frontend logic.
        }

        // Beverage Products
        $beverageProducts = [
            [
                'category' => $fruitSodaTeaCategory,
                'baseName' => 'Fruit Soda',
                'sizes' => [
                    '12 oz' => 25.00,
                    '16 oz' => 35.00]
            ],
            [
                'category' => $yakultSeriesCategory,
                'baseName' => 'Yakult Series',
                'sizes' => [
                    '12 oz' => 29.00,
                    '16 oz' => 39.00
                ]
            ],
        ];

        foreach ($beverageProducts as $productData) {
            foreach ($productData['sizes'] as $size => $price) {
                foreach ($beverageFlavors as $flavor) {
                    $productName = "{$productData['baseName']} - {$flavor->name} - {$size}";
                    $productData['category']->products()->create([
                        'name' => $productName,
                        'price' => $price,
                        'description' => "A delicious {$size} of {$flavor->name} flavor",
                        'active' => true,
                    ]);
                }
            }
        }

        // REMIND: Add-ons are dynamically applied at order time, not at product creation.
    }
}
