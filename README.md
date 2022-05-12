# sm_dead-v1
Sxmux dead system v1. Classic Death OPTIMIZED, 0.01 while dead all configurable in the config

# Config File

Field Name | Description
| --- | --- |
```ReviveCommand_Label``` = 'rianima' | Configurable /command to revive player ("staff member")
```SM.HealCommand_Label``` = 'cura' | Configurable /command to heal player ("staff member")
```SM.Admin = 'mod'``` | Second group to be enable to revive a player.
```SM.KeyToRespawn``` = 'E' | Key to respawn after seconds
```SM.ItemToRevive``` = {{itemname = 'medikit', quantity = 1} | Max 1 item
```SM.UseSaltyChat``` = false | Use SaltyChat?
```SM.SecondToRespawn``` = 300 | Value in seconds
```SM.Coord_Respawn``` = vec4(297.4962, -582.9484, 43.1325, 32.4987) | Coords respwawn: Default is Pillbox Hospital.
```SM.animDict``` = 'dead'
```SM.animName``` = 'dead_a'
```SM.ReloadDeathAnimTime``` = 2000
```SM.EnableDebugCommand``` = true -- enable command /die?


```SM.Languages = {
    ```['predeath_prog_label'] = 'Stai per morire dissanguato.',```
    ```['haven\'t_medikit'] = 'Non hai abbastanza ', -- left space for item name pls.```
    ```['respwan_avviable'] = 'RESPAWN DISPONIBILE IN ', -- text time to respawn```
    ```['click_to_respawn'] = 'PREMI [~b~E~s~] PER TORNARE IN OSPEDALE',```
    ```['you\'re_not_dead'] = 'Non sei morto! Se vuoi curarti usa il comando /'
}```
