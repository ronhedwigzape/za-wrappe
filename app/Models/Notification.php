<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Notification extends Model
{
    use HasFactory;

    protected $fillable = ['type', 'related_id', 'status', 'message'];

    /**
     * Get the owning notifiable model.
     */
    public function notifiable(): MorphTo
    {
        return $this->morphTo();
    }

    /**
     * Scope a query to only include notifications of a given type.
     */
    public function scopeOfType($query, $type)
    {
        return $query->where('type', $type);
    }
}
