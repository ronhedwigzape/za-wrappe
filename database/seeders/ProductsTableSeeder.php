<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductsTableSeeder extends Seeder
{
    public function run(): void
    {
        $this->resetProductsTable();

        // Retrieve categories
        $categories = Category::whereIn('name', ['Shawarma', 'Fruit Soda & Tea', 'Yakult Series'])->get()->keyBy('name');

        // Define product base data
        $shawarmaProducts = [
            ['name' => 'Shawarma Single Order', 'price' => 49.00],
            ['name' => 'Shawarma Buy One, Take One', 'price' => 95.00],
        ];

        // Seed Shawarma products
        foreach ($shawarmaProducts as $product) {
            $categories['Shawarma']->products()->create([
                'name' => $product['name'],
                'price' => $product['price'],
                'description' => $product['name'] . ' - Enjoy our delicious ' . strtolower($product['name']) . ' with your favorite add-ons!',
                'active' => true,
            ]);
        }

        // Seed beverage products with a broader range of flavors
        $this->seedBeverageProducts($categories['Fruit Soda & Tea'], 'Fruit Soda');
        $this->seedBeverageProducts($categories['Yakult Series'], 'Yakult Series');
    }

    private function resetProductsTable()
    {
        Product::query()->delete();
        DB::statement('ALTER TABLE products AUTO_INCREMENT = 1;');
    }

    private function seedBeverageProducts($category, $baseName)
    {
        $sizes = ['12 oz' => 25.00, '16 oz' => 35.00];

        // For the Yakult series, 'Add Yakult' option is considered here
        $isYakultSeries = $baseName === 'Yakult Series';
        $additionalCost = $isYakultSeries ? 4.00 : 0;

            foreach ($sizes as $size => $price) {
                $productName = "{$baseName} - {$size}";
                $category->products()->create([
                    'name' => $productName,
                    'price' => $price + $additionalCost,
                    'description' => "A delicious {$size}" . ($isYakultSeries ? " with added Yakult" : ""),
                    'active' => true,
                ]);
            }

    }
}
