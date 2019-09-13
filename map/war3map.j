globals
//globals from BzAPI:
constant boolean LIBRARY_BzAPI=true
trigger array BzAPI__DamageEventQueue
integer BzAPI__DamageEventNumber= 0
//endglobals from BzAPI
//globals from JapiConstantLib:
constant boolean LIBRARY_JapiConstantLib=true
integer array i_1
integer array i_2
integer array i_3
integer array i_4
integer array i_5
integer array i_6
integer array i_7
integer array i_8
integer array i_9
integer array i_10
integer array i_11
integer array i_12
integer array i_13
integer array i_14
integer array i_15
integer array i_16
integer array i_17
integer array i_18
integer array i_19
integer array i_20
integer array i_21
integer array i_22
integer array i_23
integer array i_24
integer array i_25
integer array i_26
integer array i_27
integer array i_28
integer array i_29
integer array i_30
integer array i_31
integer array i_32

//endglobals from JapiConstantLib
//globals from Mtpplayername:
constant boolean LIBRARY_Mtpplayername=true
//endglobals from Mtpplayername
//globals from YDTriggerSaveLoadSystem:
constant boolean LIBRARY_YDTriggerSaveLoadSystem=true
hashtable YDHT
hashtable YDLOC
//endglobals from YDTriggerSaveLoadSystem
//globals from japi:
constant boolean LIBRARY_japi=true
hashtable japi_ht=InitHashtable()
integer japi__key=StringHash("jass")
//endglobals from japi
//globals from LocalActionLib:
constant boolean LIBRARY_LocalActionLib=true
constant hashtable LocalActionLib__ht=japi_ht
constant integer LocalActionLib__key=StringHash("jass")
//endglobals from LocalActionLib
    // User-defined
integer udg_i= 0
    // Generated
trigger gg_trg_japi_________u= null
trigger gg_trg____japi___u= null
trigger gg_trg_______japi___u= null
trigger gg_trg_api= null
trigger gg_trg_get_name= null
trigger gg_trg_lua= null
string array Player_name

trigger l__library_init
rect gg_rct_cg1= null
rect gg_rct_cg2= null
rect gg_rct_cg3= null
rect gg_rct_cgboss4= null
rect gg_rct_jg1= null
rect gg_rct_jg2_jd= null
rect gg_rct_npc1= null
rect gg_rct_npc2= null
rect gg_rct_npc3= null
rect gg_rct_npc4= null
rect gg_rct_npc5= null
rect gg_rct_npc6= null
rect gg_rct_npc7= null
rect gg_rct_npc8= null
rect gg_rct_npc9= null
rect gg_rct_xrcs= null
rect gg_rct_F2cs= null
rect gg_rct_sjjh1= null
rect gg_rct_sjjh2= null
rect gg_rct_sjjh3= null
rect gg_rct_lgf11= null
rect gg_rct_lgf12= null
rect gg_rct_lgf13= null
rect gg_rct_lgf14= null
rect gg_rct_lgfsg1= null
rect gg_rct_lgf21= null
rect gg_rct_lgf22= null
rect gg_rct_lgf23= null
rect gg_rct_lgf24= null
rect gg_rct_lgfsg2= null
rect gg_rct_lgf31= null
rect gg_rct_lgf32= null
rect gg_rct_lgf33= null
rect gg_rct_lgf34= null
rect gg_rct_lgfsg3= null
rect gg_rct_lgf41= null
rect gg_rct_lgf42= null
rect gg_rct_lgf43= null
rect gg_rct_lgf44= null
rect gg_rct_lgfsg4= null
rect gg_rct_lgf51= null
rect gg_rct_lgf52= null
rect gg_rct_lgf53= null
rect gg_rct_lgf54= null
rect gg_rct_lgfsg5= null
rect gg_rct_lgf61= null
rect gg_rct_lgf62= null
rect gg_rct_lgf63= null
rect gg_rct_lgf64= null
rect gg_rct_lgfsg6= null
rect gg_rct_wuqi1= null
rect gg_rct_wuqi11= null
rect gg_rct_wuqi2= null
rect gg_rct_wuqi22= null
rect gg_rct_wuqi3= null
rect gg_rct_wuqi33= null
rect gg_rct_wuqi4= null
rect gg_rct_wuqi5= null
rect gg_rct_wuqi55= null
rect gg_rct_wuqi6= null
rect gg_rct_wuqi66= null
rect gg_rct_wuqi7= null
rect gg_rct_wuqi77= null
rect gg_rct_wuqi8= null
rect gg_rct_wuqi88= null
rect gg_rct_wuqi9= null
rect gg_rct_wuqi99= null
rect gg_rct_wuqi10= null
rect gg_rct_wuqi1010= null
rect gg_rct_jia1= null
rect gg_rct_jia11= null
rect gg_rct_jia2= null
rect gg_rct_jia22= null
rect gg_rct_jia3= null
rect gg_rct_jia33= null
rect gg_rct_jia4= null
rect gg_rct_jia44= null
rect gg_rct_jia5= null
rect gg_rct_jia55= null
rect gg_rct_jia6= null
rect gg_rct_jia66= null
rect gg_rct_jia7= null
rect gg_rct_jia77= null
rect gg_rct_jia8= null
rect gg_rct_jia88= null
rect gg_rct_jia9= null
rect gg_rct_jia99= null
rect gg_rct_jia10= null
rect gg_rct_jia1010= null
rect gg_rct_wuqi44= null
rect gg_rct_jn1= null
rect gg_rct_jn11= null
rect gg_rct_jn2= null
rect gg_rct_jn22= null
rect gg_rct_jn3= null
rect gg_rct_jn33= null
rect gg_rct_jn4= null
rect gg_rct_jn44= null
rect gg_rct_xls4= null
rect gg_rct_xls44= null
rect gg_rct_jj11= null
rect gg_rct_jj1= null
rect gg_rct_jj22= null
rect gg_rct_jj2= null
rect gg_rct_jj33= null
rect gg_rct_jj3= null
rect gg_rct_jj44= null
rect gg_rct_jj4= null
rect gg_rct_jj55= null
rect gg_rct_jj5= null
rect gg_rct_jj66= null
rect gg_rct_jj6= null
rect gg_rct_jj77= null
rect gg_rct_jj7= null
rect gg_rct_jj88= null
rect gg_rct_jj8= null
rect gg_rct_jj99= null
rect gg_rct_jj9= null
rect gg_rct_jj1010= null
rect gg_rct_jj10= null
rect gg_rct_lgfbh1= null
rect gg_rct_lgfbh2= null
rect gg_rct_lgfbh3= null
rect gg_rct_lgfbh4= null
rect gg_rct_lgfbh6= null
rect gg_rct_lgfbh5= null
rect gg_rct_emo11= null
rect gg_rct_emo44= null
rect gg_rct_emo33= null
rect gg_rct_emo22= null
rect gg_rct_emo4= null
rect gg_rct_emo3= null
rect gg_rct_emo2= null
rect gg_rct_emo1= null
rect gg_rct_xuanren= null
rect gg_rct_xls3= null
rect gg_rct_xls33= null
rect gg_rct_xls2= null
rect gg_rct_xls22= null
rect gg_rct_xls1= null
rect gg_rct_xls11= null
rect gg_rct_xxzh11= null
rect gg_rct_xxzh12= null
rect gg_rct_xxzh13= null
rect gg_rct_xxzh14= null
rect gg_rct_ylxy11= null
rect gg_rct_ylxy12= null
rect gg_rct_ylxy13= null
rect gg_rct_ylxy14= null
rect gg_rct_sqyyh11= null
rect gg_rct_sqyyh12= null
rect gg_rct_sqyyh13= null
rect gg_rct_sqyyh14= null
rect gg_rct_xwty11= null
rect gg_rct_xwty12= null
rect gg_rct_xwty13= null
rect gg_rct_xwty14= null
rect gg_rct_xwty111= null
rect gg_rct_sqyyh111= null
rect gg_rct_ylxy111= null
rect gg_rct_xxzh111= null
rect gg_rct_xxzh1= null
rect gg_rct_ylxy1= null
rect gg_rct_sqyyh1= null
rect gg_rct_xwty1= null
rect gg_rct_fdm1= null
rect gg_rct_fdm11= null
rect gg_rct_ttxd11= null
rect gg_rct_ttxd1= null
rect gg_rct_cbt1= null
rect gg_rct_cbt111= null
rect gg_rct_cbt11= null
rect gg_rct_cbt12= null
rect gg_rct_cbt2= null
rect gg_rct_sd1= null
rect gg_rct_sd11= null
rect gg_rct_jia1111= null
rect gg_rct_jia111= null
rect gg_rct_wldh= null
rect gg_rct_wuqi1111= null
rect gg_rct_wuqi111= null
rect gg_rct_nainiu1= null
rect gg_rct_nainiu11= null
rect gg_rct_nainiu12= null
rect gg_rct_nainiu13= null
rect gg_rct_hdsz= null
rect gg_rct_tsgd1= null
rect gg_rct_tsgd11= null
rect gg_rct_tsgd22= null
rect gg_rct_tsgd33= null
rect gg_rct_npc10= null
rect gg_rct_jing= null
rect gg_rct_cyjx= null
rect gg_rct_tssx11= null
rect gg_rct_tssx1= null
rect gg_rct_tssx22= null
rect gg_rct_tssx2= null
rect gg_rct_tssx33= null
rect gg_rct_tssx3= null
rect gg_rct_tssx44= null
rect gg_rct_tssx4= null
rect gg_rct_tsjx5= null
rect gg_rct_tsjx55= null
rect gg_rct_tsjx6= null
rect gg_rct_tsjx66= null
rect gg_rct_tsjx7= null
rect gg_rct_tsjx77= null
rect gg_rct_tsjx8= null
rect gg_rct_tsjx88= null
rect gg_rct_bncf1= null
rect gg_rct_bncf2= null
rect gg_rct_bncf8= null
rect gg_rct_bncf7= null
rect gg_rct_bncf3= null
rect gg_rct_bncf9= null
rect gg_rct_bncf4= null
rect gg_rct_bncf6= null
rect gg_rct_bncf5= null

rect gg_rct_wjhy1= null
rect gg_rct_wjhy11= null
rect gg_rct_wjhy22= null
rect gg_rct_wjhy33= null

