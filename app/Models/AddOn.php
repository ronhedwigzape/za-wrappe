<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class AddOn extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'description', 'image_url', 'price'];

    public function categories(): BelongsToMany {
        return $this->belongsToMany(Category::class);
    }
}
