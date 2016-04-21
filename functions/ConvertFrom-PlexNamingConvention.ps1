function ConvertFrom-PlexNamingConvention () {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$True,
            ValueFromPipeline=$True,
            ValueFromPipelinebyPropertyName=$True
        )]
        $FileName
    )

    BEGIN {
        Write-Verbose "Converting From: Plex Naming Convention"
    }

    PROCESS {
        # since I know what the filenames where, I'm not going to do anything magical.

        foreach ($File in $FileName) {
            $rename_to = $File.Name.Replace('.e', ' ')
            Write-Verbose "Renaming: $($File.Name) > ${rename_to}"
            Rename-Item $File.FullName $rename_to -ErrorAction Ignore
        }
    }

    END {}
}