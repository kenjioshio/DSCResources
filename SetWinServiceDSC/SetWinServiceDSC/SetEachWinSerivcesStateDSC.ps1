# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company=""

## ****Attention!!****##
# 'Service'リソースと'ServiceSet'リソースは違うので注意すること。
# 本DSC Scriptはすでに存在しているServiceをスタート（"Running"）・ストップ("Stopped")する際に使用する
#
# 'Service'リソースはSericeの存在とその際の状態を担保するリソース。ServiceのStartとStopのコントロールは'ServiceSet'リソースで担保される
# 'Service'リソースでのStateプロパティーはStartupTypeプロパティーに依存する。
# e.g. 以下のConfigurawtionではMOFは作成できるがMOF適応時エラー発生する。
#	
#	StartupType = "Automatic"の場合、State = "Stopped"は矛盾するため適応できない。
#	同様に	
#	StartupType = "Disabled"の場合、State = "Running"は矛盾するため適応できない。
#　 また以下の場合もなぜか実行できないため(Serviceリソースの仕様？)、この場合Stateをを"Stopped"で登録しServiceSetリソースを使用してServiceをStartさせる。
#	StartupType = "Manual"の場合、State = "Running"
#   DepensOnでServiceを作成してから状態の変更を適用した場合もエラーが起きているのでDSC Shell Scriptとして独立させて作っている。


Configuration SetWinServiceStateDSC
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
		foreach ($wService in ($AllNodes.SolemioQuevServiceState)) 
        {
			Service $wService.Name
			{
				Name        = $wService.Name
				State       = $wService.State
	        }
		}
    }
}

SetWinServiceStateDSC　-OutputPath .\MOF -ConfigurationData .\SetWinServiceDSC\ConfigurationData.psd1