endglobals

    native DzGetMouseTerrainX takes nothing returns real
    native DzGetMouseTerrainY takes nothing returns real
    native DzGetMouseTerrainZ takes nothing returns real
    native DzIsMouseOverUI takes nothing returns boolean
    native DzGetMouseX takes nothing returns integer
    native DzGetMouseY takes nothing returns integer
    native DzGetMouseXRelative takes nothing returns integer
    native DzGetMouseYRelative takes nothing returns integer
    native DzSetMousePos takes integer x, integer y returns nothing
    native DzTriggerRegisterMouseEvent takes trigger trig, integer btn, integer status, boolean sync, string func returns nothing
    native DzTriggerRegisterMouseEventByCode takes trigger trig, integer btn, integer status, boolean sync, code funcHandle returns nothing
    native DzTriggerRegisterKeyEvent takes trigger trig, integer key, integer status, boolean sync, string func returns nothing
    native DzTriggerRegisterKeyEventByCode takes trigger trig, integer key, integer status, boolean sync, code funcHandle returns nothing
    native DzTriggerRegisterMouseWheelEvent takes trigger trig, boolean sync, string func returns nothing
    native DzTriggerRegisterMouseWheelEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    native DzTriggerRegisterMouseMoveEvent takes trigger trig, boolean sync, string func returns nothing
    native DzTriggerRegisterMouseMoveEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    native DzGetTriggerKey takes nothing returns integer
    native DzGetWheelDelta takes nothing returns integer
    native DzIsKeyDown takes integer iKey returns boolean
    native DzGetTriggerKeyPlayer takes nothing returns player
    native DzGetWindowWidth takes nothing returns integer
    native DzGetWindowHeight takes nothing returns integer
    native DzGetWindowX takes nothing returns integer
    native DzGetWindowY takes nothing returns integer
    native DzTriggerRegisterWindowResizeEvent takes trigger trig, boolean sync, string func returns nothing
    native DzTriggerRegisterWindowResizeEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing
    native DzIsWindowActive takes nothing returns boolean
    native DzDestructablePosition takes destructable d, real x, real y returns nothing
    native DzSetUnitPosition takes unit whichUnit, real x, real y returns nothing
    native DzExecuteFunc takes string funcName returns nothing
    native DzGetUnitUnderMouse takes nothing returns unit
    native DzSetUnitTexture takes unit whichUnit, string path, integer texId returns nothing
    native DzSetMemory takes integer address, real value returns nothing
    native DzSetUnitID takes unit whichUnit, integer id returns nothing
    native DzSetUnitModel takes unit whichUnit, string path returns nothing
    native DzSetWar3MapMap takes string map returns nothing
    native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing
    native DzSyncData takes string prefix, string data returns nothing
    native DzGetTriggerSyncData takes nothing returns string
    native DzGetTriggerSyncPlayer takes nothing returns player
    native DzFrameHideInterface takes nothing returns nothing
    native DzFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing
    native DzFrameGetPortrait takes nothing returns integer
    native DzFrameGetMinimap takes nothing returns integer
    native DzFrameGetCommandBarButton takes integer row, integer column returns integer
    native DzFrameGetHeroBarButton takes integer buttonId returns integer
    native DzFrameGetHeroHPBar takes integer buttonId returns integer
    native DzFrameGetHeroManaBar takes integer buttonId returns integer
    native DzFrameGetItemBarButton takes integer buttonId returns integer
    native DzFrameGetMinimapButton takes integer buttonId returns integer
    native DzFrameGetUpperButtonBarButton takes integer buttonId returns integer
    native DzFrameGetTooltip takes nothing returns integer
    native DzFrameGetChatMessage takes nothing returns integer
    native DzFrameGetUnitMessage takes nothing returns integer
    native DzFrameGetTopMessage takes nothing returns integer
    native DzGetColor takes integer r, integer g, integer b, integer a returns integer
    native DzFrameSetUpdateCallback takes string func returns nothing
    native DzFrameSetUpdateCallbackByCode takes code funcHandle returns nothing
    native DzFrameShow takes integer frame, boolean enable returns nothing
    native DzCreateFrame takes string frame, integer parent, integer id returns integer
    native DzCreateSimpleFrame takes string frame, integer parent, integer id returns integer
    native DzDestroyFrame takes integer frame returns nothing
    native DzLoadToc takes string fileName returns nothing
    native DzFrameSetPoint takes integer frame, integer point, integer relativeFrame, integer relativePoint, real x, real y returns nothing
    native DzFrameSetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
    native DzFrameClearAllPoints takes integer frame returns nothing
    native DzFrameSetEnable takes integer name, boolean enable returns nothing
    native DzFrameSetScript takes integer frame, integer eventId, string func, boolean sync returns nothing
    native DzFrameSetScriptByCode takes integer frame, integer eventId, code funcHandle, boolean sync returns nothing
    native DzGetTriggerUIEventPlayer takes nothing returns player
    native DzGetTriggerUIEventFrame takes nothing returns integer
    native DzFrameFindByName takes string name, integer id returns integer
    native DzSimpleFrameFindByName takes string name, integer id returns integer
    native DzSimpleFontStringFindByName takes string name, integer id returns integer
    native DzSimpleTextureFindByName takes string name, integer id returns integer
    native DzGetGameUI takes nothing returns integer
    native DzClickFrame takes integer frame returns nothing
    native DzSetCustomFovFix takes real value returns nothing
    native DzEnableWideScreen takes boolean enable returns nothing
    native DzFrameSetText takes integer frame, string text returns nothing
    native DzFrameGetText takes integer frame returns string
    native DzFrameSetTextSizeLimit takes integer frame, integer size returns nothing
    native DzFrameGetTextSizeLimit takes integer frame returns integer
    native DzFrameSetTextColor takes integer frame, integer color returns nothing
    native DzGetMouseFocus takes nothing returns integer
    native DzFrameSetAllPoints takes integer frame, integer relativeFrame returns boolean
    native DzFrameSetFocus takes integer frame, boolean enable returns boolean
    native DzFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing
    native DzFrameGetEnable takes integer frame returns boolean
    native DzFrameSetAlpha takes integer frame, integer alpha returns nothing
    native DzFrameGetAlpha takes integer frame returns integer
    native DzFrameSetAnimate takes integer frame, integer animId, boolean autocast returns nothing
    native DzFrameSetAnimateOffset takes integer frame, real offset returns nothing
    native DzFrameSetTexture takes integer frame, string texture, integer flag returns nothing
    native DzFrameSetScale takes integer frame, real scale returns nothing
    native DzFrameSetTooltip takes integer frame, integer tooltip returns nothing
    native DzFrameCageMouse takes integer frame, boolean enable returns nothing
    native DzFrameGetValue takes integer frame returns real
    native DzFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing
    native DzFrameSetStepValue takes integer frame, real step returns nothing
    native DzFrameSetValue takes integer frame, real value returns nothing
    native DzFrameSetSize takes integer frame, real w, real h returns nothing
    native DzCreateFrameByTagName takes string frameType, string name, integer parent, string template, integer id returns integer
    native DzFrameSetVertexColor takes integer frame, integer color returns nothing
    native SetHeroLevels takes code f returns nothing 
    native TeleportCaptain takes real x, real y returns nothing
    native GetUnitGoldCost takes integer unitid returns integer

	native DzAPI_Map_SaveServerValue        takes player whichPlayer, string key, string value returns boolean
    native DzAPI_Map_GetServerValue         takes player whichPlayer, string key returns string
    native DzAPI_Map_Ladder_SetStat         takes player whichPlayer, string key, string value returns nothing
    native DzAPI_Map_IsRPGLadder            takes nothing returns boolean
    native DzAPI_Map_GetGameStartTime       takes nothing returns integer
    native DzAPI_Map_Stat_SetStat           takes player whichPlayer, string key, string value returns nothing
    native DzAPI_Map_GetMatchType      		takes nothing returns integer
    native DzAPI_Map_Ladder_SetPlayerStat   takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetServerValueErrorCode takes player whichPlayer returns integer
    native DzAPI_Map_GetLadderLevel         takes player whichPlayer returns integer
	native DzAPI_Map_IsRedVIP               takes player whichPlayer returns boolean
	native DzAPI_Map_IsBlueVIP              takes player whichPlayer returns boolean
	native DzAPI_Map_GetLadderRank          takes player whichPlayer returns integer
	native DzAPI_Map_GetMapLevelRank        takes player whichPlayer returns integer
	native DzAPI_Map_GetGuildName           takes player whichPlayer returns string
	native DzAPI_Map_GetGuildRole           takes player whichPlayer returns integer
	native DzAPI_Map_GetMapLevel            takes player whichPlayer returns integer
	native DzAPI_Map_MissionComplete        takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetActivityData        takes nothing returns string
	native DzAPI_Map_IsRPGLobby             takes nothing returns boolean
	native DzAPI_Map_GetMapConfig           takes string key returns string
	native DzAPI_Map_HasMallItem            takes player whichPlayer, string key returns boolean

//library BzAPI:
    //hardware




























    //plus









    //sync




    //gui
































































    function DzTriggerRegisterMouseEventTrg takes trigger trg,integer status,integer btn returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterMouseEvent(trg, btn, status, true, null)
    endfunction
    function DzTriggerRegisterKeyEventTrg takes trigger trg,integer status,integer btn returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterKeyEvent(trg, btn, status, true, null)
    endfunction
    function DzTriggerRegisterMouseMoveEventTrg takes trigger trg returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterMouseMoveEvent(trg, true, null)
    endfunction
    function DzTriggerRegisterMouseWheelEventTrg takes trigger trg returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterMouseWheelEvent(trg, true, null)
    endfunction
    function DzTriggerRegisterWindowResizeEventTrg takes trigger trg returns nothing
        if trg == null then
            return
        endif
        call DzTriggerRegisterWindowResizeEvent(trg, true, null)
    endfunction
    function DzF2I takes integer i returns integer
        return i
    endfunction
    function DzI2F takes integer i returns integer
        return i
    endfunction
    function DzK2I takes integer i returns integer
        return i
    endfunction
    function DzI2K takes integer i returns integer
        return i
    endfunction

