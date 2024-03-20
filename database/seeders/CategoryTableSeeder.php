<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CategoryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Define categories as per the menu
        $categoriesData = [
            ['name' => 'Shawarma', 'description' => 'Delicious Shawarma wraps and more'],
            ['name' => 'Fruit Soda & Tea', 'description' => 'Refreshing fruit soda and tea in various flavors'],
            ['name' => 'Yakult Series', 'description' => 'Healthy Yakult infused drinks'],
        ];

        foreach ($categoriesData as $data) {
            Category::create($data);
        }
    }
}
