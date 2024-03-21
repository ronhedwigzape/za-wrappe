<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Flavor;
use App\Models\Category;

class FlavorsTableSeeder extends Seeder
{
    public function run()
    {
        $categoriesWithFlavors = [
            'Shawarma' => ['Pork', 'Chicken', 'Tilapia'],
            'Fruit Soda & Tea' => ['Kiwi', 'Green Apple', 'Strawberry', 'Lychee', 'Lemon', 'Mango', 'Blueberry', 'Pork', 'Chicken', 'Tilapia'],
            'Yakult Series' => ['Kiwi', 'Green Apple', 'Strawberry', 'Lychee', 'Lemon', 'Mango', 'Blueberry', 'Pork', 'Chicken', 'Tilapia'],
        ];

        foreach ($categoriesWithFlavors as $categoryName => $flavors) {
            $category = Category::where('name', $categoryName)->first();

            foreach ($flavors as $flavorName) {
                $flavor = Flavor::firstOrCreate(['name' => $flavorName]);
                $category->flavors()->attach($flavor->id);
            }
        }
    }
}