//library BzAPI ends
//library JapiConstantLib:
    function JapiConstantLib_init_memory takes nothing returns nothing
         set i_1[8191]=0
 set i_2[8191]=0
 set i_3[8191]=0
 set i_4[8191]=0
 set i_5[8191]=0
 set i_6[8191]=0
 set i_7[8191]=0
 set i_8[8191]=0
 set i_9[8191]=0
 set i_10[8191]=0
 set i_11[8191]=0
 set i_12[8191]=0
 set i_13[8191]=0
 set i_14[8191]=0
 set i_15[8191]=0
 set i_16[8191]=0
 set i_17[8191]=0
 set i_18[8191]=0
 set i_19[8191]=0
 set i_20[8191]=0
 set i_21[8191]=0
 set i_22[8191]=0
 set i_23[8191]=0
 set i_24[8191]=0
 set i_25[8191]=0
 set i_26[8191]=0
 set i_27[8191]=0
 set i_28[8191]=0
 set i_29[8191]=0
 set i_30[8191]=0
 set i_31[8191]=0
 set i_32[8191]=0

    endfunction
    function JapiConstantLib_init takes nothing returns integer
        call ExecuteFunc("JapiConstantLib_init_memory")
        return 1
    endfunction

//library JapiConstantLib ends
//library Mtpplayername:
    function Mtpplayername__initgetname takes nothing returns nothing
        local integer i= 0
        local string name
        set i=0
        loop
            exitwhen ( i > 12 )
            set i=i + 1
            
            set name="|cff000000" + GetPlayerName(ConvertedPlayer(i)) + "|r"
            set Player_name[i]=name
        endloop
    endfunction

//library Mtpplayername ends
//library YDTriggerSaveLoadSystem:
    function YDTriggerSaveLoadSystem__Init takes nothing returns nothing
            set YDHT=InitHashtable()
        set YDLOC=InitHashtable()
    endfunction

