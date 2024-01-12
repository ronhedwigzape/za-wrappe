<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SecurityCompliance extends Model
{
    use HasFactory;

    protected $fillable = [
        'authentication_logs',
        'access_control_info',
        'audit_trails',
    ];
}
