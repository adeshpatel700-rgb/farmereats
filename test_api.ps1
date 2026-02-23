# API Test Script for FarmerEats
# This script tests all API endpoints to verify correct configuration

$baseUrl = "https://sowlab.com/assignment"
$headers = @{
    "Content-Type" = "application/json"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FarmerEats API Endpoint Testing" -ForegroundColor Cyan
Write-Host "Base URL: $baseUrl" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Test 1: Login Endpoint
Write-Host "TEST 1: Testing Login Endpoint..." -ForegroundColor Yellow
Write-Host "POST $baseUrl/user/login" -ForegroundColor Gray

$loginPayload = @{
    email = "johndoe@mail.com"
    password = "12345678"
    role = "farmer"
    device_token = "test_device_token_123"
    type = "email"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/user/login" -Method Post -Headers $headers -Body $loginPayload -ErrorAction Stop
    Write-Host "✓ Login endpoint is accessible" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Gray
    $response | ConvertTo-Json -Depth 5 | Write-Host
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "✗ Login endpoint returned status: $statusCode" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 2: Register Endpoint
Write-Host "TEST 2: Testing Register Endpoint..." -ForegroundColor Yellow
Write-Host "POST $baseUrl/user/register" -ForegroundColor Gray

$registerPayload = @{
    full_name = "John Doe"
    email = "johndoe@mail.com"
    phone = "+19876543210"
    password = "12345678"
    role = "farmer"
    business_name = "Dairy Farm"
    informal_name = "London Dairy"
    address = "3663 Marshville Road"
    city = "Poughkeepsie"
    state = "New York"
    zip_code = "12601"
    registration_proof = "my_proof.pdf"
    business_hours = @{
        M = "8:00am - 5:00pm"
        T = "8:00am - 5:00pm"
        W = "8:00am - 5:00pm"
    }
    device_token = "test_device_token_123"
    type = "email"
} | ConvertTo-Json -Depth 5

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/user/register" -Method Post -Headers $headers -Body $registerPayload -ErrorAction Stop
    Write-Host "✓ Register endpoint is accessible" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Gray
    $response | ConvertTo-Json -Depth 5 | Write-Host
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "✗ Register endpoint returned status: $statusCode" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 3: Forgot Password Endpoint
Write-Host "TEST 3: Testing Forgot Password Endpoint..." -ForegroundColor Yellow
Write-Host "POST $baseUrl/user/forgot-password" -ForegroundColor Gray

$forgotPasswordPayload = @{
    mobile = "+1984512598"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/user/forgot-password" -Method Post -Headers $headers -Body $forgotPasswordPayload -ErrorAction Stop
    Write-Host "✓ Forgot Password endpoint is accessible" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Gray
    $response | ConvertTo-Json -Depth 5 | Write-Host
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "✗ Forgot Password endpoint returned status: $statusCode" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 4: Verify OTP Endpoint
Write-Host "TEST 4: Testing Verify OTP Endpoint..." -ForegroundColor Yellow
Write-Host "POST $baseUrl/user/verify-otp" -ForegroundColor Gray

$verifyOtpPayload = @{
    otp = "895642"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/user/verify-otp" -Method Post -Headers $headers -Body $verifyOtpPayload -ErrorAction Stop
    Write-Host "✓ Verify OTP endpoint is accessible" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Gray
    $response | ConvertTo-Json -Depth 5 | Write-Host
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "✗ Verify OTP endpoint returned status: $statusCode" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# Test 5: Reset Password Endpoint
Write-Host "TEST 5: Testing Reset Password Endpoint..." -ForegroundColor Yellow
Write-Host "POST $baseUrl/user/reset-password" -ForegroundColor Gray

$resetPasswordPayload = @{
    token = "895642"
    password = "newpassword123"
    cpassword = "newpassword123"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/user/reset-password" -Method Post -Headers $headers -Body $resetPasswordPayload -ErrorAction Stop
    Write-Host "✓ Reset Password endpoint is accessible" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Gray
    $response | ConvertTo-Json -Depth 5 | Write-Host
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    Write-Host "✗ Reset Password endpoint returned status: $statusCode" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "API Testing Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
