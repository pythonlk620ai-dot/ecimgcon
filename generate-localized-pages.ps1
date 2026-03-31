# PowerShell script to generate localized pages for all conversion tools

# Read the original English page
$originalPage = Get-Content -Path "c:\Users\thoma\Downloads\program\iloveimage-master\png-to-jpg.html" -Raw

# Create English version with proper SEO
$enPage = $originalPage -replace 'href="http://easyimgconverter\.com/png-to-jpg\.html"', 'href="http://easyimgconverter.com/en/png-to-jpg.html"'
$enPage = $enPage -replace '<html lang="en">', '<html lang="en">'
$enPage = $enPage -replace '<title>PNG to JPG Converter - Easy Img Converter</title>', '<title>PNG to JPG Converter - Easy Img Converter</title>'
$enPage = $enPage -replace '<link rel="canonical" href="http://easyimgconverter\.com/png-to-jpg\.html">', '<link rel="canonical" href="http://easyimgconverter.com/en/png-to-jpg.html">'
$enPage = $enPage -replace '<meta property="og:url" content="http://easyimgconverter\.com/png-to-jpg\.html">', '<meta property="og:url" content="http://easyimgconverter.com/en/png-to-jpg.html">'
$enPage = $enPage -replace '<meta property="twitter:url" content="http://easyimgconverter\.com/png-to-jpg\.html">', '<meta property="twitter:url" content="http://easyimgconverter.com/en/png-to-jpg.html">'
$enPage = $enPage -replace '<script type="application/ld\+json">', '<link rel="alternate" hreflang="zh-TW" href="http://easyimgconverter.com/zh-tw/png-to-jpg.html"><link rel="alternate" hreflang="en" href="http://easyimgconverter.com/en/png-to-jpg.html"><script type="application/ld+json">'
$enPage | Out-File -FilePath "c:\Users\thoma\Downloads\program\iloveimage-master\en\png-to-jpg.html" -Encoding UTF8

# Create Traditional Chinese version
$zhTwPage = $originalPage -replace 'href="http://easyimgconverter\.com/png-to-jpg\.html"', 'href="http://easyimgconverter.com/zh-tw/png-to-jpg.html"'
$zhTwPage = $zhTwPage -replace '<html lang="en">', '<html lang="zh-TW">'
$zhTwPage = $zhTwPage -replace '<title>PNG to JPG Converter - Easy Img Converter</title>', '<title>PNG 轉 JPG 轉換器 - Easy Img Converter</title>'
$zhTwPage = $zhTwPage -replace '<meta name="description" content="PNG to JPG converter\. Convert PNG images to JPG format with transparency support\. Fast, secure, and no file size limits\. Perfect for image conversion needs\.">', '<meta name="description" content="PNG 轉 JPG 轉換器。將 PNG 圖片轉換為 JPG 格式，支持透明度。快速、安全、無檔案大小限制。完美滿足您的圖片轉換需求。">'
$zhTwPage = $zhTwPage -replace '<meta name="keywords" content="png to jpg converter, online converter, image converter, jpg converter, image tool, photo converter, converter, Easy Img Converter">', '<meta name="keywords" content="png 轉 jpg 轉換器, 在線轉換器, 圖片轉換器, jpg 轉換器, 圖片工具, 照片轉換器, 轉換器, Easy Img Converter">'
$zhTwPage = $zhTwPage -replace '<link rel="canonical" href="http://easyimgconverter\.com/png-to-jpg\.html">', '<link rel="canonical" href="http://easyimgconverter.com/zh-tw/png-to-jpg.html">'
$zhTwPage = $zhTwPage -replace '<meta property="og:title" content="PNG to JPG Converter - Easy Img Converter">', '<meta property="og:title" content="PNG 轉 JPG 轉換器 - Easy Img Converter">'
$zhTwPage = $zhTwPage -replace '<meta property="og:description" content="Convert PNG images to JPG format with transparency support\. Fast, secure, and no file size limits\.">', '<meta property="og:description" content="將 PNG 圖片轉換為 JPG 格式，支持透明度。快速、安全、無檔案大小限制。">'
$zhTwPage = $zhTwPage -replace '<meta property="twitter:title" content="PNG to JPG Converter - Easy Img Converter">', '<meta property="twitter:title" content="PNG 轉 JPG 轉換器 - Easy Img Converter">'
$zhTwPage = $zhTwPage -replace '<meta property="twitter:description" content="Convert PNG images to JPG format with transparency support\. Fast, secure, and no file size limits\.">', '<meta property="twitter:description" content="將 PNG 圖片轉換為 JPG 格式，支持透明度。快速、安全、無檔案大小限制。">'
$zhTwPage = $zhTwPage -replace '<script type="application/ld\+json">', '<link rel="alternate" hreflang="en" href="http://easyimgconverter.com/en/png-to-jpg.html"><link rel="alternate" hreflang="zh-TW" href="http://easyimgconverter.com/zh-tw/png-to-jpg.html"><script type="application/ld+json">'
$zhTwPage = $zhTwPage -replace '"name": "PNG to JPG Converter"', '"name": "PNG 轉 JPG 轉換器"'
$zhTwPage = $zhTwPage -replace '"description": "PNG to JPG converter that converts PNG images to JPG format with transparency support\. Fast, secure, and no file size limits\."', '"description": "PNG 轉 JPG 轉換器，可將 PNG 圖片轉換為 JPG 格式，支持透明度。快速、安全、無檔案大小限制。"'
$zhTwPage = $zhTwPage -replace '"featureList": "Convert PNG to JPG, Batch conversion, Transparency support, Lossless quality, No file size limits, Secure processing"', '"featureList": "PNG 轉 JPG, 批量轉換, 透明度支持, 無損品質, 無檔案大小限制, 安全處理"'
$zhTwPage | Out-File -FilePath "c:\Users\thoma\Downloads\program\iloveimage-master\zh-tw\png-to-jpg.html" -Encoding UTF8

Write-Host "Generated PNG to JPG localized pages"
