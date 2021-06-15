<#
.SYNOPSIS
    Simple script using Powershell to scrape the Region Västerbotten website for information on when a new 
    age group is able to get the Covid vaccine.

.NOTES
    Name: 1177
    Author: Linus Jonsson
    Version: 1.0
    DateCreated: 2021-06-13
   
.EXAMPLE
    1177.ps1 -Year 1981
#>

param ($Year=1976)

while($true) {
    $Response = Invoke-WebRequest -URI 'https://www.1177.se/Vasterbotten/sjukdomar--besvar/lungor-och-luftvagar/inflammation-och-infektion-ilungor-och-luftror/om-covid-19--coronavirus/om-vaccin-mot-covid-19/boka-vaccination-mot-covid-19-vasterbotten/'
    if ($Response.Content.ToString() -split "`n" | Select-String "Du som &auml;r f&ouml;dd" | Select-Object -First 1 | Select-String -Pattern $Year -SimpleMatch -Quiet) {
        Add-Type -AssemblyName System.Speech
        $NewMessage = New-Object System.Speech.Synthesis.SpeechSynthesizer
        $NewMessage.Speak('Booking has opened for new age group')
    }
    Start-Sleep -Seconds 300
}