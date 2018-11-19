@{
    AllNodes = @(
        @{
            NodeName = "localhost"

            SolemioQuevServerServices = @(
                @{
#StartupType �Œx���������s��ݒ肷��ꍇ�͕ʓr�R�}���h�����s���邩�ARegisry Key���쐬����Resource��g�ݍ��킹�Ďg�p����
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