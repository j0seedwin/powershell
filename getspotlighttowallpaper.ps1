$ErrorActionPreference= 'silentlycontinue'
#$mypath = $MyInvocation.MyCommand.Path
#Write-Output "Path of the script : $mypath"
#Split-Path $mypath -Parent
$assets = "C:\Users\$Env:USERNAME\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*"
##$assets = "C:\Users\$Env:USERNAME\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*"
write-host $assets

$dest = "c:\temp\jpg assets\"
$dest1 = "c:\temp\jpg assets\*"
$spotlight1 = "C:\Users\$Env:USERNAME\Pictures\Spotlight\Wallpaper\*"
$spotlight = "C:\Users\$Env:USERNAME\Pictures\Spotlight\Wallpaper\"
$spotlightbackup = "C:\Users\$Env:USERNAME\Pictures\Spotlight\Backup\"
# Get the date
$DateStamp = get-date -uformat "%m%d%Y"
$uscore = "_"


if (!(Test-Path $dest -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $dest
}

if (!(Test-Path $spotlightbackup -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $spotlightbackup
}

Copy-Item $spotlight1 $spotlightbackup
#Start-Sleep -m 3000
#Remove-Item $spotlight1 -Recurse
Start-Sleep -m 3000
Remove-Item $dest1 -Recurse
Start-Sleep -m 3000
Copy-Item $assets $dest
Start-Sleep -m 3000
ii $dest
ii $spotlight
ii $spotlightbackup
Get-ChildItem -Path $dest1 | %{$x=1} {Rename-Item $_ -NewName "$x.jpg"; $x++ }
#C:\Users\$Env:USERNAME\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets
$image = New-Object -ComObject Wia.ImageFile

$pictures = Get-ChildItem $dest1 | ForEach-Object {
$image.LoadFile($_)
    
    $dimensions = "$($image.Width) x $($image.Height)"

    If ($dimensions -eq "1920 x 1080") { } else {
        Remove-Item $_.fullname
    }
    
}


Get-ChildItem -Path $dest1 | %{$x=1} {Rename-Item $_ -NewName "$DateStamp$uscore$x.jpg"; $x++ }
Start-Sleep -m 2000
Copy-Item $dest1 $spotlight
Start-Sleep -m 2000
Remove-Item $dest1 -Recurse
