# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company=""

## ****Attention!!****##
# 'Service'リソースと'ServiceSet'リソースは違うので注意すること。
# 'Service'リソースはSericeの存在とその際の状態を担保するリソース。ServiceのStartとStopのコントロールは'ServiceSet'リソースで担保される
# 'Service'リソースでのStateプロパティーはStartupTypeプロパティーに依存する。
# e.g. 以下のConfigurawtionではMOFは作成できるがMOF適応時エラー発生する。
#	
#	StartupType = "Automatic"の場合、State = "Stopped"は矛盾するため適応できない。
#	同様に	
#	StartupType = "Disabled"の場合、State = "Running"は矛盾するため適応できない。
#　 また以下の場合、MOFは適用できるが、手動でStatusを変更した場合、再度MOFの適用実行できないため(Serviceリソースの仕様？)、
#	この場合StateなどServiceのプロパティーの変更は、[ServiceSet]リソースを使用して変更させる手順となる。
#	StartupType = "Manual"の場合、State = "Running"でStateをGUIからStoppedにした場合、MOFの適用(Start-Configuration)でError発生し適用できない。
#	Serviceの登録とServiceの状態の変更は別リソースで実施する必要がある。

Configuration SetWinServiceDSC
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
		foreach ($wService in ($AllNodes. SolemioQuevServerServices)) 
        {
			Service $wService.Name
			{
				Ensure      = $wService.Ensure
				Name        = $wService.Name
				DisplayName = $wService.DisplayName
				Path        = $wService.Path
				StartupType = $wService.StartupType
				State       = $wService.State
	        }
		}
    }
}

SetWinServiceDSC　-OutputPath .\MOF -ConfigurationData .\SetWinServiceDSC\ConfigurationData.psd1