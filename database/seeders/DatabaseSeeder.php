<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        $this->call([
            RoleTableSeeder::class,
            UsersTableSeeder::class,
            CategoryTableSeeder::class,
            FlavorsTableSeeder::class,
            AddOnsTableSeeder::class,
            ProductsTableSeeder::class,
            OrdersTableSeeder::class,
            OrderItemsTableSeeder::class,
            InventoriesTableSeeder::class,
            CustomerVerificationsTableSeeder::class,
            TransactionSlipsTableSeeder::class,
            PaymentsTableSeeder::class,
            ReceiptsTableSeeder::class,
            NotificationsTableSeeder::class,
            FeedbackTableSeeder::class
        ]);
    }
}
