<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class HelpController extends Controller
{
    public function index(): JsonResponse
    {
        $helpInfo = "Your help information here...";
        return response()->json($helpInfo, Response::HTTP_OK);
    }
}
