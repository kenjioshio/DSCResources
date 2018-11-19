@{
    AllNodes = @(
        @{
            NodeName = "localhost"

            SolemioQuevServerServices = @(
                @{
#StartupType で遅延自動実行を設定する場合は別途コマンドを実行するか、Regisry Keyを作成するResourceを組み合わせて使用する
#Set-ItemProperty -Path "Registry::HKLM\System\CurrentControlSet\Services\theservice" -Name "DelayedAutostart" -Value 1 -Type DWORD
					Ensure      = "Present" 
					Name        = "CVXGateway"
					DisplayName = "OLYMPUS - CVXGateway"
					Path        = "C:\Olympus\CVXGateway\CVXGateway.exe" 
					StartupType = "Manual"  
					State       = "Running"
                },

				@{
					Ensure      = "Present" 
					Name        = "DICOMGateway"
					DisplayName = "OLYMPUS - DICOMGateway"
					Path        = "C:\Olympus\DICOMGateway\bin\DICOMGateway.exe" 
					StartupType = "Manual"  
					State       = "Running"
                }


            ) #SolemioQuevServerServices = @(...

			SolemioQuevServiceState = @(
                @{
					Name        = "CVXGateway"
					State       = "Stopped"
                },

				@{
					Name        = "DICOMGateway"
					State       = "Stopped"
                }


            ) #SolemioQuevServerServices = @(...
        } # localhost
    ) # AllNodes = @(...
}