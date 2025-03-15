$DEV_HOME = "C:\devTest"
mkdir $DEV_HOME -Force

$scoop_info = Get-Command "scoop" -ErrorAction SilentlyContinue
if ($scoop_info -eq $null) 
{ 
	$newScoopHome = Join-Path -Path $DEV_HOME -ChildPath ".scoop"
	Write-Host "Unable to find scoop in your PATH. Installing at $($newScoopHome)"
	[System.Environment]::SetEnvironmentVariable("SCOOP", $newScoopHome, "User")
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
	
	scoop config use_sqlite_cache true
	scoop config aria2-enabled true
	scoop config aria2-warning-enabled false
}
else
{
	Write-Host "Using existing scoop install at $($scoop_info.source)"
}



scoop bucket add extras
scoop bucket add versions

foreach($app in Get-Content $PSScriptRoot\scoop-apps.txt)
{
	if ($app -and !$app.StartsWith("//"))
	{
		scoop install $app
		scoop update $app
	}
}

#cleanup
#scoop uninstall vcredist2022

cd $DEV_HOME
git clone https://github.com/BKCF/env-scripts.git
cd env-scripts
git pull

#https://alacritty.org/config-alacritty.html
$alacritty_config_dir = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Roaming\alacritty"
mkdir $alacritty_config_dir -Force
cp ./alacritty.toml $alacritty_config_dir

#https://github.com/fastfetch-cli/fastfetch/wiki/Configuration
$fastfetch_config_dir = Join-Path -Path $env:USERPROFILE -ChildPath ".config/fastfetch"
mkdir $fastfetch_config_dir -Force
cp ./fastfetch.jsonc $fastfetch_config_dir/config.jsonc





# TODO clone and copy dotenvs

# TODO install wsl

# stuff that I could add but would be a PITA:
# discord, spotify, steam, chrome, visual studio 22
#
#
