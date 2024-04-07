<?php

namespace App\Http\Controllers;

use App\Models\Feedback;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class FeedbackController extends Controller
{
    // List all feedback
    public function index()
    {
        $feedbacks = Feedback::all();
        return response()->json($feedbacks);
    }

    public function respondToFeedback(Request $request): JsonResponse
    {
        $request->validate([
            'feedback_id' => 'required|exists:feedbacks,id',
            'response' => 'required|string',
        ]);

        $feedback = Feedback::findOrFail($request->feedback_id);
        $feedback->response = $request->response;
        $feedback->save();

        return response()->json(['message' => 'Feedback responded successfully']);
    }
}
