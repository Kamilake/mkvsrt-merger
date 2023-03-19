$path = $args[0]
$files = dir $args[0] -recurse | where {$_.extension -in ".ass",".smi",".srt"} | %{$_.FullName}
$fonts = New-Object -TypeName 'System.Collections.ArrayList';

foreach ($file in $files)
{
    $tmpass = Get-Content -LiteralPath $file
    foreach ($LINE in $tmpass)
    {
        if ($LINE -match '(?<=fn[@]?)(.*?)(?=[`~!@#$%^&*()_|+\-=?;:,.<>\{\}\[\]\\\/])')
        {
            $fonts.Add(($Matches[1] -creplace '[a-zA-Z]', '')) | Out-Null
        }
        if ($LINE -match '(?<=Style:)(.*?)(?=[0-9])' -AND $LINE -match '(?<=,)(.*?)(?=,)')
        {
            $fonts.Add(($Matches[1] -creplace '[a-zA-Z]', '')) | Out-Null
        }
        if ($LINE -match '<font face="(.+?)"')
        {
            $fonts.Add(($Matches[1] -creplace '[a-zA-Z]', '')) | Out-Null
        }
    }
}

$fonts = $fonts | Sort-Object | Get-Unique
Write-OutPut $fonts
