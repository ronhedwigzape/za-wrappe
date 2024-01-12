<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Link extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'paymongo_link_id',
        'amount',
        'currency',
        'description',
        'livemode',
        'status',
        'checkout_url',
        'reference_number',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