//library YDTriggerSaveLoadSystem ends
//library japi:



    
    
     function Call takes string str returns nothing
        call UnitId(str)
    endfunction
    //获取鼠标在地图中的x轴
     function GetMouseX takes nothing returns real
        call SaveStr(japi_ht, japi__key, 0, "()R")
        call UnitId(("GetMouseX")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
    endfunction
    //获取鼠标在地图中的y轴
     function GetMouseY takes nothing returns real
        call SaveStr(japi_ht, japi__key, 0, "()R")
        call UnitId(("GetMouseY")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
    endfunction
    
    
    
    
    //==========================================================================
     function EXGetUnitAbility takes unit u,integer abilityId returns integer
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(u))
        call SaveInteger(japi_ht, japi__key, 2, abilityId)
        call SaveStr(japi_ht, japi__key, 0, "(II)I")
        call UnitId(("EXGetUnitAbility")) // INLINED!!
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
    
    // yd japi ==================================================================
    // 技能----------------------------------------------------
    
    ///<summary>技能属性 [JAPI]</summary>
  function YDWEGetUnitAbilityState takes unit u,integer abilcode,integer data_type returns real
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(II)R")
        call UnitId(("EXGetAbilityState")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
	endfunction
	///<summary>技能数据 (整数) [JAPI]</summary>
  function YDWEGetUnitAbilityDataInteger takes unit u,integer abilcode,integer level,integer data_type returns integer
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(III)I")
        call UnitId(("EXGetAbilityDataInteger")) // INLINED!!
		return LoadInteger(japi_ht, japi__key, 0)
	endfunction
	///<summary>技能数据 (实数) [JAPI]</summary>
  function YDWEGetUnitAbilityDataReal takes unit u,integer abilcode,integer level,integer data_type returns real
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(III)R")
        call UnitId(("EXGetAbilityDataReal")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
    endfunction
	///<summary>技能数据 (字符串) [JAPI]</summary>
  function YDWEGetUnitAbilityDataString takes unit u,integer abilcode,integer level,integer data_type returns string
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(III)S")
        call UnitId(("EXGetAbilityDataString")) // INLINED!!
		return LoadStr(japi_ht, japi__key, 0)
	endfunction
	///<summary>设置技能属性 [JAPI]</summary>
  function YDWESetUnitAbilityState takes unit u,integer abilcode,integer data_type,real value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, data_type)
        call SaveReal(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIR)V")
        call UnitId(("EXSetAbilityState")) // INLINED!!
    endfunction
	///<summary>设置技能数据 (整数) [JAPI]</summary>
  function YDWESetUnitAbilityDataInteger takes unit u,integer abilcode,integer level,integer data_type,integer value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveInteger(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIII)V")
        call UnitId(("EXSetAbilityDataInteger")) // INLINED!!
    endfunction
	///<summary>设置技能数据 (实数) [JAPI]</summary>
  function YDWESetUnitAbilityDataReal takes unit u,integer abilcode,integer level,integer data_type,real value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveReal(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIIR)V")
        call UnitId(("EXSetAbilityDataReal")) // INLINED!!
    endfunction
	///<summary>设置技能数据 (字符串) [JAPI]</summary>
  function YDWESetUnitAbilityDataString takes unit u,integer abilcode,integer level,integer data_type,string value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIIS)V")
        call UnitId(("EXSetAbilityDataString")) // INLINED!!
    endfunction
	
    
    //设置技能变身数据A
     function EXSetAbilityAEmeDataA takes integer ability_handle,integer value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, ability_handle)
        call SaveInteger(japi_ht, japi__key, 2, value)
        call SaveStr(japi_ht, japi__key, 0, "(II)B")
        call UnitId(("EXSetAbilityAEmeDataA")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
    //单位变身
     function YDWEUnitTransform takes unit u,integer abilcode,integer targetid returns nothing
		call UnitAddAbility(u, abilcode)
		call YDWESetUnitAbilityDataInteger(u , abilcode , 1 , 117 , GetUnitTypeId(u))
		call EXSetAbilityAEmeDataA(EXGetUnitAbility(u , abilcode) , GetUnitTypeId(u))
		call UnitRemoveAbility(u, abilcode)
		call UnitAddAbility(u, abilcode)
		call EXSetAbilityAEmeDataA(EXGetUnitAbility(u , abilcode) , targetid)
		call UnitRemoveAbility(u, abilcode)
	endfunction
    
    // 单位-------------------------------------------------------
    
    //暂停单位
     function EXPauseUnit takes unit unit_handle,boolean flag returns nothing
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(unit_handle))
        call SaveBoolean(japi_ht, japi__key, 2, flag)
        call SaveStr(japi_ht, japi__key, 0, "(IB)V")
        call UnitId(("EXPauseUnit")) // INLINED!!
    endfunction
    
    //获取单位字符串
     function EXGetUnitString takes integer unitcode,integer Type returns string
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)S")
        call UnitId(("EXGetUnitString")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
       //设置单位字符串
     function EXSetUnitString takes integer unitcode,integer Type,string value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIS)B")
        call UnitId(("EXSetUnitString")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
    //获取单位实数
     function EXGetUnitReal takes integer unitcode,integer Type returns real
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)R")
        call UnitId(("EXGetUnitReal")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
    endfunction
    
    //设置单位实数
     function EXSetUnitReal takes integer unitcode,integer Type,real value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveReal(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIR)B")
        call UnitId(("EXSetUnitReal")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
    
    //获取单位整数
     function EXGetUnitInteger takes integer unitcode,integer Type returns integer
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)I")
        call UnitId(("EXGetUnitInteger")) // INLINED!!
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
    
    //设置单位整数
     function EXSetUnitInteger takes integer unitcode,integer Type,integer value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveInteger(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(III)B")
        call UnitId(("EXSetUnitInteger")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
        //获取单位数组字符串
     function EXGetUnitArrayString takes integer unitcode,integer Type,integer index returns string
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveInteger(japi_ht, japi__key, 3, index)
        call SaveStr(japi_ht, japi__key, 0, "(III)S")
        call UnitId(("EXGetUnitArrayString")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
    //设置单位数组字符串
     function EXSetUnitArrayString takes integer unitcode,integer Type,integer index,string value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveInteger(japi_ht, japi__key, 3, index)
        call SaveStr(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIIS)B")
        call UnitId(("EXSetUnitArrayString")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    //设置单位面向角度(立即转向)
     function EXSetUnitFacing takes unit unit_handle,real angle returns nothing
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(unit_handle))
        call SaveReal(japi_ht, japi__key, 2, angle)
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call UnitId(("EXSetUnitFacing")) // INLINED!!
    endfunction
    
    //设置单位碰撞类型
     function EXSetUnitCollisionType takes boolean enable,unit unit_handle,integer Type returns nothing
        call SaveBoolean(japi_ht, japi__key, 1, enable)
        call SaveInteger(japi_ht, japi__key, 2, GetHandleId(unit_handle))
        call SaveInteger(japi_ht, japi__key, 3, Type)
        call SaveStr(japi_ht, japi__key, 0, "(BII)V")
        call UnitId(("EXSetUnitCollisionType")) // INLINED!!
    endfunction
    
    //设置单位移动类型
     function EXSetUnitMoveType takes unit unit_handle,integer Type returns nothing
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(unit_handle))
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)V")
        call UnitId(("EXSetUnitMoveType")) // INLINED!!
    endfunction
    
    //单位添加眩晕
     function YDWEUnitAddStun takes unit u returns nothing
		call EXPauseUnit(u , true)
	endfunction
    
    //单位删除眩晕
  function YDWEUnitRemoveStun takes unit u returns nothing
		call EXPauseUnit(u , false)
	endfunction
    
    //获取伤害数据
     function EXGetEventDamageData takes integer Type returns integer
        //call SaveInteger(ht,key,1,Type)
        //call SaveStr(ht,key,0,"(I)I")
        //call Call("EXGetEventDamageData")
        //return LoadInteger(ht,key,0)
        return GetUnitGoldCost(Type)
    endfunction
	
    //设置伤害
     function EXSetEventDamage takes real Damage returns boolean
        //call SaveReal(ht,key,1,Damage)
        //call SaveStr(ht,key,0,"(R)B")
        //call Call("EXSetEventDamage")
        //return LoadBoolean(ht,key,0)
        call TeleportCaptain(Damage, 0.00)
        return true
    endfunction
    
    //判断是否是物理伤害
     function YDWEIsEventPhysicalDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((1))) // INLINED!!
	endfunction
    //判断是否是攻击伤害
  function YDWEIsEventAttackDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((2))) // INLINED!!
	endfunction
	
    //判断是否是范围伤害
  function YDWEIsEventRangedDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((3))) // INLINED!!
	endfunction
	
    //判断伤害类型
  function YDWEIsEventDamageType takes damagetype damageType returns boolean
		return damageType == ConvertDamageType((GetUnitGoldCost((4)))) // INLINED!!
	endfunction
    
    //判断武器类型
  function YDWEIsEventWeaponType takes weapontype weaponType returns boolean
		return weaponType == ConvertWeaponType((GetUnitGoldCost((5)))) // INLINED!!
	endfunction
	
    //判断攻击类型
  function YDWEIsEventAttackType takes attacktype attackType returns boolean
		return attackType == ConvertAttackType((GetUnitGoldCost((6)))) // INLINED!!
	endfunction
	//设置伤害
  function YDWESetEventDamage takes real amount returns boolean
		return EXSetEventDamage(amount)
	endfunction
    
    // 物品----------------------------------------------------
    
    ///<summary>设置物品数据 (字符串) [JAPI]</summary>
     function YDWESetItemDataString takes integer ItemTypeId,integer Type,string Value returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IIS)V")
        call SaveInteger(japi_ht, japi__key, 1, ItemTypeId)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 3, Value)
        call UnitId(("EXSetItemDataString")) // INLINED!!
    endfunction
    ///<summary>获取物品数据 (字符串) [JAPI]</summary>
     function YDWEGetItemDataString takes integer ItemTypeId,integer Type returns string
        call SaveStr(japi_ht, japi__key, 0, "(II)S")
        call SaveInteger(japi_ht, japi__key, 1, ItemTypeId)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call UnitId(("EXGetItemDataString")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
    //特效--------------------------------------------------------
    
    ///<summary>设置特效坐标 [JAPI]</summary>
     function EXSetEffectXY takes effect Handle,real x,real y returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call SaveReal(japi_ht, japi__key, 3, y)
        call UnitId(("EXSetEffectXY")) // INLINED!!
    endfunction
    
    ///<summary>设置特效Z轴 [JAPI]</summary>
     function EXSetEffectZ takes effect Handle,real z returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, z)
		call UnitId(("EXSetEffectZ")) // INLINED!!
	endfunction
    
    ///<summary>获取特效X轴 [JAPI]</summary>
     function EXGetEffectX takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectX")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>获取特效Y轴 [JAPI]</summary>
  function EXGetEffectY takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectY")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>获取特效Z轴 [JAPI]</summary>
  function EXGetEffectZ takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectZ")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>设置特效尺寸 [JAPI]</summary>
  function EXSetEffectSize takes effect Handle,real size returns nothing
		call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, size)
        call UnitId(("EXSetEffectSize")) // INLINED!!
	endfunction
    
    ///<summary>获取特效尺寸 [JAPI]</summary>
  function EXGetEffectSize takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectSize")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>设置特效X旋转轴 [JAPI]</summary>
  function EXEffectMatRotateX takes effect Handle,real x returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call UnitId(("EXEffectMatRotateX")) // INLINED!!
	endfunction
    
    ///<summary>设置特效Y旋转轴 [JAPI]</summary>
  function EXEffectMatRotateY takes effect Handle,real y returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, y)
        call UnitId(("EXEffectMatRotateY")) // INLINED!!
	endfunction
    
    ///<summary>设置特效Z旋转轴 [JAPI]</summary>
  function EXEffectMatRotateZ takes effect Handle,real z returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, z)
        call UnitId(("EXEffectMatRotateZ")) // INLINED!!
	endfunction
    
    ///<summary>设置特效比例 [JAPI]</summary>
  function EXEffectMatScale takes effect Handle,real x,real y,real z returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call SaveReal(japi_ht, japi__key, 3, y)
        call SaveReal(japi_ht, japi__key, 4, z)
        call UnitId(("EXEffectMatScale")) // INLINED!!
	endfunction
    
    ///<summary>设置特效重置 [JAPI]</summary>
  function EXEffectMatReset takes effect Handle returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(I)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXEffectMatReset")) // INLINED!!
	endfunction
    
    ///<summary>设置特效速率 [JAPI]</summary>
  function EXSetEffectSpeed takes effect Handle,real speed returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, speed)
        call UnitId(("EXSetEffectSpeed")) // INLINED!!
	endfunction
    
    ///<summary>设置可追踪物坐标 [JAPI]</summary>
     function EXSetTrackableXY takes trackable Handle,real x,real y returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call SaveReal(japi_ht, japi__key, 3, y)
        call UnitId(("EXSetEffectXY")) // INLINED!!
    endfunction
    
    
    ///<summary>获取可追踪物X轴 [JAPI]</summary>
     function EXGetTrackableX takes trackable Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectX")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>获取可追踪物Y轴 [JAPI]</summary>
  function EXGetTrackableY takes trackable Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectY")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    
    
     function EXExecuteScript takes string str returns string
        call SaveStr(japi_ht, japi__key, 0, "(S)S")
        call SaveStr(japi_ht, japi__key, 1, str)
        call UnitId(("EXExecuteScript")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    //-----------------模拟聊天----------------------------
     function EXDisplayChat takes player p,integer chat_recipient,string message returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IIS)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(p))
        call SaveInteger(japi_ht, japi__key, 2, chat_recipient)
        call SaveStr(japi_ht, japi__key, 3, message)
        call UnitId(("EXDisplayChat")) // INLINED!!
    endfunction
  function YDWEDisplayChat takes player p,integer chat_recipient,string message returns nothing
		call EXDisplayChat(p , chat_recipient , message)
	endfunction
    
    //-----------版本描述-------------------------------------
    
    //获取地图名字
     function GetMapName takes nothing returns string
        call SaveStr(japi_ht, japi__key, 0, "()S")
        call UnitId(("GetMapName")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
    //获取魔兽版本
     function GetGameVersion takes nothing returns integer
        call SaveStr(japi_ht, japi__key, 0, "()I")
        call UnitId(("GetGameVersion")) // INLINED!!
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
    
    //获取插件版本
     function GetPluginVersion takes nothing returns string
        call SaveStr(japi_ht, japi__key, 0, "()S")
        call UnitId(("GetPluginVersion")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
     function GetFuncAddr takes code f returns integer
        call SetHeroLevels(f)
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
     function japiDoNothing takes nothing returns nothing
        
    endfunction
    
     function func_bind_trigger_name takes code functions,string name returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IS)V")
        call SaveInteger(japi_ht, japi__key, 1, GetFuncAddr(functions))
        call SaveStr(japi_ht, japi__key, 2, name)
        call UnitId(("func_bind_trigger_name")) // INLINED!!
    endfunction
    
     function open_code_run_logs takes boolean open returns nothing
        local string l=""
        set l=l + "(function () "
        set l=l + "lfunc={}  lfunc_name={}"
        set l=l + "save_lfunc_info=function (func,name,index)index=1<<index lfunc[func]=index lfunc_name[index]=name end "
        set l=l + "save_lfunc_info('GetLocalPlayer','[本地玩家]',0)"
        set l=l + "save_lfunc_info('GetFps','[获取帧数]',1)"
        set l=l + "save_lfunc_info('GetChatState','[聊天状态]',2)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionLoc','[当前镜头目标点]',3)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionX','[当前镜头目标X坐标]',4)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionY','[当前镜头目标Y坐标]',5)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionZ','[当前镜头目标Z坐标]',6)"
        
        set l=l + "save_lfunc_info('GetCameraEyePositionLoc','[当前镜头源位置]',7)"
        set l=l + "save_lfunc_info('GetCameraEyePositionX','[当前镜头源X坐标]',8)"
        set l=l + "save_lfunc_info('GetCameraEyePositionY','[当前镜头源Y坐标]',9)"
        set l=l + "save_lfunc_info('GetCameraEyePositionZ','[当前镜头源Z坐标]',10)"
        
        set l=l + "save_lfunc_info('GetMouseX','[获取鼠标X轴]',11)"
        set l=l + "save_lfunc_info('GetMouseY','[获取鼠标Y轴]',12)"
        set l=l + "save_lfunc_info('GetMouseVectorX','[获取鼠标屏幕X轴]',13)"
        set l=l + "save_lfunc_info('GetMouseVectorY','[获取鼠标屏幕Y轴]',14)"
        
        set l=l + "end)() or '' "
        call EXExecuteScript(l)
        
        set l=""
        
        set l=l + "(function () "
        
        set l=l + "get_jass_func_info=function (func_name) "
        set l=l + " return lfunc[func_name] or 0 "
        set l=l + "end "
        
        set l=l + "get_jass_func_msg=function (func_name_index)"
        set l=l + " return lfunc_name[func_name_index] or '' "
        set l=l + "end "
        
        set l=l + "local storm=require 'jass.storm' "
        set l=l + "local ss=storm.load('war3map.j') "
        set l=l + "ss:gsub('function%s+([%w_]+)%s+takes(.-)endfunction',function (name,code)\n"
        set l=l + "code=code:gsub('function%s+','function_'):gsub('//[^\\n]-\\n','')\n"
        set l=l + "code:gsub('([%w_]+)',function (str) "
        set l=l + "if lfunc[str]~=nil then "
        set l=l + "local flag=lfunc[name] or 0 "
        set l=l + "lfunc[name]=flag | lfunc[str] "
        set l=l + "end "
        set l=l + "end) "
        set l=l + "end) "
        set l=l + "ss=nil  return '' "
        set l=l + "end)() or '' "
        call EXExecuteScript(l)
        call SaveStr(japi_ht, japi__key, 0, "(B)V")
        call SaveBoolean(japi_ht, japi__key, 1, open)
        call UnitId(("open_code_run_logs")) // INLINED!!
    endfunction
    
    
    
     function initializePlugin takes nothing returns integer
        call ExecuteFunc("japiDoNothing")
        call StartCampaignAI(Player(PLAYER_NEUTRAL_AGGRESSIVE), "callback")
        call UnitId((I2S(GetHandleId(japi_ht)))) // INLINED!!
        call SaveStr(japi_ht, japi__key, 0, "(I)V")
        call SaveInteger(japi_ht, japi__key, 1, GetFuncAddr(function japiDoNothing))
        call UnitId(("SaveFunc")) // INLINED!!
        call ExecuteFunc("japiDoNothing")
        return 0
    endfunction

//library japi ends
//library LocalActionLib:
    function LocalActionLib__Call takes string str returns nothing
        call UnitId(str)
    endfunction
    
    //本地发布无目标命令
    function LocalOrder takes integer order,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(II)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 2, flags)
        call UnitId(("LocalOrder")) // INLINED!!
    endfunction
    
    //本地发布坐标命令
    function LocalPointOrder takes integer order,real x,real y,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IRRI)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveReal(LocalActionLib__ht, LocalActionLib__key, 2, x)
        call SaveReal(LocalActionLib__ht, LocalActionLib__key, 3, y)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 4, flags)
        call UnitId(("LocalPointOrder")) // INLINED!!
    endfunction
    
    //本地发布目标命令
    function LocalTargetOrder takes integer order,widget object,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IHwidget;I)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveWidgetHandle(LocalActionLib__ht, LocalActionLib__key, 2, object)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 3, flags)
        call UnitId(("LocalTargetOrder")) // INLINED!!
    endfunction
    
    //获取玩家当前选择的单位
    function GetPlayerSelectedUnit takes player p returns unit
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(I)Hunit;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, GetHandleId(p))
        call UnitId(("GetPlayerSelectedUnit")) // INLINED!!
        return LoadUnitHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取玩家当前鼠标指向的单位
    function GetTargetUnit takes nothing returns unit
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hunit;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadUnitHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取玩家当前鼠标指向的物品
    function GetTargetItem takes nothing returns item
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hitem;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadItemHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取玩家当前鼠标指向的 可选择的可破坏物
    function GetTargetDestructable takes nothing returns destructable
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hdestructable;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadDestructableHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    // 设置单位技能按钮是否显示   false 即隐藏 隐藏之后无法发布命令 跟玩家禁用相同
    //使用不会打断命令  可以 在发布命令的时候  显示 发布命令 隐藏 即可
    function SetUnitAbilityButtonShow takes unit u,integer id,boolean show returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IIB)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, GetHandleId(u))
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 2, id)
        call SaveBoolean(LocalActionLib__ht, LocalActionLib__key, 3, show)
        call UnitId(("SetUnitAbilityButtonShow")) // INLINED!!
    endfunction
    
    //设置 是否显示FPS  显示状态下 调用false 可以隐藏 ，相反可以显示
    function ShowFpsText takes boolean Open returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(B)V")
        call SaveBoolean(LocalActionLib__ht, LocalActionLib__key, 1, Open)
        call UnitId(("ShowFpsText")) // INLINED!!
    endfunction
    
    //获取当前游戏的 fps值  即 游戏画面的帧数
    function GetFps takes nothing returns real
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "()R")
        call UnitId(("GetFps")) // INLINED!!
        return LoadReal(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取聊天状态  有聊天输入框的情况下 返回true  没有返回false 
    //可以通过 d3d库里的模拟按键 模拟按下ESC 或者enter 来禁止玩家聊天
    function GetChatState takes nothing returns boolean
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "()B")
        call UnitId(("GetChatState")) // INLINED!!
        return LoadBoolean(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
  

//library LocalActionLib ends
//===========================================================================
// 
// 只是另外一张魔兽争霸的地图
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Sat Jan 12 22:10:49 2019
//   Map Author: 未知
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
    set udg_i=0
endfunction
//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************
//===========================================================================
// Trigger: japi常量库
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0


        
    //键盘键位 
    //以下键位 按下 运行 TextureAddEvent 的第3个参数
    //弹起 运行 第4个参数
    
    //大键盘数字键
    
    //小键盘 数字键
    
    
    
    
    
    
    //魔兽版本 用GetGameVersion 来获取当前版本 来对比以下具体版本做出相应操作
    //-----------模拟聊天------------------
    
    //---------技能数据类型---------------
    
    ///<summary>冷却时间</summary>
    ///<summary>目标允许</summary>
    ///<summary>施放时间</summary>
    ///<summary>持续时间</summary>
    ///<summary>持续时间</summary>
    ///<summary>魔法消耗</summary>
    ///<summary>施放间隔</summary>
    ///<summary>影响区域</summary>
    ///<summary>施法距离</summary>
    ///<summary>数据A</summary>
    ///<summary>数据B</summary>
    ///<summary>数据C</summary>
    ///<summary>数据D</summary>
    ///<summary>数据E</summary>
    ///<summary>数据F</summary>
    ///<summary>数据G</summary>
    ///<summary>数据H</summary>
    ///<summary>数据I</summary>
    ///<summary>单位类型</summary>
    ///<summary>热键</summary>
    ///<summary>关闭热键</summary>
    ///<summary>学习热键</summary>
    ///<summary>名字</summary>
    ///<summary>图标</summary>
    ///<summary>目标效果</summary>
    ///<summary>施法者效果</summary>
    ///<summary>目标点效果</summary>
    ///<summary>区域效果</summary>
    ///<summary>投射物</summary>
    ///<summary>特殊效果</summary>
    ///<summary>闪电效果</summary>
    ///<summary>buff提示</summary>
    ///<summary>buff提示</summary>
    ///<summary>学习提示</summary>
    ///<summary>提示</summary>
    ///<summary>关闭提示</summary>
    ///<summary>学习提示</summary>
    ///<summary>提示</summary>
    ///<summary>关闭提示</summary>
    
    //----------物品数据类型----------------------
    ///<summary>物品图标</summary>
    ///<summary>物品提示</summary>
    ///<summary>物品扩展提示</summary>
    ///<summary>物品名字</summary>
    ///<summary>物品说明</summary>
    //------------单位数据类型--------------
    ///<summary>攻击1 伤害骰子数量</summary>
    ///<summary>攻击1 伤害骰子面数</summary>
    ///<summary>攻击1 基础伤害</summary>
    ///<summary>攻击1 升级奖励</summary>
    ///<summary>攻击1 最小伤害</summary>
    ///<summary>攻击1 最大伤害</summary>
    ///<summary>攻击1 全伤害范围</summary>
    ///<summary>装甲</summary>
    // attack 1 attribute adds
    ///<summary>攻击1 伤害衰减参数</summary>
    ///<summary>攻击1 武器声音</summary>
    ///<summary>攻击1 攻击类型</summary>
    ///<summary>攻击1 最大目标数</summary>
    ///<summary>攻击1 攻击间隔</summary>
    ///<summary>攻击1 攻击延迟/summary>
    ///<summary>攻击1 弹射弧度</summary>
    ///<summary>攻击1 攻击距离缓冲</summary>
    ///<summary>攻击1 目标允许</summary>
    ///<summary>攻击1 溅出区域</summary>
    ///<summary>攻击1 溅出半径</summary>
    ///<summary>攻击1 武器类型</summary>
    // attack 2 attributes (sorted in a sequencial order based on memory address)
    ///<summary>攻击2 伤害骰子数量</summary>
    ///<summary>攻击2 伤害骰子面数</summary>
    ///<summary>攻击2 基础伤害</summary>
    ///<summary>攻击2 升级奖励</summary>
    ///<summary>攻击2 伤害衰减参数</summary>
    ///<summary>攻击2 武器声音</summary>
    ///<summary>攻击2 攻击类型</summary>
    ///<summary>攻击2 最大目标数</summary>
    ///<summary>攻击2 攻击间隔</summary>
    ///<summary>攻击2 攻击延迟</summary>
    ///<summary>攻击2 攻击距离</summary>
    ///<summary>攻击2 攻击缓冲</summary>
    ///<summary>攻击2 最小伤害</summary>
    ///<summary>攻击2 最大伤害</summary>
    ///<summary>攻击2 弹射弧度</summary>
    ///<summary>攻击2 目标允许类型</summary>
    ///<summary>攻击2 溅出区域</summary>
    ///<summary>攻击2 溅出半径</summary>
    ///<summary>攻击2 武器类型</summary>
    ///<summary>装甲类型</summary>
    
    
//===========================================================================
// Trigger: 新japi库
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0


//===========================================================================
// Trigger: 异步japi库
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0

//这个库里面的japi 是在本地玩家 异步的情况下运行的动作 ,不可在非异步的环境下运行
//数据需要同步之后再使用
//运行完之后 会自动同步 在触发响应之后做动作
// 本地消息的FLAG
// 这4个消息标志可以相加组合
//使用方法 本地坐标命令(命令id,坐标x轴,坐标y轴,FLAG_INSTANT + FLAG_ONLY) flag标签为   瞬发+独立
//===========================================================================
// Trigger: api
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
//hardware
//获取鼠标在游戏内的坐标X

//获取鼠标在游戏内的坐标Y

//获取鼠标在游戏内的坐标Z

//鼠标是否在游戏内

//获取鼠标屏幕坐标X

//获取鼠标屏幕坐标Y

//获取鼠标游戏窗口坐标X

//获取鼠标游戏窗口坐标Y

//设置鼠标位置

//注册鼠标点击触发（sync为true时，调用TriggerExecute。为false时，直接运行action函数，可以异步不掉线，action里不要有同步操作）


//注册键盘点击触发


//注册鼠标滚轮触发


//注册鼠标移动触发


//获取触发器的按键码

//获取滚轮delta

//判断按键是否按下

//获取触发key的玩家

//获取war3窗口宽度

//获取war3窗口高度

//获取war3窗口X坐标

//获取war3窗口Y坐标

//注册war3窗口大小变化事件


//判断窗口是否激活

//plus
//设置可摧毁物位置

//设置单位位置-本地调用

//异步执行函数

//取鼠标指向的unit

//设置unit的贴图

//设置内存数值

//设置单位ID

//设置单位模型

//设置小地图背景图片

//sync
//注册数据同步trigger

//同步游戏数据

//获取同步的数据

//获取同步数据的玩家

//gui
/////////////////////////////// 原生UI修改
//隐藏界面元素

//修改游戏世界窗口位置

//头像

//小地图

//技能按钮

//英雄按钮

//英雄血条

//英雄蓝条

//道具按钮

//小地图按钮

//左上菜单按钮

//鼠标提示

//聊天信息

//unit message

//top message

///////////////////////////////
//取rgba色值

//设置界面更新回调（非同步）


//显示/隐藏Frame

//创建frame

//创建SimpleFrame

//销毁frame

//加载toc

//设置frame相对位置

//设置frame绝对位置

//清空frame锚点

//设置frame禁用/启用

//注册UI事件回调


//获取触发ui的玩家

//获取触发的Frame

//查找frame

//查找SimpleFrame

//查找String

//查找Texture

//获取game ui

//点击frame

//自定义屏幕比例

//使用宽屏模式

//设置文字（支持EditBox, TextFrame, TextArea, SimpleFontString、GlueEditBoxWar3、SlashChatBox、TimerTextFrame、TextButtonFrame、GlueTextButton）

//获取文字（支持EditBox, TextFrame, TextArea, SimpleFontString）

//设置字数限制（支持EditBox）

//获取字数限制（支持EditBox）

//设置文字颜色（支持TextFrame, EditBox）

//获取鼠标所在位置的ui控件指针

//设置所有锚点到目标frame上

//设置焦点

//设置模型（支持Sprite、Model、StatusBar）

//获取控件是否启用

//设置透明度（0-255）

//获取透明度

//设置动画

//设置动画进度（autocast为false是可用）

//设置texture（支持Backdrop、SimpleStatusBar）

//设置缩放

//设置tooltip

//鼠标限制在ui内

//获取当前值（支持Slider、SimpleStatusBar、StatusBar）

//设置最大最小值（支持Slider、SimpleStatusBar、StatusBar）

//设置Step值（支持Slider）

//设置当前值（支持Slider、SimpleStatusBar、StatusBar）

//设置frame大小

//根据tag创建frame

//设置颜色（支持SimpleStatusBar）

//===========================================================================
// Trigger: get_name
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
// Trigger: lua
//===========================================================================
function Trig_luaFunc003MT takes nothing returns nothing
    call SetTeams(1)
endfunction
function Trig_luaFunc004MT takes nothing returns nothing
    call SetTeams(2)
endfunction
function Trig_luaFunc005MT takes nothing returns nothing
    call SetTeams(3)
endfunction
function Trig_luaFunc006MT takes nothing returns nothing
    call SetTeams(4)
endfunction
function Trig_luaFunc007MMT takes nothing returns nothing
    call SetTeams(5)
endfunction
function Trig_luaFunc008WT takes nothing returns nothing
    call SetTeams(6)
endfunction
function Trig_luaFunc010Func002KT takes nothing returns nothing
    call SetTeams(7)
endfunction
function Trig_luaFunc010Func003KT takes nothing returns nothing
    call SetTeams(8)
endfunction
function Trig_luaFunc011WRT takes nothing returns nothing
    call SetTeams(9)
endfunction
function Trig_luaActions takes nothing returns nothing
    local integer ydl_localvar_step= LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76)
 set ydl_localvar_step=ydl_localvar_step + 3
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76, ydl_localvar_step)
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xECE825E7, ydl_localvar_step)
    call AbilityId("exec-lua:main")
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterMouseEventByCode(null, 1, 1, false, function Trig_luaFunc003MT)
    endif
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterMouseEventByCode(null, 1, 0, false, function Trig_luaFunc004MT)
    endif
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterMouseEventByCode(null, 2, 1, false, function Trig_luaFunc005MT)
    endif
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterMouseEventByCode(null, 2, 0, false, function Trig_luaFunc006MT)
    endif
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterMouseMoveEventByCode(null, false, function Trig_luaFunc007MMT)
    endif
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterMouseWheelEventByCode(null, false, function Trig_luaFunc008WT)
    endif
    set bj_forLoopAIndex=0
    set bj_forLoopAIndexEnd=255
    loop
        exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
        set udg_i=bj_forLoopAIndex
        if GetLocalPlayer() == GetLocalPlayer() then
        	call DzTriggerRegisterKeyEventByCode(null, udg_i, 1, false, function Trig_luaFunc010Func002KT)
        endif
        if GetLocalPlayer() == GetLocalPlayer() then
        	call DzTriggerRegisterKeyEventByCode(null, udg_i, 0, false, function Trig_luaFunc010Func003KT)
        endif
        set bj_forLoopAIndex=bj_forLoopAIndex + 1
    endloop
    if GetLocalPlayer() == GetLocalPlayer() then
    	call DzTriggerRegisterWindowResizeEventByCode(null, false, function Trig_luaFunc011WRT)
    endif
    call FlushChildHashtable(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step)
