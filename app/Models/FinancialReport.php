<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FinancialReport extends Model
{
    use HasFactory;

    protected $fillable = [
        'merchant_id',
        'period',
        'total_sales',
        'total_transactions',
        'refunds',
        'net_revenue',
    ];
}
