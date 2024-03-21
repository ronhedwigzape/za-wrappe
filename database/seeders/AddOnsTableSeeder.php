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
            ['name' => 'Cheesy Dip', 'price' => 7.00],
            ['name' => 'Spicy Dip', 'price' => 7.00],
        ];

        foreach ($shawarmaAddOns as $addOnData) {
            $addOn = AddOn::firstOrCreate($addOnData);
            $shawarmaCategory->addOns()->attach($addOn->id);
        }

        // 'Add Yakult' is the only add-on for Yakult Series.
        $addYakult = AddOn::firstOrCreate(['name' => 'Add Yakult', 'price' => 15.00]);
        $yakultCategory->addOns()->attach($addYakult->id);
    }
}