endfunction
//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************
function CreateRegions takes nothing returns nothing
    local weathereffect we
    set gg_rct_cg1=Rect(15616.0, - 11904.0, 15904.0, - 11616.0)
    set gg_rct_cg2=Rect(17312.0, - 11744.0, 17536.0, - 11520.0)
    set gg_rct_cg3=Rect(19040.0, - 11840.0, 19296.0, - 11552.0)
    set gg_rct_cgboss4=Rect(17312.0, - 12064.0, 17536.0, - 11840.0)
    set gg_rct_jg1=Rect(17216.0, - 13216.0, 17664.0, - 12800.0)
    set gg_rct_jg2_jd=Rect(17152.0, - 16512.0, 17664.0, - 16096.0)
    set gg_rct_npc1=Rect(15968.0, - 16128.0, 16512.0, - 15744.0)
    set gg_rct_npc2=Rect(15968.0, - 16512.0, 16512.0, - 16128.0)
    set gg_rct_npc3=Rect(15968.0, - 16896.0, 16512.0, - 16512.0)
    set gg_rct_npc4=Rect(18304.0, - 16128.0, 18848.0, - 15744.0)
    set gg_rct_npc5=Rect(18304.0, - 16512.0, 18848.0, - 16128.0)
    set gg_rct_npc6=Rect(18304.0, - 16896.0, 18848.0, - 16512.0)
    set gg_rct_npc7=Rect(16640.0, - 17536.0, 17152.0, - 17024.0)
    set gg_rct_npc8=Rect(17152.0, - 17536.0, 17664.0, - 17024.0)
    set gg_rct_npc9=Rect(17664.0, - 17536.0, 18176.0, - 17024.0)
    set gg_rct_xrcs=Rect(18912.0, - 16896.0, 19328.0, - 16512.0)
    set gg_rct_F2cs=Rect(17152.0, - 16096.0, 17664.0, - 15712.0)
    set gg_rct_sjjh1=Rect(20992.0, - 15840.0, 21696.0, - 15424.0)
    set gg_rct_sjjh2=Rect(22464.0, - 15872.0, 23296.0, - 15168.0)
    set gg_rct_sjjh3=Rect(22528.0, - 17472.0, 23360.0, - 16800.0)
    set gg_rct_lgf11=Rect(20384.0, - 8992.0, 20672.0, - 8672.0)
    set gg_rct_lgf12=Rect(21408.0, - 8992.0, 21696.0, - 8672.0)
    set gg_rct_lgf13=Rect(20384.0, - 9728.0, 20672.0, - 9408.0)
    set gg_rct_lgf14=Rect(21408.0, - 9728.0, 21696.0, - 9408.0)
    set gg_rct_lgfsg1=Rect(20800.0, - 9408.0, 21248.0, - 8960.0)
    set gg_rct_lgf21=Rect(23072.0, - 8992.0, 23360.0, - 8672.0)
    set gg_rct_lgf22=Rect(24096.0, - 8992.0, 24384.0, - 8672.0)
    set gg_rct_lgf23=Rect(23072.0, - 9728.0, 23360.0, - 9408.0)
    set gg_rct_lgf24=Rect(24096.0, - 9728.0, 24384.0, - 9408.0)
    set gg_rct_lgfsg2=Rect(23488.0, - 9408.0, 23936.0, - 8960.0)
    set gg_rct_lgf31=Rect(20416.0, - 11168.0, 20704.0, - 10848.0)
    set gg_rct_lgf32=Rect(21440.0, - 11168.0, 21728.0, - 10848.0)
    set gg_rct_lgf33=Rect(20416.0, - 11904.0, 20704.0, - 11584.0)
    set gg_rct_lgf34=Rect(21440.0, - 11904.0, 21728.0, - 11584.0)
    set gg_rct_lgfsg3=Rect(20832.0, - 11584.0, 21280.0, - 11136.0)
    set gg_rct_lgf41=Rect(23072.0, - 11136.0, 23360.0, - 10816.0)
    set gg_rct_lgf42=Rect(24096.0, - 11136.0, 24384.0, - 10816.0)
    set gg_rct_lgf43=Rect(23072.0, - 11872.0, 23360.0, - 11552.0)
    set gg_rct_lgf44=Rect(24096.0, - 11872.0, 24384.0, - 11552.0)
    set gg_rct_lgfsg4=Rect(23488.0, - 11552.0, 23936.0, - 11104.0)
    set gg_rct_lgf51=Rect(20384.0, - 13344.0, 20672.0, - 13024.0)
    set gg_rct_lgf52=Rect(21408.0, - 13344.0, 21696.0, - 13024.0)
    set gg_rct_lgf53=Rect(20384.0, - 14080.0, 20672.0, - 13760.0)
    set gg_rct_lgf54=Rect(21408.0, - 14080.0, 21696.0, - 13760.0)
    set gg_rct_lgfsg5=Rect(20800.0, - 13760.0, 21248.0, - 13312.0)
    set gg_rct_lgf61=Rect(23040.0, - 13312.0, 23328.0, - 12992.0)
    set gg_rct_lgf62=Rect(24064.0, - 13312.0, 24352.0, - 12992.0)
    set gg_rct_lgf63=Rect(23040.0, - 14048.0, 23328.0, - 13728.0)
    set gg_rct_lgf64=Rect(24064.0, - 14048.0, 24352.0, - 13728.0)
    set gg_rct_lgfsg6=Rect(23456.0, - 13728.0, 23904.0, - 13280.0)
    set gg_rct_wuqi1=Rect(8000.0, - 6272.0, 8320.0, - 5920.0)
    set gg_rct_wuqi11=Rect(7040.0, - 6272.0, 7360.0, - 5920.0)
    set gg_rct_wuqi2=Rect(8000.0, - 4160.0, 8320.0, - 3808.0)
    set gg_rct_wuqi22=Rect(7040.0, - 4160.0, 7360.0, - 3808.0)
    set gg_rct_wuqi3=Rect(8064.0, - 2272.0, 8384.0, - 1920.0)
    set gg_rct_wuqi33=Rect(7104.0, - 2272.0, 7424.0, - 1920.0)
    set gg_rct_wuqi4=Rect(10944.0, - 2304.0, 11264.0, - 1952.0)
    set gg_rct_wuqi5=Rect(13248.0, - 2304.0, 13568.0, - 1952.0)
    set gg_rct_wuqi55=Rect(12288.0, - 2304.0, 12608.0, - 1952.0)
    set gg_rct_wuqi6=Rect(15456.0, - 2336.0, 15776.0, - 1984.0)
    set gg_rct_wuqi66=Rect(14496.0, - 2336.0, 14816.0, - 1984.0)
    set gg_rct_wuqi7=Rect(15456.0, - 416.0, 15776.0, - 64.0)
    set gg_rct_wuqi77=Rect(14496.0, - 416.0, 14816.0, - 64.0)
    set gg_rct_wuqi8=Rect(15424.0, 1664.0, 15744.0, 2016.0)
    set gg_rct_wuqi88=Rect(14464.0, 1664.0, 14784.0, 2016.0)
    set gg_rct_wuqi9=Rect(15424.0, 3456.0, 15744.0, 3808.0)
    set gg_rct_wuqi99=Rect(14464.0, 3456.0, 14784.0, 3808.0)
    set gg_rct_wuqi10=Rect(17728.0, - 2304.0, 18048.0, - 1952.0)
    set gg_rct_wuqi1010=Rect(16768.0, - 2304.0, 17088.0, - 1952.0)
    set gg_rct_jia1=Rect(17632.0, - 416.0, 17952.0, - 64.0)
    set gg_rct_jia11=Rect(16672.0, - 416.0, 16992.0, - 64.0)
    set gg_rct_jia2=Rect(17632.0, 1632.0, 17952.0, 1984.0)
    set gg_rct_jia22=Rect(16672.0, 1632.0, 16992.0, 1984.0)
    set gg_rct_jia3=Rect(17568.0, 3488.0, 17888.0, 3840.0)
    set gg_rct_jia33=Rect(16608.0, 3488.0, 16928.0, 3840.0)
    set gg_rct_jia4=Rect(17568.0, 5248.0, 17888.0, 5600.0)
    set gg_rct_jia44=Rect(16608.0, 5248.0, 16928.0, 5600.0)
    set gg_rct_jia5=Rect(20000.0, 5280.0, 20320.0, 5632.0)
    set gg_rct_jia55=Rect(19040.0, 5280.0, 19360.0, 5632.0)
    set gg_rct_jia6=Rect(19968.0, - 2368.0, 20288.0, - 2016.0)
    set gg_rct_jia66=Rect(19008.0, - 2368.0, 19328.0, - 2016.0)
    set gg_rct_jia7=Rect(19968.0, - 480.0, 20288.0, - 128.0)
    set gg_rct_jia77=Rect(19008.0, - 480.0, 19328.0, - 128.0)
    set gg_rct_jia8=Rect(19904.0, 1568.0, 20224.0, 1920.0)
    set gg_rct_jia88=Rect(18944.0, 1568.0, 19264.0, 1920.0)
    set gg_rct_jia9=Rect(19968.0, 3392.0, 20288.0, 3744.0)
    set gg_rct_jia99=Rect(19008.0, 3392.0, 19328.0, 3744.0)
    set gg_rct_jia10=Rect(22144.0, 3360.0, 22464.0, 3712.0)
    set gg_rct_jia1010=Rect(21184.0, 3360.0, 21504.0, 3712.0)
    set gg_rct_wuqi44=Rect(9984.0, - 2304.0, 10304.0, - 1952.0)
    set gg_rct_jn1=Rect(26080.0, - 17344.0, 26368.0, - 17120.0)
    set gg_rct_jn11=Rect(26112.0, - 16608.0, 26336.0, - 16384.0)
    set gg_rct_jn2=Rect(28512.0, - 17312.0, 28800.0, - 17088.0)
    set gg_rct_jn22=Rect(28544.0, - 16576.0, 28768.0, - 16352.0)
    set gg_rct_jn3=Rect(28544.0, - 14944.0, 28832.0, - 14720.0)
    set gg_rct_jn33=Rect(28576.0, - 14208.0, 28800.0, - 13984.0)
    set gg_rct_jn4=Rect(26016.0, - 14976.0, 26304.0, - 14752.0)
    set gg_rct_jn44=Rect(26048.0, - 14240.0, 26272.0, - 14016.0)
    set gg_rct_xls4=Rect(12672.0, 4768.0, 12928.0, 4960.0)
    set gg_rct_xls44=Rect(12672.0, 5632.0, 12928.0, 5856.0)
    set gg_rct_jj11=Rect(12992.0, - 11168.0, 13312.0, - 10816.0)
    set gg_rct_jj1=Rect(12992.0, - 12032.0, 13312.0, - 11712.0)
    set gg_rct_jj22=Rect(13024.0, - 13728.0, 13344.0, - 13376.0)
    set gg_rct_jj2=Rect(13024.0, - 14592.0, 13344.0, - 14272.0)
    set gg_rct_jj33=Rect(12640.0, - 16576.0, 12960.0, - 16224.0)
    set gg_rct_jj3=Rect(13344.0, - 16768.0, 13664.0, - 16448.0)
    set gg_rct_jj44=Rect(10016.0, - 11168.0, 10336.0, - 10816.0)
    set gg_rct_jj4=Rect(10016.0, - 12032.0, 10336.0, - 11712.0)
    set gg_rct_jj55=Rect(10048.0, - 13664.0, 10368.0, - 13312.0)
    set gg_rct_jj5=Rect(10048.0, - 14528.0, 10368.0, - 14208.0)
    set gg_rct_jj66=Rect(10048.0, - 16416.0, 10368.0, - 16064.0)
    set gg_rct_jj6=Rect(10048.0, - 17280.0, 10368.0, - 16960.0)
    set gg_rct_jj77=Rect(7232.0, - 16416.0, 7552.0, - 16064.0)
    set gg_rct_jj7=Rect(7232.0, - 17280.0, 7552.0, - 16960.0)
    set gg_rct_jj88=Rect(7232.0, - 13696.0, 7552.0, - 13344.0)
    set gg_rct_jj8=Rect(7232.0, - 14560.0, 7552.0, - 14240.0)
    set gg_rct_jj99=Rect(7264.0, - 11104.0, 7584.0, - 10752.0)
    set gg_rct_jj9=Rect(7264.0, - 11968.0, 7584.0, - 11648.0)
    set gg_rct_jj1010=Rect(7264.0, - 8448.0, 7584.0, - 8096.0)
    set gg_rct_jj10=Rect(7264.0, - 9312.0, 7584.0, - 8992.0)
    set gg_rct_lgfbh1=Rect(19968.0, - 9952.0, 22080.0, - 8128.0)
    set gg_rct_lgfbh2=Rect(22720.0, - 9952.0, 24832.0, - 8128.0)
    set gg_rct_lgfbh3=Rect(20000.0, - 12128.0, 22112.0, - 10304.0)
    set gg_rct_lgfbh4=Rect(22688.0, - 12096.0, 24800.0, - 10272.0)
    set gg_rct_lgfbh6=Rect(22624.0, - 14368.0, 24736.0, - 12544.0)
    set gg_rct_lgfbh5=Rect(19968.0, - 14336.0, 22080.0, - 12512.0)
    set gg_rct_emo11=Rect(16736.0, - 9440.0, 17088.0, - 9120.0)
    set gg_rct_emo44=Rect(16832.0, - 7552.0, 17184.0, - 7232.0)
    set gg_rct_emo33=Rect(18976.0, - 7328.0, 19328.0, - 7008.0)
    set gg_rct_emo22=Rect(18912.0, - 9408.0, 19264.0, - 9088.0)
    set gg_rct_emo4=Rect(16064.0, - 7552.0, 16416.0, - 7232.0)
    set gg_rct_emo3=Rect(18208.0, - 7360.0, 18560.0, - 7040.0)
    set gg_rct_emo2=Rect(18304.0, - 9376.0, 18656.0, - 9056.0)
    set gg_rct_emo1=Rect(16064.0, - 9472.0, 16416.0, - 9152.0)
    set gg_rct_xuanren=Rect(8224.0, - 512.0, 9600.0, 448.0)
    set gg_rct_xls3=Rect(12736.0, 2944.0, 12992.0, 3136.0)
    set gg_rct_xls33=Rect(12736.0, 3808.0, 12992.0, 4032.0)
    set gg_rct_xls2=Rect(12736.0, 1152.0, 12992.0, 1344.0)
    set gg_rct_xls22=Rect(12736.0, 2016.0, 12992.0, 2240.0)
    set gg_rct_xls1=Rect(12736.0, - 896.0, 12992.0, - 704.0)
    set gg_rct_xls11=Rect(12736.0, - 32.0, 12992.0, 192.0)
    set gg_rct_xxzh11=Rect(21888.0, - 6400.0, 22752.0, - 5888.0)
    set gg_rct_xxzh12=Rect(23808.0, - 6400.0, 24672.0, - 5888.0)
    set gg_rct_xxzh13=Rect(23808.0, - 4832.0, 24672.0, - 4320.0)
    set gg_rct_xxzh14=Rect(21888.0, - 4896.0, 22752.0, - 4384.0)
    set gg_rct_ylxy11=Rect(25856.0, - 6400.0, 26720.0, - 5888.0)
    set gg_rct_ylxy12=Rect(27776.0, - 6400.0, 28640.0, - 5888.0)
    set gg_rct_ylxy13=Rect(27776.0, - 4832.0, 28640.0, - 4320.0)
    set gg_rct_ylxy14=Rect(25856.0, - 4896.0, 26720.0, - 4384.0)
    set gg_rct_sqyyh11=Rect(25888.0, - 1120.0, 26752.0, - 608.0)
    set gg_rct_sqyyh12=Rect(27808.0, - 1120.0, 28672.0, - 608.0)
    set gg_rct_sqyyh13=Rect(27808.0, 448.0, 28672.0, 960.0)
    set gg_rct_sqyyh14=Rect(25888.0, 384.0, 26752.0, 896.0)
    set gg_rct_xwty11=Rect(21920.0, - 1120.0, 22784.0, - 608.0)
    set gg_rct_xwty12=Rect(23840.0, - 1120.0, 24704.0, - 608.0)
    set gg_rct_xwty13=Rect(23840.0, 448.0, 24704.0, 960.0)
    set gg_rct_xwty14=Rect(21920.0, 384.0, 22784.0, 896.0)
    set gg_rct_xwty111=Rect(23040.0, 1376.0, 23552.0, 1728.0)
    set gg_rct_sqyyh111=Rect(27008.0, 1376.0, 27520.0, 1728.0)
    set gg_rct_ylxy111=Rect(27008.0, - 3872.0, 27520.0, - 3520.0)
    set gg_rct_xxzh111=Rect(23040.0, - 3872.0, 23552.0, - 3520.0)
    set gg_rct_xxzh1=Rect(23104.0, - 7072.0, 23584.0, - 6752.0)
    set gg_rct_ylxy1=Rect(27072.0, - 7072.0, 27552.0, - 6752.0)
    set gg_rct_sqyyh1=Rect(27072.0, - 1792.0, 27552.0, - 1472.0)
    set gg_rct_xwty1=Rect(23072.0, - 1792.0, 23552.0, - 1472.0)
    set gg_rct_fdm1=Rect(26016.0, - 12768.0, 26304.0, - 12544.0)
    set gg_rct_fdm11=Rect(26048.0, - 12032.0, 26272.0, - 11808.0)
    set gg_rct_ttxd11=Rect(24288.0, 3488.0, 24544.0, 3776.0)
    set gg_rct_ttxd1=Rect(23488.0, 3520.0, 23744.0, 3808.0)
    set gg_rct_cbt1=Rect(10464.0, - 8832.0, 10752.0, - 8608.0)
    set gg_rct_cbt111=Rect(10368.0, - 7776.0, 10848.0, - 7136.0)
    set gg_rct_cbt11=Rect(9408.0, - 9088.0, 9888.0, - 8544.0)
    set gg_rct_cbt12=Rect(11360.0, - 9088.0, 11840.0, - 8544.0)
    set gg_rct_cbt2=Rect(15872.0, - 17888.0, 19360.0, - 15008.0)
    set gg_rct_sd1=Rect(28512.0, - 12672.0, 28800.0, - 12448.0)
    set gg_rct_sd11=Rect(28544.0, - 11936.0, 28768.0, - 11712.0)
    set gg_rct_jia1111=Rect(22112.0, 5216.0, 22368.0, 5504.0)
    set gg_rct_jia111=Rect(21312.0, 5248.0, 21568.0, 5536.0)
    set gg_rct_wldh=Rect(6912.0, 2880.0, 9568.0, 5280.0)
    set gg_rct_wuqi1111=Rect(24160.0, 5216.0, 24416.0, 5504.0)
    set gg_rct_wuqi111=Rect(23360.0, 5248.0, 23616.0, 5536.0)
    set gg_rct_nainiu1=Rect(10464.0, - 5504.0, 10752.0, - 5280.0)
    set gg_rct_nainiu11=Rect(10368.0, - 4448.0, 10848.0, - 3808.0)
    set gg_rct_nainiu12=Rect(9408.0, - 5760.0, 9888.0, - 5216.0)
    set gg_rct_nainiu13=Rect(11360.0, - 5760.0, 11840.0, - 5216.0)
    set gg_rct_hdsz=Rect(18912.0, - 17536.0, 19424.0, - 17024.0)
    set gg_rct_tsgd1=Rect(19072.0, - 5248.0, 19360.0, - 5024.0)
    set gg_rct_tsgd11=Rect(19072.0, - 4416.0, 19296.0, - 4192.0)
    set gg_rct_npc10=Rect(15552.0, - 15552.0, 15808.0, - 15328.0)
    set gg_rct_tsgd22=Rect(19776.0, - 5440.0, 20000.0, - 5216.0)
    set gg_rct_tsgd33=Rect(18400.0, - 5440.0, 18624.0, - 5216.0)
    set gg_rct_jing=Rect(21056.0, - 17632.0, 21696.0, - 17056.0)
    set gg_rct_cyjx=Rect(18912.0, - 15616.0, 19424.0, - 15104.0)
    set gg_rct_tssx11=Rect(26336.0, 5184.0, 26592.0, 5472.0)
    set gg_rct_tssx1=Rect(25536.0, 5216.0, 25792.0, 5504.0)
    set gg_rct_tssx22=Rect(28576.0, 5184.0, 28832.0, 5472.0)
    set gg_rct_tssx2=Rect(27776.0, 5216.0, 28032.0, 5504.0)
    set gg_rct_tssx33=Rect(26336.0, 3392.0, 26592.0, 3680.0)
    set gg_rct_tssx3=Rect(25536.0, 3424.0, 25792.0, 3712.0)
    set gg_rct_tssx44=Rect(28576.0, 3392.0, 28832.0, 3680.0)
    set gg_rct_tssx4=Rect(27776.0, 3424.0, 28032.0, 3712.0)
    set gg_rct_tsjx5=Rect(25952.0, - 10272.0, 26240.0, - 10048.0)
    set gg_rct_tsjx55=Rect(25984.0, - 9536.0, 26208.0, - 9312.0)
    set gg_rct_tsjx6=Rect(28448.0, - 10208.0, 28736.0, - 9984.0)
    set gg_rct_tsjx66=Rect(28480.0, - 9472.0, 28704.0, - 9248.0)
    set gg_rct_tsjx7=Rect(13216.0, - 4256.0, 13536.0, - 3904.0)
    set gg_rct_tsjx77=Rect(12256.0, - 4256.0, 12576.0, - 3904.0)
    set gg_rct_tsjx8=Rect(14848.0, 4768.0, 15104.0, 4960.0)
    set gg_rct_tsjx88=Rect(14848.0, 5632.0, 15104.0, 5856.0)
    set gg_rct_bncf1=Rect(7776.0, 4320.0, 7872.0, 4416.0)
    set gg_rct_bncf2=Rect(7776.0, 4032.0, 7872.0, 4128.0)
    set gg_rct_bncf8=Rect(8064.0, 4320.0, 8160.0, 4416.0)
    set gg_rct_bncf7=Rect(8352.0, 4320.0, 8448.0, 4416.0)
    set gg_rct_bncf3=Rect(7776.0, 3744.0, 7872.0, 3840.0)
    set gg_rct_bncf9=Rect(8064.0, 4032.0, 8160.0, 4128.0)
    set gg_rct_bncf4=Rect(8064.0, 3744.0, 8160.0, 3840.0)
    set gg_rct_bncf6=Rect(8352.0, 4032.0, 8448.0, 4128.0)
    set gg_rct_bncf5=Rect(8352.0, 3744.0, 8448.0, 3840.0)
    set gg_rct_wjhy1 = Rect( 15168.0, -5216.0, 15456.0, -4992.0 )
    set gg_rct_wjhy11 = Rect( 15168.0, -4384.0, 15392.0, -4160.0 )
    set gg_rct_wjhy22 = Rect( 15872.0, -5408.0, 16096.0, -5184.0 )
    set gg_rct_wjhy33 = Rect( 14496.0, -5408.0, 14720.0, -5184.0 )
