<?php

namespace App\Http\Controllers;

use App\Models\Link;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;
use App\Events\LinkUpdated;

class LinkController extends Controller
{
    public function generateLinkForUser(Request $request, User $user): JsonResponse
    {
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'amount' => 'required|integer', // Amount in centavos, minimum of 100
            'description' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $validated = $validator->validated();

        // Define the data for the Paymongo link creation
        $linkData = [
            'data' => [
                'attributes' => [
                    'amount' => $validated['amount'],
                    'description' => $validated['description'],
                ],
            ],
        ];

        // Interact with Paymongo API to create a link
        $paymongoResponse = Http::withHeaders([
            'Authorization' => 'Bearer ' . config('services.paymongo.secret_key'),
            'Content-Type' => 'application/json',
        ])->post('https://api.paymongo.com/v1/links', $linkData);

        // Check if the request was successful
        if ($paymongoResponse->successful()) {
            // Decode the response to get the link data
            $paymongoLinkData = $paymongoResponse->json()['data'];

            // Store the link in the database associated with the user
            $link = new Link([
                'user_id' => $user->id,
                'paymongo_link_id' => $paymongoLinkData['id'],
                'amount' => $paymongoLinkData['attributes']['amount'],
                'archived' => $paymongoLinkData['attributes']['archived'],
                'currency' => $paymongoLinkData['attributes']['currency'],
                'description' => $paymongoLinkData['attributes']['description'],
                'livemode' => $paymongoLinkData['attributes']['livemode'],
                'fee' => $paymongoLinkData['attributes']['fee'],
                'remarks' => $paymongoLinkData['attributes']['remarks'],
                'status' => $paymongoLinkData['attributes']['status'],
                'tax_amount' => $paymongoLinkData['attributes']['tax_amount'],
                'checkout_url' => $paymongoLinkData['attributes']['checkout_url'],
                'reference_number' => $paymongoLinkData['attributes']['reference_number'],
                'created_at' => $paymongoLinkData['attributes']['created_at'],
                'updated_at' => $paymongoLinkData['attributes']['updated_at'],
                'payments' => $paymongoLinkData['attributes']['payments'],
            ]);
            $link->save();

            // Dispatch the event
            broadcast(new LinkUpdated($link)); // Dispatch the LinkUpdated event

            // Return the newly created link
            return response()->json($link);
        } else {
            // Handle errors, such as by returning a 500 server error response
            return response()->json(['error' => 'Failed to create link with Paymongo'], 500);
        }
    }

}
