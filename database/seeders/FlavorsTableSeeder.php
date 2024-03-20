<?php

namespace Database\Seeders;

use App\Models\Flavor;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class FlavorsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $flavors = [
            'Kiwi',
            'Green Apple',
            'Strawberry',
            'Lychee',
            'Lemon',
            'Mango',
            'Blue berry',
            'Pork',
            'Chicken',
            'Tilapia'
        ];

        foreach ($flavors as $flavor) {
            Flavor::create(['name' => $flavor]);
        }
    }
}
