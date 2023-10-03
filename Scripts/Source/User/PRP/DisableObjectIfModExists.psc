Scriptname PRP:DisableObjectIfModExists extends Quest

ObjectReference Property EnableParent Auto Const Mandatory
String Property PluginName Auto Const Mandatory

Event OnQuestInit()
    If (Game.IsPluginInstalled(PluginName))
        EnableParent.Disable()
    EndIf
	Stop()
EndEvent
