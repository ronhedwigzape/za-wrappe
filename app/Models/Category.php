<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'description', 'image_url'];

    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }

    public function flavors(): BelongsToMany {
        return $this->belongsToMany(Flavor::class);
    }

// In your Category model
    public function addOns(): BelongsToMany {
        return $this->belongsToMany(AddOn::class, 'category_add_on');
    }

}
