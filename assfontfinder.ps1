$path = $args[0]
$files = Get-ChildItem -LiteralPath $path -Filter *.ass -Recurse | %{$_.FullName}
$fonts = @{}

foreach ($file in $files)
{
    $tmpass = Get-Content -LiteralPath $file
    foreach ($LINE in $tmpass)
    {
        if ($LINE -match '(?<=fn)(.*?)(?=[`~!@#$%^&*()_|+\-=?;:,.<>\{\}\[\]\\\/])')
        {
            $tmp = $Matches[1] -creplace '[a-zA-Z]', ''
            $fonts[$tmp] = 0
        }
        if ($LINE -match '(?<=fn@)(.*?)(?=[`~!@#$%^&*()_|+\-=?;:,.<>\{\}\[\]\\\/])')
        {
            $tmp = $Matches[1] -creplace '[a-zA-Z]', ''
            $fonts[$tmp] = 0
        }
        if ($LINE -match '(?<=Style:)(.*?)(?=[0-9])')
        {
            $tmp = $LINE -match '(?<=,)(.*?)(?=,)'
            $tmp = $Matches[1] -creplace '[a-zA-Z]', ''
            $fonts[$tmp] = 0
            
        }
    }
}

$fonts = $fonts.keys | sort 
Write-OutPut $fonts
