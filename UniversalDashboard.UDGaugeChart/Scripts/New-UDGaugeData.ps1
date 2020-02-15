function New-UDGaugeData {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Label,
        [Parameter(Mandatory = $true)]
        [string]$Value
    )
    End {
        [PSCustomObject]@{
            Label = $Label
            Value = $Value
        }
    }
}