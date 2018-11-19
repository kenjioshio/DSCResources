# Version="1.0.0.0"
# Product="" �@�@�@
# Copyright="Kenji Oshio" 
# Company=""

## ****Attention!!****##
# 'Service'���\�[�X��'ServiceSet'���\�[�X�͈Ⴄ�̂Œ��ӂ��邱�ƁB
# �{DSC Script�͂��łɑ��݂��Ă���Service���X�^�[�g�i"Running"�j�E�X�g�b�v("Stopped")����ۂɎg�p����
#
# 'Service'���\�[�X��Serice�̑��݂Ƃ��̍ۂ̏�Ԃ�S�ۂ��郊�\�[�X�BService��Start��Stop�̃R���g���[����'ServiceSet'���\�[�X�ŒS�ۂ����
# 'Service'���\�[�X�ł�State�v���p�e�B�[��StartupType�v���p�e�B�[�Ɉˑ�����B
# e.g. �ȉ���Configurawtion�ł�MOF�͍쐬�ł��邪MOF�K�����G���[��������B
#	
#	StartupType = "Automatic"�̏ꍇ�AState = "Stopped"�͖������邽�ߓK���ł��Ȃ��B
#	���l��	
#	StartupType = "Disabled"�̏ꍇ�AState = "Running"�͖������邽�ߓK���ł��Ȃ��B
#�@ �܂��ȉ��̏ꍇ���Ȃ������s�ł��Ȃ�����(Service���\�[�X�̎d�l�H)�A���̏ꍇState����"Stopped"�œo�^��ServiceSet���\�[�X���g�p����Service��Start������B
#	StartupType = "Manual"�̏ꍇ�AState = "Running"
#   DepensOn��Service���쐬���Ă����Ԃ̕ύX��K�p�����ꍇ���G���[���N���Ă���̂�DSC Shell Script�Ƃ��ēƗ������č���Ă���B


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

SetWinServiceStateDSC�@-OutputPath .\MOF -ConfigurationData .\SetWinServiceDSC\ConfigurationData.psd1