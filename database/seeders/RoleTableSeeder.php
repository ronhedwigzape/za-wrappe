<?php

namespace Database\Seeders;

use App\Models\Role;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RoleTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $roles = ['Admin', 'Merchant', 'Customer'];
        foreach ($roles as $role) {
            Role::create(['name' => $role, 'description' => "{$role} role"]);
        }
    }
}