endfunction

//===========================================================================
function InitTrig_lua takes nothing returns nothing
    set gg_trg_lua=CreateTrigger()
    call DoNothing()
    call TriggerAddAction(gg_trg_lua, function Trig_luaActions)
call func_bind_trigger_name(function Trig_luaActions , "lua")

endfunction
//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_japi_________u()
    //Function not found: call InitTrig____japi___u()
    //Function not found: call InitTrig_______japi___u()
    //Function not found: call InitTrig_api()
    //Function not found: call InitTrig_get_name()
    call InitTrig_lua()
endfunction
//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_lua)
endfunction
//***************************************************************************
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)
    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)
    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)
    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_USER)
    // Player 10
    call SetPlayerStartLocation(Player(10), 6)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
    // Player 11
    call SetPlayerStartLocation(Player(11), 7)
    call SetPlayerColor(Player(11), ConvertPlayerColor(11))
    call SetPlayerRacePreference(Player(11), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(11), false)
    call SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_009
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(10), 0)
    call SetPlayerState(Player(10), PLAYER_STATE_ALLIED_VICTORY, 1)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    // Force: TRIGSTR_010
    call SetPlayerTeam(Player(11), 1)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 4)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(0, 2, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(0, 3, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrioCount(1, 2)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(1, 1, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(2, 1)
    call SetStartLocPrio(2, 0, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(3, 1)
    call SetStartLocPrio(3, 0, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(4, 1)
    call SetStartLocPrio(4, 0, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(5, 1)
    call SetStartLocPrio(5, 0, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(6, 2)
    call SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(7, 2)
    call SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 1, 2, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call JapiConstantLib_init()
    call initializePlugin()
    call SetCameraBounds(5888.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 17920.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 29952.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 6144.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 5888.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 6144.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 29952.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 17920.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateRegions()
    call InitBlizzard()

call ExecuteFunc("Mtpplayername__initgetname")
call ExecuteFunc("YDTriggerSaveLoadSystem__Init")

    set udg_i=0 // INLINED!!
    call InitTrig_lua() // INLINED!!
    call ConditionalTriggerExecute(gg_trg_lua) // INLINED!!
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("只是另外一张魔兽争霸的地图")
    call SetMapDescription("没有说明")
    call SetPlayers(12)
    call SetTeams(12)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 0.0, 0.0)
    call DefineStartLocation(1, 0.0, 0.0)
    call DefineStartLocation(2, 0.0, 0.0)
    call DefineStartLocation(3, 0.0, 0.0)
    call DefineStartLocation(4, 0.0, 0.0)
    call DefineStartLocation(5, 0.0, 0.0)
    call DefineStartLocation(6, 0.0, 0.0)
    call DefineStartLocation(7, 0.0, 0.0)
    call DefineStartLocation(8, 0.0, 0.0)
    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

