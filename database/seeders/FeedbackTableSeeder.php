<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FeedbackTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $feedbackEntries = [
            [
                'customer_contact' => 'jane.doe@example.com',
                'message' => 'I really enjoyed the vegan options! Would love to see more variety in the future.',
                'response' => 'Thank you, Jane! We’re planning to expand our vegan menu soon.',
                'created_at' => Carbon::now()->subDays(10),
                'updated_at' => Carbon::now()->subDays(9),
            ],
            [
                'customer_contact' => 'john.smith@example.com',
                'message' => 'The order process was a bit confusing. Could you make it more intuitive?',
                'response' => null,
                'created_at' => Carbon::now()->subDays(5),
                'updated_at' => Carbon::now()->subDays(5),
            ],
            [
                'customer_contact' => 'alice.wonderland@example.com',
                'message' => 'Loved the ambiance and the friendly staff. Made my day!',
                'response' => 'We’re thrilled to hear you enjoyed your visit, Alice! Hope to see you again soon.',
                'created_at' => Carbon::now()->subDays(2),
                'updated_at' => Carbon::now()->subDay(),
            ],
        ];

        DB::table('feedbacks')->insert($feedbackEntries);
    }
}
