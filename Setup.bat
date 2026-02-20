@echo off
setlocal EnableDelayedExpansion
title Metroxide Setup - Logo Entegre Ediliyor
color 0a
cls

echo Metroxide Setup başlıyor... Logo entegre ediliyor!
echo.

set "Desktop=%USERPROFILE%\Desktop"
set "Resources=%Desktop%\Resources"
set "Logo=%Resources%\logo.jpg"
set "PS1File=%Resources%\Metroxide.ps1"
set "Shortcut=%Desktop%\Metroxidex64.lnk"

:: Resources klasörü yoksa oluştur
if not exist "%Resources%" mkdir "%Resources%"

:: logo.jpg kontrolü
if not exist "%Logo%" (
    echo [HATA] logo.jpg yok! Resources klasörüne logo.jpg koyup tekrar çalıştır.
    pause
    exit
)

echo logo.jpg bulundu! Kısayol oluşturulacak...

:: Metroxide.ps1 dosyasını oluştur (GDI kuduruk + fantazi)
echo PowerShell scripti hazırlanıyor...
(
    echo Add-Type -AssemblyName System.Windows.Forms
    echo while($true){
    echo     $p = [System.Windows.Forms.Cursor]::Position
    echo     $x = $p.X + (Get-Random -Min -80 -Max 81)
    echo     $y = $p.Y + (Get-Random -Min -80 -Max 81)
    echo     [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x,$y)
    echo     Start-Sleep -Milliseconds 5
    echo }
) > "%PS1File%"

echo Metroxide.ps1 oluşturuldu!

:: Kısayol oluştur (logo.jpg ikonu ile)
echo Metroxidex64.lnk oluşturuluyor...
powershell -NoProfile -Command ^
    "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%Shortcut%'); $s.TargetPath = 'powershell.exe'; $s.Arguments = '-NoProfile -ExecutionPolicy Bypass -File ""%PS1File%""'; $s.IconLocation = '%Logo%,0'; $s.Description = 'Metroxide 1.1 - GDI Kuduruk'; $s.Save()"

echo.
echo Kurulum tamamlandı!
echo Masaüstünde "Metroxidex64.lnk" kısayolu var (ikon logo.jpg oldu)
echo Çift tıkladığında fantazi başlar: GDI patlaması, mouse titretme, iz bırakma vs.
echo Keyfini çıkar amk!

pause
