function Convert-ConsulMessage {

<#
    .Synopsis
        Converts Consul Log text into an object.

    .Description
        Converts HashiCorp's Consul log text into an object.  This object can then be used to send to SEQ or other Log tools.

    .Parameter Message
        Consul log message

    .Example
        Converts a log message to an object.

        '2017/06/28 08:11:04 [INFO] raft: Node at 192.168.0.65:8300 [Candidate] entering Candidate state in term 283415' | Convert-ConsulMessage

    .Example
        Consule log piped to Convert

        consul.exe monitor | Convert-ConsulMessage

    .Notes
        Author : Jeff Buenting
        Date : 2017 JUN 28
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
            'Date' = Get-Date "$($Parsed[0]) $($Parsed[1])"
            'Level' = $Parsed[2]
            'Type' =  $Parsed[3]
            'Message' = $Parsed[4..($Parsed.length-1)]
        })

        Write-Verbose "$($parsedObject | FL * | Out-String)"

        Write-output $parsedObject
    }
}
