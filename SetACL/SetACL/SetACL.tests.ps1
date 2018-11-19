# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company="Olympus Corp"
# 指定したフォルダに指定したアクセス権が正しいかテストするコード
# SetACLもしくは、SetACL_DSCを実行した後こちらを使ってTestする
#
# そのうちConfiuration Dataのようにパラメーターとしてテストデータを渡すように変更。今はハードコーディング。

#$here = Split-Path -Parent $MyInvocation.MyCommand.Path
#$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'. "$here\$sut"

$base_dir = "Your directory path"
#$base_dir = "C:\temp"
$targetFolder = "Your folder"
#$targetFolder = "test"

$folder_path = $base_dir | join-path -child  $targetFolder

$targetUser = "Your windows user ID"
$CurrentDomain = "Your domain"

Describe ":Checking whether Access Control of a folder is correct or not."{
	Context " :Check whether '$targetFolder' has correct access right or not. "{
	
		$aCLobj = $null
		$result = $null
        $resultHash = @( $false ,$false )
        $DesiredResultHash = @( $true ,$true )
        
		It "'$targetUser' should allow 'FullControl' to folder '$targetFolder'." {
			$aCLobj = Get-Acl "$folder_path" | Select-object @{Label="Path";Expression={Convert-Path $_.Path}}, Owner, AccessToString 
			$newObj = $aCLobj.AccessToString 
			$newObj = $newObj -replace "`r",""
			$newObj = $newObj -split "`n" 
            			
			foreach($obj in $newobj)
			{
				#Write-Host $obj
                
                if(( $obj.Contains("$targetUser") -eq $true) ) 
                {
                    $resultHash = @($true ,$false)
                     
                    if(($obj.Contains("Allow  FullControl")) -eq $true )
                    {                
                        #$result = $true
                        $resultHash = @($true ,$true)
                    }    
                }
                
                $resultHash | Should -be $DesiredResultHash	
            }
        }
	}
}