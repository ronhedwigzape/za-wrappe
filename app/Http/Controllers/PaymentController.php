<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class PaymentController extends Controller
{
    private string $paymongoPublicKey;
    private string $paymongoSecretKey;

    public function __construct() {
        $this->paymongoPublicKey = getenv('PAYMONGO_PUBLIC_KEY');
        $this->paymongoSecretKey = getenv('PAYMONGO_SECRET_KEY');
    }

    // Checkout Session Resource
    public function createCheckoutSession(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/checkout_sessions', [
            // request data here
        ]);

        return $response->json();
    }

    public function retrieveCheckout($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/checkout_sessions/{$id}");

        return $response->json();
    }

    public function expireCheckoutSession($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/checkout_sessions/{$id}/expire");

        return $response->json();
    }

    // Payment Intent Resource
    public function createPaymentIntent(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/payment_intents', [
            // request data here
        ]);

        return $response->json();
    }

    public function retrievePaymentIntent($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/payment_intents/{$id}");

        return $response->json();
    }

    public function attachToPaymentIntent($id, Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/payment_intents/{$id}/attach", [
            // request data here
        ]);

        return $response->json();
    }

    // Payment Method Resource
    public function retrieveMerchantPaymentMethods()
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoPublicKey,
        ])->get('https://api.paymongo.com/v1/payment_methods');

        return $response->json();
    }

    public function createPaymentMethod(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoPublicKey,
        ])->post('https://api.paymongo.com/v1/payment_methods', [
            // request data here
        ]);

        return $response->json();
    }

    public function retrievePaymentMethod($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoPublicKey,
        ])->get("https://api.paymongo.com/v1/payment_methods/{$id}");

        return $response->json();
    }

    public function updatePaymentMethod($id, Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoPublicKey,
        ])->put("https://api.paymongo.com/v1/payment_methods/{$id}", [
            // request data here
        ]);

        return $response->json();
    }

    // Payment Resource
    public function createPayment(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/payments', [
            // request data here
        ]);

        return $response->json();
    }

    public function listAllPayments()
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get('https://api.paymongo.com/v1/payments');

        return $response->json();
    }

    public function retrievePayment($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/payments/{$id}");

        return $response->json();
    }

    // Links API
    public function createLink(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/links', [
            // request data here
        ]);

        return $response->json();
    }

    public function retrieveLink($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/links/{$id}");

        return $response->json();
    }

    public function getLinkByReferenceNumber($reference)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/links/reference/{$reference}");

        return $response->json();
    }

    public function archiveLink($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/links/{$id}/archive");

        return $response->json();
    }

    public function unarchiveLink($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/links/{$id}/unarchive");

        return $response->json();
    }

    // Webhooks
    public function createWebhook(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/webhooks', [
            // request data here
        ]);

        return $response->json();
    }

    public function listAllWebhooks()
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get('https://api.paymongo.com/v1/webhooks');

        return $response->json();
    }

    public function retrieveWebhook($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/webhooks/{$id}");

        return $response->json();
    }

    public function disableWebhook($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/webhooks/{$id}/disable");

        return $response->json();
    }

    public function enableWebhook($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/webhooks/{$id}/enable");

        return $response->json();
    }

    public function updateWebhook($id, Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->put("https://api.paymongo.com/v1/webhooks/{$id}", [
            // request data here
        ]);

        return $response->json();
    }

    // Refunds
    public function createRefund(Request $request)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/refunds', [
            // request data here
        ]);

        return $response->json();
    }

    public function retrieveRefund($id)
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/refunds/{$id}");

        return $response->json();
    }

    public function listAllRefunds()
    {
        $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get('https://api.paymongo.com/v1/refunds');

        return $response->json();
    }

    // Customers
    public function createCustomer(Request $request)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post('https://api.paymongo.com/v1/customers', [
            // request data here
        ]);

        return $response->json();
    }

    public function retrieveCustomer($id)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/customers/{$id}");

        return $response->json();
    }

    public function editCustomer($id, Request $request)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->put("https://api.paymongo.com/v1/customers/{$id}", [
            // request data here
        ]);

        return $response->json();
    }

    public function deleteCustomer($id)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->delete("https://api.paymongo.com/v1/customers/{$id}");

        return $response->json();
    }

    public function retrieveCustomerPaymentMethods($id)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->get("https://api.paymongo.com/v1/customers/{$id}/payment_methods");

        return $response->json();
    }

    public function deleteCustomerPaymentMethod($customerId, $paymentMethodId)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->delete("https://api.paymongo.com/v1/customers/{$customerId}/payment_methods/{$paymentMethodId}");

        return $response->json();
    }

    // Pre-Authorization and Capture
    public function capturePayment($id)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/payments/{$id}/capture");

        return $response->json();
    }

    public function cancelPayment($id)
    {
        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $this->paymongoSecretKey,
        ])->post("https://api.paymongo.com/v1/payments/{$id}/cancel");

        return $response->json();
    }
}

