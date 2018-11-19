# Version="1.0.0.0"
# Product="" �@�@�@
# Copyright="Kenji Oshio" 
# Company="Olympus Corp"
#
# �w�肵���t�H���_�Ɏw�肵�����[�U�[�̃A�N�Z�X����t�^���܂��B�A�N�Z�X���͌���Full Contorl�ł����ύX�͉\�ł��B
# �{Script��ISID�F�؂��Ă���NotesPC�Ȃǂł̂ݎ��s�\�ł��B�J���pPC�Ȃ�ISID�Ń��O�C�����Ă��Ȃ�PC�Ŏ��s����Ɛ��������삵�܂���B
#
#

# �A�N�Z�X����t�^����Folder�̋N�_�ƂȂ�e�t�H���_�܂ł̃t���p�X
$base_dir = "Your directory path"
#$base_dir = "C:\temp"�@:�@e.g. C:\temp�̉��ɑ��݂���t�H���_�ɃA�N�Z�X����^�������ꍇ�̃p�X�̋L�q��

# �A�N�Z�X�������ۂɗ^�������t�H���_�F$base_dir�̉��ɑ��݂���K�v������
$targetFolder = "Your folder"
#$targetFolder = "test"�@e.g. C:temp\test�����݂��A"test"�t�H���_�ɃA�N�Z�X����ݒ肷��ꍇ

$folder_path = $base_dir | join-path -child  $targetFolder

#�A�N�Z�X����t�^���郆�[�U�[�̃A�J�E���g���
# Oly���ł͊�{IS�h���C���̂�
$myDomain = "Your domain"
#�A�N�Z�X����t�^���������[�U�[��ISID
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
# �����F���[�U�[��,�A�N�Z�X��,���ʃt�H���_�֌p��,���ʃI�u�W�F�N�g�֌p��,�p���̐���,�A�N�Z�X����
$accessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule $permission

$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder_path 