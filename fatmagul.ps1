<#
.SYNOPSIS
Download Fatmagul (Spanish) from Mega. I didn't share them. I just found them here: http://fatmagulnovelaturca.blogspot.com/
.DESCRIPTION
I've saved all the mega_urls in case the site changes. I can just switch to that. 
I browse the site, to travers all his 'adf.ly' links though so the sharer might get the ad-credit he desires.

*Important*:
This does not validate and re-download in case your download didn't finish. If the file exists, the download is skipped.
I had two episodes that didn't download completely. I just deleted those and re-ran this script to get them again.
.PARAMETER MegaDL
The path to the `megadl.exe`. Must be a [PathInfo] Object; see examples.
.PARAMETER DownloadTo
The path to download to. Must be a [PathInfo] Object; see examples.
.PARAMETER UsePreSavedMegaUrls
If this switch is set, the previously acquired Mega URLS will be used.

Otherwise, the blog will be parsed and will look at all the 'adf.ly' links to get the Mega URLs. This might help the OP get ad credit ... /shrug
.EXAMPLE
$MegaDL = (Resolve-Path "..\megatools-1.9.97-win64\megadl.exe")
$DownloadTo = (Resolve-Path "..\Fatmagul")
.\fatmagul.ps1 -MegaDL $MegaDL -DownloadTo $DownloadTo -Verbose
.NOTES
You will need MegaTools (https://megatools.megous.com).
.LINK
http://fatmagulnovelaturca.blogspot.com/
#>
[CmdletBinding()]
param(
    [Parameter(
        Position=0,
        HelpMessage="Path to 'megadl.exe'. Download MegaTools from: https://megatools.megous.com"
    )]
    [System.Management.Automation.PathInfo]
    $MegaDL = (Resolve-Path "$(Split-Path $PSScriptRoot -Parent)\megatools-1.9.97-win64\megadl.exe")
    ,
    [Parameter(
        Position=1,
        HelpMessage="Path to download the files to."
    )]
    [System.Management.Automation.PathInfo]
    $DownloadTo = (Resolve-Path "$(Split-Path $PSScriptRoot -Parent)\Media\TV\Fatmagul")
    ,
    [switch]
    $UsePreSavedMegaUrls
)

# To help the OP since you want his wares, click a few of the Adf.ly links
# Start-Process 'http://fatmagulnovelaturca.blogspot.com'

# Import all of our functions
foreach ($file in (Get-ChildItem "${PSScriptRoot}\functions" -File -ErrorAction Stop)) {
    . $file.FullName
}

$mega_urls = Get-FatmagulMegaUrls

# Rename everything back to original so we don't re-download.
Get-ChildItem $DownloadTo | ConvertFrom-PlexNamingConvention

# Download everything, and fix names.
$jobs = @{}

foreach ($url in $mega_urls) {
    while ((Get-Job -State 'Running' | Measure-Object).Count -gt 5) {
        Start-Sleep -Seconds 10
    }

    $job = Invoke-MegaDlAsJob -MegaDL $MegaDL -DownloadTo $DownloadTo -Url $Url

    Write-Verbose "Downloading: $($job.Id): ${url}"
    $jobs.Add($url, $job.Id) | Out-Null
    [System.Collections.ArrayList]$jobs_remove = @()

    foreach ($j in $jobs.GetEnumerator()) {
        if ((Get-Job -Id $j.Value).State -eq 'Completed') {
            try {
                (Receive-Job -Id $j.Value -ErrorAction Stop) -imatch 'Fatmagul\s(\d+)\.([^:]+)' | Out-Null
            } catch {
                $Error[0].Exception.Message -imatch 'Fatmagul\s(\d+)\.([^\s]+)' | Out-Null
            } finally {
                ConvertTo-PlexNamingConvention -FileName (Resolve-Path "${DownloadTo}\$($Matches[0])" -ErrorAction)
            }

            # Can't remove Keys from the object we're looping through.
            # So ... we'll do it later.
            $jobs_remove.Add($j.Name) | Out-Null
            break
        }
    }

    foreach ($j in $jobs_remove) {
        $jobs.Remove($j) | Out-Null
    }
}