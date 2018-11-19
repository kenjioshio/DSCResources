# Version="1.0.0.0"
# Product="" �@�@�@
# Copyright="Kenji Oshio" 
# Company="Olympus Corp"
#
# �w�肵���t�H���_��ACL���擾���\������B
# Option�Ƃ���CSV�ɏo�͉\

# �A�N�Z�X����t�^����Folder�̋N�_�ƂȂ�e�t�H���_�܂ł̃t���p�X
$base_dir = "Your directory path"
#$base_dir = "C:\temp"�@:�@e.g. C:\temp�̉��ɑ��݂���t�H���_�ɃA�N�Z�X����^�������ꍇ�̃p�X�̋L�q��

# �A�N�Z�X�������ۂɗ^�������t�H���_�F$base_dir�̉��ɑ��݂���K�v������
$targetFolder = "Your folder"
#$targetFolder = "test"�@e.g. C:temp\test�����݂��A"test"�t�H���_�ɃA�N�Z�X����ݒ肷��ꍇ

$folder_path = $base_dir | join-path -child  $targetFolder

#Write-Host $folder_path

$aCLobj = Get-Acl "$folder_path" | Select-object @{Label="Path";Expression={Convert-Path $_.Path}}, Owner, AccessToString 

#Write-Host $aCLobj.AccessToString

#ACL��CSV�ɏ���̃t�H���_�ɏo��

$outfilenname = "CurrentACL_" +$targetFolder

Export-Csv -InputObject $aCLobj -Path  C:\temp\$outfilenname.csv
