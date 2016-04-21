function Invoke-MegaDlAsJob () {
    [CmdletBinding()]
    param(
        $MegaDL,
        $DownloadTo,
        $Url
    )


    $job = Start-Job -ArgumentList @($MegaDL, $DownloadTo, $Url) -ScriptBlock {
        & $args[0] $args[2] --path $args[1]
    }

    Write-Output $job
}