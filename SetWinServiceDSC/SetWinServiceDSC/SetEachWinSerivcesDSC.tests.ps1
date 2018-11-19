# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company=""

# Test after dsc configuration is done.
# This test can check whether the configuration of each service are correct or not.

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'. "$here\$sut"

#取得したいRegistry情報のベースとなるパスを設定：テスト対象によってことは異なる
$regKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services"
$RegKeyObj = Get-ChildItem -Path $regKeyPath
$wService = $null

#DSC Configuration Dataに基づいて構成された結果をテストするためあるべき姿もConfiguration Dataから取得する
$configData = Import-PowerShellDataFile -Path .\SetWinServiceDSC\ConfigurationData.psd1
# Solemio QUEVで動いているServiceのテストのため該当データ部分のみConfiguration Dataから配列オブジェクトとして格納する
$ServiceObj = $configData.AllNodes.SolemioQuevServerServices

Describe ":Check whether all Service are exisit or not." {
#Note: Windows Serviceのプロパティーの取得にはRegistry情報とGet-Service Command-letによる情報の両方必要なためCodeがやや冗長
    foreach($wService in $ServiceObj)
    {
	    #Serviceそのものの存在の確認のため期待値の初期値
		$result = $false
		
		# 該当Serviceの3つのプロパティーをチェックするので配列も要素は3つ。ServiceそのもののCaseと分けるため期待値もわける。：チェック対象を増やす場合はこちらも増やす。
		# ConfiurationDataの要素数を数えて配列を作るようにしたほうがよいけど今はこの状態。ヒア文字列連結はCodeが複雑になるので作るとしたらFunction化してモジュール配信しないとダメぽ
		$resultHash =@( $false, $false, $false)
		
		$DS_Name = $wService.Name
		$DS_State = $wService.State
        $DS_StartupType = $wService.StartupType
        $DS_Path = $wService.Path
            
        #該当Service名が存在していたら、Test続行し、プロパティーの確認をするTest実行       
		try
		{
			# コマンドレッドの例外はC#の通常のCodeのように拾えない。ErrorActionオプションの使用が必要    
			# Get-Service コマンドレッドで該当サービスの存在を確認する
			$result = $true

			Get-Service -Name $DS_Name -ErrorAction Stop

	        # Get each Service properities if it is exist.		
   		    foreach($rKey in $RegKeyObj)
		    {
			    if($rKey.PSChildName -eq $wService.Name)
				{
					#サービスの情報のうちサービスの状態をCommand-letで取得する
					$CurrentServieObj = Get-Service -Name $DS_Name
					$CurrentState = $CurrentServieObj.Status
					
					#サービスのプロパティー情報をレジストリから取得
                    $regKeyProperty = $regKeyPath | join-path -child $rKey.PSChildName
					$CurrentStartupTypeNum = (Get-Item -Path "$regKeyProperty").GetValue("Start")
                    $CurrentPath = (Get-Item -Path "$regKeyProperty").GetValue("ImagePath")

                    #Write-Host $CurrentStartupTypeNum
					Switch($CurrentStartupTypeNum)
					{
							# The registry key of StartType is not stored as a string, but a number.  
							"2"
							{
								# DelayedAutoStart key =1 If the service Start Type "Automatic(delay)", then there is no key in Regsitry.
								# We have to check this key to distingush Automatic and Automatic(delay).
								$CurrentStartupType = "Automatic"
							}
							"3"
							{
								$CurrentStartupType = "Manual"
							}
							"4"
							{
								$CurrentStartupType = "Disable"
							}
                       
                        }

                    $resultHash = @($CurrentState, $CurrentStartupType, $CurrentPath)
		         }
            }
		}
		Catch
		{
    	    #該当Serviceが存在していない場合、ResultにFalseを入れてSerice存在確認TestCaseをFailさせる
			#Test実行自体はFinnaly句で実施
			#該当Service自体が存在していないので、ServiceのPropertyのチェックをするTestCaseもFailする
            $result = $false
  
		}
		finally
		{
			Context ": Check whether the desired Service Instance exist or not."{
	            It "'$DS_Name' should be exist as a Windows Service in this PC."{
			        $result | Should be $true
		        }
            }
			Context ":Check whether the Service properities are desired or not." {
				It "The property of '$DS_Name' service should be '$DS_State' and '$DS_StartupType', '$DS_Path' ."{
                    $resultHash | Should be @( $DS_State, $DS_StartupType, $DS_Path )
                }
			}
        }
	}
}
