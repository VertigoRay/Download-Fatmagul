function ConvertTo-PlexNamingConvention () {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        $FileName
    )

    BEGIN {
        Write-Verbose "Converting To: Plex Naming Convention"
    }

    PROCESS {
        foreach ($File in $FileName) {
            $Leaf = Split-Path $File -Leaf
            $ext = $Leaf.Split('.')[-1]
            $title = $Leaf.Split('.')[0..($Leaf.Split('.').Count-2)] -Join ' '

            [System.Collections.ArrayList]$title_pieces = @()

            foreach ($t in $title.Split(' .')) {
                $episode = $null

                try {
                    [int]$episode = $t
                } catch [System.Management.Automation.RuntimeException] {
                    if ($t -match 'e\d{1,3}') {
                        [int]$episode = $t.Substring(1)
                    } else {
                        $title_piece = (Get-Culture).TextInfo.ToTitleCase($t)
                    }
                }

                if ($episode) {
                    $title_pieces.Add(('e{0:d3}' -f $episode)) | Out-Null
                } else {
                    $title_pieces.Add($title_piece) | Out-Null
                }
            }


            $rename_to = '{0}.{1}' -f @(($title_pieces -join '.'), $ext)
            Write-Verbose "$($Leaf) > ${rename_to}"
            Rename-Item $File $rename_to
        }
    }

    END {}
}