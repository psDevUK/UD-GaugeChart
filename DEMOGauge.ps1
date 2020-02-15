Import-Module -Name universaldashboard.Community -RequiredVersion 2.8.1
Import-Module -Name UniversalDashboard.UDGaugeChart
$init = New-UDEndpointInitialization -Module @("UniversalDashboard.UDGaugeChart") -Function @("New-UDGaugeData")
Get-UDDashboard | Stop-UDDashboard
$theme = New-UDTheme -Name 'Basic' -Definition @{
    'main' = @{
        'padding-left'   = '5px'
        'padding-right'  = '5px'
        'padding-top'    = '5px'
        'padding-bottom' = '5px'
    }
} -Parent 'Default'
Start-UDDashboard -Port 1000 -AutoReload -Dashboard (
    New-UDDashboard -Title 'Powershell UniversalDashboard' -Content {
        New-UDRow -Columns {
            New-UDColumn -size 4 -Endpoint {
                New-UDHeading -Text 'Gauge Chart Example' -Size 3
                New-UDGaugeChart -Id "GoogleGauge" -Height 200 -Width 480 -Data {
                    New-UDGaugeData -Label "CPU" -Value (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average -ExpandProperty Average)
                }
            } -AutoRefresh -RefreshInterval 5


        }
    } -EndpointInitialization $init
)