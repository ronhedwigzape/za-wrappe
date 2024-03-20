<?php

namespace App\Http\Controllers;

use App\Models\AddOn;
use Illuminate\Http\Request;

class AddOnController extends Controller
{
    public function index() {
        return AddOn::all();
    }
}
