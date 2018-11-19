# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company="Olympus Corp"
#
# 指定したフォルダに指定したユーザーのアクセス権を付与します。アクセス権は現状Full Contorlですが変更は可能です。
# 本ScriptはISID認証しているNotesPCなどでのみ実行可能です。開発用PCなどISIDでログインしていないPCで実行すると正しく動作しません。
#
#

# アクセス権を付与するFolderの起点となる親フォルダまでのフルパス
$base_dir = "Your directory path"
#$base_dir = "C:\temp"　:　e.g. C:\tempの下に存在するフォルダにアクセス権を与えたい場合のパスの記述例

# アクセス権を実際に与えたいフォルダ：$base_dirの下に存在する必要がある
$targetFolder = "Your folder"
#$targetFolder = "test"　e.g. C:temp\testが存在し、"test"フォルダにアクセス権を設定する場合

$folder_path = $base_dir | join-path -child  $targetFolder

#アクセス権を付与するユーザーのアカウント情報
# Oly内では基本ISドメインのみ
$myDomain = "Your domain"
#アクセス権を付与したいユーザーのISID
$user_name ="Your windows user ID"
#$User_name = "Everyone"

$fc_user_name = $myDomain + "\" + $user_name
#$fc_user_name = $user_name
#Write-Host $fc_user_name

$acl = Get-ACL $folder_path 

#Write-Host $acl

$permission = ($fc_user_name,"FullControl","ContainerInherit, ObjectInherit", "None","Allow")
<#
$permission = ($userGroup,
                [System.Security.AccessControl.FileSystemRights]::FullControl,
                [System.Security.AccessControl.InheritanceFlags]::ContainerInherit,
				[System.Security.AccessControl.PropagationFlags]::None,
                [System.Security.AccessControl.AccessControlType]::Allow)

#>
# 引数：ユーザー名,アクセス権,下位フォルダへ継承,下位オブジェクトへ継承,継承の制限,アクセス許可
$accessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule $permission

$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder_path 