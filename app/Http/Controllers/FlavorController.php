<?php

namespace App\Http\Controllers;

use App\Models\Flavor;
use Illuminate\Http\Request;

class FlavorController extends Controller
{
    public function index() {
        return Flavor::all();
    }
}
