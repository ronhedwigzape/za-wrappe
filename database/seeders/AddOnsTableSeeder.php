<?php

namespace Database\Seeders;

use App\Models\AddOn;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AddOnsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $addOns = [
            ['name' => 'Cheesy Dip', 'price' => 7.00],
            ['name' => 'Spicy Dip', 'price' => 7.00],
            ['name' => 'Add Yakult', 'price' => 15.00],
        ];
        foreach ($addOns as $addOn) {
            AddOn::create($addOn);
        }
    }
}
