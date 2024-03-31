<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\AddOn;
use App\Models\Category;

class AddOnsTableSeeder extends Seeder
{
    public function run(): void
    {
        $shawarmaCategory = Category::where('name', 'Shawarma')->first();
        $yakultCategory = Category::where('name', 'Yakult Series')->first();

        $shawarmaAddOns = [
            [
                'name' => 'Cheesy Dip',
                'price' => 7.00,
                'description' => 'A Cheesy Dip add-ons for Shawarma',
                'image_url' => 'cheesy_dip.jpg'
            ],
            [
                'name' => 'Spicy Dip',
                'price' => 7.00,
                'description' => 'A Spicy Dip add-ons for Shawarma',
                'image_url' => 'spicy_dip.jpg'
            ],
        ];

        foreach ($shawarmaAddOns as $addOnData) {
            $addOn = AddOn::firstOrCreate($addOnData);
            $shawarmaCategory->addOns()->attach($addOn->id);
        }

        $addYakultData = [
            'name' => 'Add Yakult',
            'price' => 15.00,
            'description' => 'An additional Yakult to enrich your beverage.',
            'image_url' => 'add_yakult.jpg'
        ];
        $addYakult = AddOn::firstOrCreate($addYakultData);
        $yakultCategory->addOns()->attach($addYakult->id);
    }
}
