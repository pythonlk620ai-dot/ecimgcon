#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re

base_dir = r'c:\Users\thoma\Downloads\program\iloveimage-master'

# Define files to process with their titles
files = [
    ('png-to-jpg.html', 'PNG 轉 JPG 轉換器', 'PNG to JPG Converter'),
    ('webp-to-png.html', 'WebP 轉 PNG 轉換器', 'WebP to PNG Converter'),
    ('webp-to-jpg.html', 'WebP 轉 JPG 轉換器', 'WebP to JPG Converter'),
    ('bmp-to-png.html', 'BMP 轉 PNG 轉換器', 'BMP to PNG Converter'),
    ('bmp-to-jpg.html', 'BMP 轉 JPG 轉換器', 'BMP to JPG Converter'),
    ('svg-to-png.html', 'SVG 轉 PNG 轉換器', 'SVG to PNG Converter'),
    ('svg-to-jpg.html', 'SVG 轉 JPG 轉換器', 'SVG to JPG Converter'),
    ('pdf-to-jpg.html', 'PDF 轉 JPG 轉換器', 'PDF to JPG Converter'),
    ('updates.html', '更新 - Easy Img Converter', 'Updates - Easy Img Converter'),
]

for filename, title_tw, title_en in files:
    original_file = os.path.join(base_dir, filename)
    en_file = os.path.join(base_dir, 'en', filename)
    zh_tw_file = os.path.join(base_dir, 'zh-tw', filename)
    
    if os.path.exists(original_file):
        print(f"Processing {filename}...")
        
        # Read original content
        with open(original_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Create English version
        en_content = content
        
        # Update URLs from root to /en/ subdirectory
        en_content = re.sub(r'href="http://easyimgconverter\.com/([^"/]+\.html)"', r'href="http://easyimgconverter.com/en/\1"', en_content)
        en_content = re.sub(r'og:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', r'og:url" content="http://easyimgconverter.com/en/\1"', en_content)
        en_content = re.sub(r'twitter:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', r'twitter:url" content="http://easyimgconverter.com/en/\1"', en_content)
        
        # Fix canonical URL
        en_content = re.sub(r'<link rel="canonical" href="http://easyimgconverter\.com/([^"/]+\.html)">', r'<link rel="canonical" href="http://easyimgconverter.com/en/\1">', en_content)
        en_content = re.sub(r'<link rel="canonical" http://easyimgconverter\.com/([^"/]+\.html)">', r'<link rel="canonical" href="http://easyimgconverter.com/en/\1">', en_content)
        
        # Add hreflang links after canonical
        def add_hreflang_en(match):
            canonical = match.group(0)
            return canonical + '\n    <link rel="alternate" hreflang="zh-TW" href="http://easyimgconverter.com/zh-tw/' + filename + '">'
        
        en_content = re.sub(r'<link rel="canonical" href="http://easyimgconverter\.com/en/[^"]+">', add_hreflang_en, en_content)
        
        # Save English version
        with open(en_file, 'w', encoding='utf-8') as f:
            f.write(en_content)
        print(f"  Created: {en_file}")
        
        # Create Traditional Chinese version
        zh_tw_content = content
        
        # Fix lang attribute
        zh_tw_content = re.sub(r'<html lang="en">', '<html lang="zh-TW">', zh_tw_content)
        
        # Update URLs from root to /zh-tw/ subdirectory
        zh_tw_content = re.sub(r'href="http://easyimgconverter\.com/([^"/]+\.html)"', r'href="http://easyimgconverter.com/zh-tw/\1"', zh_tw_content)
        zh_tw_content = re.sub(r'og:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', r'og:url" content="http://easyimgconverter.com/zh-tw/\1"', zh_tw_content)
        zh_tw_content = re.sub(r'twitter:url" content="http://easyimgconverter\.com/([^"/]+\.html)"', r'twitter:url" content="http://easyimgconverter.com/zh-tw/\1"', zh_tw_content)
        
        # Fix canonical URL
        zh_tw_content = re.sub(r'<link rel="canonical" href="http://easyimgconverter\.com/([^"/]+\.html)">', r'<link rel="canonical" href="http://easyimgconverter.com/zh-tw/\1">', zh_tw_content)
        zh_tw_content = re.sub(r'<link rel="canonical" http://easyimgconverter\.com/([^"/]+\.html)">', r'<link rel="canonical" href="http://easyimgconverter.com/zh-tw/\1">', zh_tw_content)
        
        # Add hreflang links after canonical
        def add_hreflang_tw(match):
            canonical = match.group(0)
            return canonical + '\n    <link rel="alternate" hreflang="en" href="http://easyimgconverter.com/en/' + filename + '">'
        
        zh_tw_content = re.sub(r'<link rel="canonical" href="http://easyimgconverter\.com/zh-tw/[^"]+">', add_hreflang_tw, zh_tw_content)
        
        # Update title for Chinese version
        zh_tw_content = re.sub(r'<title>[^<]+</title>', f'<title>{title_tw} - Easy Img Converter</title>', zh_tw_content)
        
        # Save Chinese version
        with open(zh_tw_file, 'w', encoding='utf-8') as f:
            f.write(zh_tw_content)
        print(f"  Created: {zh_tw_file}")
    else:
        print(f"  Warning: {original_file} not found")

print("\nDone! All localized pages created.")
