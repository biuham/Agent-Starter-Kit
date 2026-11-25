# Shared filesystem guard: inspect ancestors and walk without following links.
function Assert-KitPlainPath([string]$Path, [switch]$Recurse) {
    $cursor = [IO.Path]::GetFullPath($Path)
    while ($cursor) {
        $item = Get-Item -LiteralPath $cursor -Force -ErrorAction SilentlyContinue
        if ($item -and ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw "Linked path is not supported: $cursor"
        }
        $cursor = Split-Path -Parent $cursor
    }
    if ($Recurse -and (Test-Path -LiteralPath $Path -PathType Container)) {
        foreach ($child in Get-ChildItem -LiteralPath $Path -Force) {
            Assert-KitPlainPath $child.FullName -Recurse
        }
    }
}
