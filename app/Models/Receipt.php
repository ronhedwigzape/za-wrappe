<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Receipt extends Model
{
    use HasFactory;

    protected $fillable = ['payment_id', 'issued_at', 'details'];

    public function payment(): BelongsTo
    {
        return $this->belongsTo(Payment::class);
    }
}
