# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company="Olympus Corp"
#
# 指定したフォルダのACLを取得し表示する。
# OptionとしてCSVに出力可能

# アクセス権を付与するFolderの起点となる親フォルダまでのフルパス
$base_dir = "Your directory path"
#$base_dir = "C:\temp"　:　e.g. C:\tempの下に存在するフォルダにアクセス権を与えたい場合のパスの記述例

# アクセス権を実際に与えたいフォルダ：$base_dirの下に存在する必要がある
$targetFolder = "Your folder"
#$targetFolder = "test"　e.g. C:temp\testが存在し、"test"フォルダにアクセス権を設定する場合

$folder_path = $base_dir | join-path -child  $targetFolder

#Write-Host $folder_path

$aCLobj = Get-Acl "$folder_path" | Select-object @{Label="Path";Expression={Convert-Path $_.Path}}, Owner, AccessToString 

#Write-Host $aCLobj.AccessToString

#ACLをCSVに所定のフォルダに出力

$outfilenname = "CurrentACL_" +$targetFolder

Export-Csv -InputObject $aCLobj -Path  C:\temp\$outfilenname.csv
