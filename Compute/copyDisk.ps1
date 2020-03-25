param([string]$source, [string]$dest)

$what = @("*.*", "/COPYALL")
$options = @( "/j", "/e", "/sec", "/Xd", "System Volume Information", "$RECYCLE.BIN", "/Xo")

$cmdArgs = @("$source","$dest",$what,$options)
robocopy @cmdArgs