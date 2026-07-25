$body = @{
    items = @(
        @{ itemCode = "IT0001"; quantity = 3 }
        @{ itemCode = "IT0004"; quantity = 1 }
    )
    shippingAddress = "No 4, Castro Street, Mountain View, CA, USA"
} | ConvertTo-Json -Depth 4

Invoke-RestMethod -Uri "http://localhost:8080/orders" -Method Post -ContentType "application/json" -Body $body -Verbose
