# SABINA Flutter Clean Script
# Properly cleans the project by removing file locks and rebuilding cache

Write-Host "🧹 SABINA Project Clean & Reset" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Step 1: Stop all dart and analysis processes
Write-Host "`n[1/5] Stopping Dart analysis processes..." -ForegroundColor Yellow
Stop-Process -Name "dart" -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
Stop-Process -Name "dartvm" -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
Start-Sleep -Milliseconds 1000

# Step 2: Delete .dart_tool (source of the lock issue)
Write-Host "[2/5] Removing .dart_tool directory..." -ForegroundColor Yellow
if (Test-Path ".dart_tool" -PathType Container) {
    Remove-Item ".dart_tool" -Recurse -Force -ErrorAction SilentlyContinue
    if (-not (Test-Path ".dart_tool" -PathType Container)) {
        Write-Host "     ✓ .dart_tool removed successfully" -ForegroundColor Green
    } else {
        Write-Host "     ✗ Failed to remove .dart_tool (file may still be locked)" -ForegroundColor Red
    }
} else {
    Write-Host "     ✓ .dart_tool not present" -ForegroundColor Green
}

# Step 3: Delete build directory
Write-Host "[3/5] Removing build directory..." -ForegroundColor Yellow
if (Test-Path "build" -PathType Container) {
    Remove-Item "build" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "     ✓ build folder removed" -ForegroundColor Green
} else {
    Write-Host "     ✓ build folder not present" -ForegroundColor Green
}

# Step 4: Clear pubspec locks
Write-Host "[4/5] Removing pubspec locks..." -ForegroundColor Yellow
Remove-Item "pubspec.lock" -Force -ErrorAction SilentlyContinue
Remove-Item ".packages" -Force -ErrorAction SilentlyContinue
Write-Host "     ✓ Pubspec locks cleared" -ForegroundColor Green

# Step 5: Reinstall dependencies
Write-Host "[5/5] Running flutter pub get..." -ForegroundColor Yellow
flutter pub get
Write-Host "     ✓ Dependencies reinstalled" -ForegroundColor Green

Write-Host "`n✨ Project clean complete!" -ForegroundColor Cyan
Write-Host "You can now run: flutter run -d emulator-5554" -ForegroundColor Green
