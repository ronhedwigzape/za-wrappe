<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Inventory extends Model
{
    use HasFactory;

    protected $fillable = ['product_id', 'count', 'low_stock_threshold'];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
}
