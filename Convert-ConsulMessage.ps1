function Convert-ConsulMessage {

<#
    .Synopsis
        Converts Consul Log text into an object.

    .Description
        Converts HashiCorp's Consul log text into an object.  This object can then be used to send to SEQ or other Log tools.

    .Parameter Message
        Consul log message
#>

    [CmdletBinding()]
    Param (
        [Parameter ( Mandatory = $True, ValuefromPipeline = $True )]
        [String]$Message
    )

    Process {
        Write-verbose "Converting text == $Message"
        $Parsed = $Message -split ' ' 

        $parsedObject = New-Object -TypeName PSCustomObject -Property (@{
            'Date' = Get-Date "$Parsed[0] $Parsed[1]"
            'Level' = $Parsed[2]
            'Type' =  $Parsed[3]
            'Message' = $Parsed[4..($Parsed.length-1)]
        })

        Write-Verbose "$($parsedObject | Out-String)"

        Write-output $parsedObject
    }
}
