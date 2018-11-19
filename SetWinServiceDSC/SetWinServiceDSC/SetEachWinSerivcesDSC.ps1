# Version="1.0.0.0"
# Product="" �@�@�@
# Copyright="Kenji Oshio" 
# Company=""

## ****Attention!!****##
# 'Service'���\�[�X��'ServiceSet'���\�[�X�͈Ⴄ�̂Œ��ӂ��邱�ƁB
# 'Service'���\�[�X��Serice�̑��݂Ƃ��̍ۂ̏�Ԃ�S�ۂ��郊�\�[�X�BService��Start��Stop�̃R���g���[����'ServiceSet'���\�[�X�ŒS�ۂ����
# 'Service'���\�[�X�ł�State�v���p�e�B�[��StartupType�v���p�e�B�[�Ɉˑ�����B
# e.g. �ȉ���Configurawtion�ł�MOF�͍쐬�ł��邪MOF�K�����G���[��������B
#	
#	StartupType = "Automatic"�̏ꍇ�AState = "Stopped"�͖������邽�ߓK���ł��Ȃ��B
#	���l��	
#	StartupType = "Disabled"�̏ꍇ�AState = "Running"�͖������邽�ߓK���ł��Ȃ��B
#�@ �܂��ȉ��̏ꍇ�AMOF�͓K�p�ł��邪�A�蓮��Status��ύX�����ꍇ�A�ēxMOF�̓K�p���s�ł��Ȃ�����(Service���\�[�X�̎d�l�H)�A
#	���̏ꍇState�Ȃ�Service�̃v���p�e�B�[�̕ύX�́A[ServiceSet]���\�[�X���g�p���ĕύX������菇�ƂȂ�B
#	StartupType = "Manual"�̏ꍇ�AState = "Running"��State��GUI����Stopped�ɂ����ꍇ�AMOF�̓K�p(Start-Configuration)��Error�������K�p�ł��Ȃ��B
#	Service�̓o�^��Service�̏�Ԃ̕ύX�͕ʃ��\�[�X�Ŏ��{����K�v������B

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

SetWinServiceDSC�@-OutputPath .\MOF -ConfigurationData .\SetWinServiceDSC\ConfigurationData.psd1