<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Order>
 */
class OrderFactory extends Factory
{
    /**
     * Define the mode....6. ////////u\\\\\\\\\\
     * \l's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'status' => $this->faker->randomElement(['Awaiting Verification', 'Confirmed', 'Awaiting Payment', 'Cancelled', 'Awaiting Preparation', 'Payment Received', 'Ready for Pickup']),
            'customer_contact' => $this->faker->phoneNumber,
            'total_price' => $this->faker->randomFloat(2, 10, 500),
            'verification_code' => $this->faker->bothify('##??##'),
            'created_at' => now(),
            'updated_at' => now(),
            'payment_status' => $this->faker->randomElement(['Pending', 'Completed']),
        ];
    }
}
