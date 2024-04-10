<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // User::factory()->count(10)->create();

        User::create([
            'name' => 'Admin',
            'email' => 'admin@zawrappe.com',
            'password' => Hash::make('admin'),
            'role_id' => 1,
        ]);

        User::create([
            'name' => 'Merchant 1',
            'email' => 'merchant1@zawrappe.com',
            'password' => Hash::make('merchant1'),
            'role_id' => 2,
        ]);

        User::create([
            'name' => 'Merchant 2',
            'email' => 'merchant2@zawrappe.com',
            'password' => Hash::make('merchant2'),
            'role_id' => 2,
        ]);

        User::create([
            'name' => 'Customer',
            'email' => 'customer@zawrappe.com',
            'password' => Hash::make('customer'),
            'role_id' => 3,
        ]);
    }
}
