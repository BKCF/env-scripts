# refreshenv
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
New-Alias -Name "notepad" -Value "C:\Program Files\Notepad++\notepad++.exe"
oh-my-posh init pwsh --config="C:\Users\Angelo\AppData\Local\Programs\oh-my-posh\themes\emodipt-extend.omp.json" | Invoke-Expression
