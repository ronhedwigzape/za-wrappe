<?php

namespace Database\Factories;

use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Payment>
 */
class PaymentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'order_id' => Order::factory(),
            'amount' => $this->faker->randomFloat(2, 10, 500),
            'transaction_status' => $this->faker->randomElement(['pending', 'completed']),
            'payment_method' => $this->faker->randomElement(['cash', 'credit_card', 'online']),
            'transaction_id' => $this->faker->uuid,
            'processed_at' => $this->faker->dateTime(),
        ];
    }
}
