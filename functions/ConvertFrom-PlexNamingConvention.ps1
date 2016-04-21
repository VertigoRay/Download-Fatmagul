function ConvertTo-PlexNamingConvention () {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$True,
            ValueFromPipeline=$True,
            ValueFromPipelinebyPropertyName=$True
        )]
        [System.Management.Automation.PathInfo]
        $FileName
    )

    BEGIN {
        Write-Verbose "Converting From: Plex Naming Convention"
    }

    PROCESS {
        foreach ($File in $FileName) {
            $child = Split-Path $File -Child
            $ext = $child.Split('.')[-1]
            $title = $child.Split('.')[0..($child.Split('.').Count-2)] -Join ' '

            [System.Collections.ArrayList]$title_pieces = @()
            foreach ($t in $title.Split(' .')) {
                try {
                    [int]$episode = $t
                } catch [System.Management.Automation.RuntimeException] {
                    $title_piece = (Get-Culture).TextInfo.ToTitleCase($t)
                }

                if ($episode) {
                    $title_pieces.Add(('e{0:d3}' -f $episode))
                } else {
                    $title_pieces.Add($title_piece)
                }
            }

            $rename_to = '{0}.{1}' -f @(($title_pieces -join '.'), $ext)
            Write-Verbose "$($File.Name) > ${rename_to}"
            Rename-Item $File.FullName $rename_to -ErrorAction Ignore
        }
    }

    END {}
}