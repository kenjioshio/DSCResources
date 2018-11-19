# Version="1.0.0.0"
# Product="" 　　　
# Copyright="Kenji Oshio" 
# Company="Olympus Corp"
#
# ネットワーク越しの設定は動かないようなので本DSCはLocalのPCのセットのみに有効です。

#
configuration SetACL
{
    Import-DscResource -ModuleName GraniResource

    node Localhost
    {

        cACL TLsFullCONTROL
        {
            Ensure  = "Present"
            Path    = "C:\host.txt"
            Account = $cACL.Account
            Rights  = "FullControl"
        }
    }
}