Download Fatmagul (Spanish) from Mega. I didn't share them. I just found them here: http://fatmagulnovelaturca.blogspot.com/

# Description

I've saved all the mega_urls in case the site changes. I can just switch to that. 
I browse the site, to travers all his 'adf.ly' links though so the sharer might get the ad-credit he desires.

# Parameters
 ## MegaDL

The path to the `megadl.exe`. Must be a [PathInfo] Object; see examples.

## DownloadTo

The path to download to. Must be a [PathInfo] Object; see examples.

## UsePreSavedMegaUrls

If this switch is set, the previously acquired Mega URLS will be used.

Otherwise, the blog will be parsed and will look at all the 'adf.ly' links to get the Mega URLs. This might help the OP get ad credit ... /shrug

# Example

```powershell
$MegaDL = (Resolve-Path "..\megatools-1.9.97-win64\megadl.exe")
$DownloadTo = (Resolve-Path "..\Fatmagul")
\fatmagul.ps1 -MegaDL $MegaDL -DownloadTo $DownloadTo -Verbose
```

# Notes

You will need MegaTools (https://megatools.megous.com).

# Link

http://fatmagulnovelaturca.blogspot.com/