<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function salesReport(Request $request): JsonResponse
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $sales = Order::whereBetween('created_at', [$startDate, $endDate])
            ->where('payment_status', 'Completed')
            ->selectRaw('DATE(created_at) as date, SUM(total_price) as total_sales')
            ->groupBy('date')
            ->get();

        return response()->json([
            'start_date' => $startDate,
            'end_date' => $endDate,
            'sales' => $sales
        ]);
    }

    public function financialReport(Request $request): JsonResponse
    {
        $reportType = $request->input('type', 'daily');

        switch ($reportType) {
            case 'daily':
                $startDate = Carbon::today();
                $endDate = Carbon::tomorrow();
                break;
            case 'weekly':
                $startDate = Carbon::now()->startOfWeek();
                $endDate = Carbon::now()->endOfWeek();
                break;
            case 'monthly':
                $startDate = Carbon::now()->startOfMonth();
                $endDate = Carbon::now()->endOfMonth();
                break;
            default:
                return response()->json(['error' => 'Invalid report type'], 400);
        }

        $salesData = Order::where('payment_status', 'Completed')
            ->whereBetween('created_at', [$startDate, $endDate])
            ->selectRaw('sum(total_price) as total_sales, count(*) as total_orders')
            ->first();

        return response()->json([
            'report_type' => $reportType,
            'start_date' => $startDate->toDateString(),
            'end_date' => $endDate->subDay()->toDateString(),
            'total_sales' => $salesData->total_sales ?? 0,
            'total_orders' => $salesData->total_orders ?? 0,
        ]);
    }
}
