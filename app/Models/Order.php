<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'status',
        'customer_contact',
        'total_price',
        'verification_code',
        'created_at',
        'updated_at',
        'payment_status'
    ];

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }

    public function customerVerification(): HasOne
    {
        return $this->hasOne(CustomerVerification::class);
    }

    // Define relationship with TransactionSlip
    public function transactionSlip(): HasOne
    {
        return $this->hasOne(TransactionSlip::class, 'order_id');
    }
}
