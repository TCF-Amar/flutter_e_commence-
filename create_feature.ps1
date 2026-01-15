#* Note: Run this script in the root directory of your Flutter project
#? ./create_feature.ps1 <feature_name>

param (
  [string]$feature
)

$base = "lib/features/$feature"

New-Item -ItemType Directory -Force "$base/models"
New-Item -ItemType Directory -Force "$base/repositories"
New-Item -ItemType Directory -Force "$base/controllers"
New-Item -ItemType Directory -Force "$base/screens"
New-Item -ItemType Directory -Force "$base/widgets"

New-Item -ItemType File -Force "$base/screens/${feature}_screen.dart"
New-Item -ItemType File -Force "$base/controllers/${feature}_controller.dart"

Write-Host "✅ Feature '$feature' created successfully"
