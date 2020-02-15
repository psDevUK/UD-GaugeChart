# UD-GaugeChart
Google Gauge Component for UniversalDashboard

## How to use
There are two commands to use this command, the **New-UDGaugeChart** this command allows you to define the height 
and width via parameters and the id.  You then need to use the **-Data** parameter to actually feed the data into this
component. The data parameter is a script block parameter, inside this you pass the second command for this component
**New-UDGaugeData** for this data you must specify a label and a value via the parameters for this command. The label must
be a string and the value must be an integer.

## Demo

  In this demo I am going to display my local CPU total amount in a 5 second interval period. The component will automatically
  update. This is the example which is shown in the gif of this module
  
  ```
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
  ```
