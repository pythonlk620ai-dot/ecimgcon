# PowerShell script to generate localized pages - Final fixed version
$baseDir = "c:\Users\thoma\Downloads\program\iloveimage-master"

# Define files to process
$files = @(
    @{Name="png-to-jpg.html"; TitleEN="PNG to JPG Converter"; TitleTW="PNG 轉 JPG 轉換器"}
    @{Name="webp-to-png.html"; TitleEN="WebP to PNG Converter"; TitleTW="WebP 轉 PNG 轉換器"}
    @{Name="webp-to-jpg.html"; TitleEN="WebP to JPG Converter"; TitleTW="WebP 轉 JPG 轉換器"}
    @{Name="bmp-to-png.html"; TitleEN="BMP to PNG Converter"; TitleTW="BMP 轉 PNG 轉換器"}
    @{Name="bmp-to-jpg.html"; TitleEN="BMP to JPG Converter"; TitleTW="BMP 轉 JPG 轉換器"}
    @{Name="svg-to-png.html"; TitleEN="SVG to PNG Converter"; TitleTW="SVG 轉 PNG 轉換器"}
    @{Name="svg-to-jpg.html"; TitleEN="SVG to JPG Converter"; TitleTW="SVG 轉 JPG 轉換器"}
    @{Name="pdf-to-jpg.html"; TitleEN="PDF to JPG Converter"; TitleTW="PDF 轉 JPG 轉換器"}
    @{Name="updates.html"; TitleEN="Updates - Easy Img Converter"; TitleTW="更新 - Easy Img Converter"}
)

foreach ($file in $files) {
    $originalFile = Join-Path $baseDir $file.Name
    $enFile = Join-Path $baseDir "en\$($file.Name)"
    $zhTwFile = Join-Path $baseDir "zh-tw\$($file.Name)"
    
    if (Test-Path $originalFile) {
        Write-Host "Processing $($file.Name)..."
        
        # Read original content
        $content = Get-Content $originalFile -Raw -Encoding UTF8
        
        # Create English version
        $enContent = $content
        
        # Update URLs from root to /en/ subdirectory (only if not already in en/ or zh-tw/)
        $enContent = $enContent -replace 'href="http://easyimgconverter\.com/([^"/]+\.html)"', 'href="http://easyimgconverter.com/en/$1"'
        $enContent = $enContent -replace 'og:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', 'og:url" content="http://easyimgconverter.com/en/$1"'
        $enContent = $enContent -replace 'twitter:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', 'twitter:url" content="http://easyimgconverter.com/en/$1"'
        
        # Fix canonical URL (ensure it has href= and /en/)
        $enContent = $enContent -replace '<link rel="canonical" href="http://easyimgconverter\.com/([^"/]+\.html)">', '<link rel="canonical" href="http://easyimgconverter.com/en/$1">'
        $enContent = $enContent -replace '<link rel="canonical" http://easyimgconverter\.com/([^"/]+\.html)">', '<link rel="canonical" href="http://easyimgconverter.com/en/$1">'
        
        # Add hreflang links after canonical - use a different approach
        $canonicalPattern = '<link rel="canonical" href="http://easyimgconverter\.com/en/[^"]+">'
        if ($enContent -match $canonicalPattern) {
            $canonicalMatch = [regex]::Match($enContent, $canonicalPattern)
            $canonicalLine = $canonicalMatch.Value
            $hreflangLine = '    <link rel="alternate" hreflang="zh-TW" href="http://easyimgconverter.com/zh-tw/' + $file.Name + '">'
            $enContent = $enContent -replace [regex]::Escape($canonicalLine), ($canonicalLine + "`r`n" + $hreflangLine)
        }
        
        # Save English version
        $enContent | Out-File -FilePath $enFile -Encoding UTF8 -NoNewline
        Write-Host "  Created: $enFile"
        
        # Create Traditional Chinese version
        $zhTwContent = $content
        
        # Fix lang attribute
        $zhTwContent = $zhTwContent -replace '<html lang="en">', '<html lang="zh-TW">'
        
        # Update URLs from root to /zh-tw/ subdirectory (only if not already in en/ or zh-tw/)
        $zhTwContent = $zhTwContent -replace 'href="http://easyimgconverter\.com/([^"/]+\.html)"', 'href="http://easyimgconverter.com/zh-tw/$1"'
        $zhTwContent = $zhTwContent -replace 'og:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', 'og:url" content="http://easyimgconverter.com/zh-tw/$1"'
        $zhTwContent = $zhTwContent -replace 'twitter:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', 'twitter:url" content="http://easyimgconverter.com/zh-tw/$1"'
        
        # Fix canonical URL (ensure it has href= and /zh-tw/)
        $zhTwContent = $zhTwContent -replace '<link rel="canonical" href="http://easyimgconverter\.com/([^"/]+\.html)">', '<link rel="canonical" href="http://easyimgconverter.com/zh-tw/$1">'
        $zhTwContent = $zhTwContent -replace '<link rel="canonical" http://easyimgconverter\.com/([^"/]+\.html)">', '<link rel="canonical" href="http://easyimgconverter.com/zh-tw/$1">'
        
        # Add hreflang links after canonical - use a different approach
        $canonicalPattern = '<link rel="canonical" href="http://easyimgconverter\.com/zh-tw/[^"]+">'
        if ($zhTwContent -match $canonicalPattern) {
            $canonicalMatch = [regex]::Match($zhTwContent, $canonicalPattern)
            $canonicalLine = $canonicalMatch.Value
            $hreflangLine = '    <link rel="alternate" hreflang="en" href="http://easyimgconverter.com/en/' + $file.Name + '">'
            $zhTwContent = $zhTwContent -replace [regex]::Escape($canonicalLine), ($canonicalLine + "`r`n" + $hreflangLine)
        }
        
        # Update title for Chinese version
        $zhTwContent = $zhTwContent -replace '<title>[^<]+</title>', "<title>$($file.TitleTW) - Easy Img Converter</title>"
        
        # Save Chinese version
        $zhTwContent | Out-File -FilePath $zhTwFile -Encoding UTF8 -NoNewline
        Write-Host "  Created: $zhTwFile"
    } else {
        Write-Host "  Warning: $originalFile not found"
    }
}

Write-Host "`nDone! All localized pages created."
