<?php

namespace Database\Factories;

use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Order>
 */
class OrderFactory extends Factory
{

    protected $model = Order::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'status' => $this->faker->randomElement(['pending', 'completed']),
            'customer_contact' => $this->faker->phoneNumber,
            'total_price' => $this->faker->randomFloat(2, 10, 500),
            'verification_code' => $this->faker->lexify('??????'),
            'payment_status' => $this->faker->randomElement(['pending', 'completed']),
        ];
    }
}
