Function New-TextToSpeechMessage {
    <#
    .SYNOPSIS
        This will use Powershell to have a message read out loud through your computer speakers.
     
     
    .NOTES
        Name: New-TextToSpeechMessage
        Author: theSysadminChannel
        Version: 1.0
        DateCreated: 2021-Feb-28
     
    .LINK
        https://thesysadminchannel.com/powershell-text-to-speech-how-to-guide -
     
    .EXAMPLE
        New-TextToSpeechMessage -Message 'This is the text I want to have read out loud' -Voice Zira
    #>
        [CmdletBinding()]
        param(
            [Parameter(
                Position = 0,
                Mandatory = $true
            )]
     
            [string]    $Message,
     
     
            [Parameter(
                Position = 1,
                Mandatory = $false
            )]
     
            [ValidateSet('David', 'Zira')]
            [string]    $Voice = 'Zira'
        )
     
        BEGIN {
            if (-not ([appdomain]::currentdomain.GetAssemblies() | Where-Object {$_.Location -eq 'C:\Windows\Microsoft.Net\assembly\GAC_MSIL\System.Speech\v4.0_4.0.0.0__31bf3856ad364e35\System.Speech.dll'})) {
                Add-Type -AssemblyName System.Speech
            }
        }
     
        PROCESS {
            try {
                $NewMessage = New-Object System.Speech.Synthesis.SpeechSynthesizer
                if ($Voice -eq 'Zira') {
                    $NewMessage.SelectVoice("Microsoft Zira Desktop")
                } else {
                    $NewMessage.SelectVoice("Microsoft David Desktop")
                }
                $NewMessage.Speak($Message)
            } catch {
                Write-Error $_.Exception.Message
            }       
        }
        END {}
    }

while($true) {
    $Response = Invoke-WebRequest -URI 'https://www.1177.se/Vasterbotten/sjukdomar--besvar/lungor-och-luftvagar/inflammation-och-infektion-ilungor-och-luftror/om-covid-19--coronavirus/om-vaccin-mot-covid-19/boka-vaccination-mot-covid-19-vasterbotten/'
    if ($Response.Content.ToString() -split "`n" | Select-String "Du som &auml;r f&ouml;dd" | Select-Object -First 1 | Select-String -Pattern 1991 -SimpleMatch -Quiet) {
        New-TextToSpeechMessage -Message 'Booking has opened for new age group' -Voice David
    }
    Start-Sleep -Seconds 300
}