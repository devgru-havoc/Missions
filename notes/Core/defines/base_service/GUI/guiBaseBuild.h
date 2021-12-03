#define true 1
#define false 0

class RscBaseObject
{
    idd= 30000;
    movingEnable = false;
    enableSimulation = true;
    fadein=0;
    duration = 1e+011;
    fadeout=0;
    onLoad= "";

    controlsBackground[]=
    {
        RscBackScreen,
        RscBackFrame,
        RscBackTree,
        RscBackModel,
        RscBackPlrInfo,
        RscBackObjInfo

    };
    controls[]=
    {
        RscObjTree,
        RscPlayerInfo,
        RscObjInfo,
        RscBtnCancel,
        RscBtnConfirm
    };
    objects[]=
    {
        RscObjPreview
    };

    class RscBackScreen: IGUIBack
    {
        idc = -1;
        x = 0 * safezoneW + safezoneX;
        y = 0 * safezoneH + safezoneY;
        w = 1 * safezoneW;
        h = 1 * safezoneH;
        colorBackground[] = {0,0,0,0.6};
    };
    class RscBackFrame: IGUIBack
    {
        idc = -1;
        x = 0.095 * safezoneW + safezoneX;
        y = 0.09 * safezoneH + safezoneY;
        w = 0.81 * safezoneW;
        h = 0.82 * safezoneH;
        colorBackground[] = {0.4,0.4,0.4,1};
    };
    class RscBackTree: IGUIBack
    {
        idc = -1;
        x = 0.10 * safezoneW + safezoneX;
        y = 0.10 * safezoneH + safezoneY;
        w = 0.2 * safezoneW;
        h = 0.8 * safezoneH;
        colorBackground[] = {0,0,0,0.7};
    };
    class RscBackModel: IGUIBack
    {
        idc = -1;
        x = 0.305 * safezoneW + safezoneX;
        y = 0.10 * safezoneH + safezoneY;
        w = 0.595 * safezoneW;
        h = 0.65 * safezoneH;
        colorBackground[] = {0,0,0,0.7};
    };
    class RscBackPlrInfo: IGUIBack
    {
        idc = -1;
        x = 0.305 * safezoneW + safezoneX;
        y = 0.76 * safezoneH + safezoneY;
        w = 0.25 * safezoneW;
        h = 0.14 * safezoneH;
        colorBackground[] = {0,0,0,0.7};
    };
    class RscBackObjInfo: IGUIBack
    {
        idc = -1;
        x = 0.56* safezoneW + safezoneX;
        y = 0.76 * safezoneH + safezoneY;
        w = 0.25 * safezoneW;
        h = 0.14 * safezoneH;
        colorBackground[] = {0,0,0,0.7};
    };
    class RscObjTree : RscTree
    {
        idc = 30001;
        x = 0.095 * safezoneW + safezoneX;
        y = 0.11 * safezoneH + safezoneY;
        w = 0.2 * safezoneW;
        h = 0.79 * safezoneH;
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25)";
        colorText[] = {1,1,1,1.0};
        colorSelect[] = {1,1,1,0.7};
        colorSelectText[] = {0,0,0,1};
        colorBackground[] = {0,0,0,0};
        colorSelectBackground[] = {0,0,0,0.5};
        colorBorder[] = {0,0,0,0};
        colorPicture[] = {1,1,1,1};
        colorPictureSelected[] = {1,1,1,1};
        colorPictureDisabled[] = {1,1,1,1};
        colorPictureRight[] = {1,1,1,1};
        colorPictureRightDisabled[] = {1,1,1,0.25};
        colorPictureRightSelected[] = {0,0,0,1};
        colorDisabled[] = {1,1,1,0.25};
        borderSize = 0;
        expandOnDoubleclick = 1;
        maxHistoryDelay = 1;
        colorArrow[] = {0,0,0,0};
        colorMarked[] = {1,0.5,0,0.5};
        colorMarkedText[] = {1,1,1,1};
        colorMarkedSelected[] = {1,0.5,0,1};
        onTreeSelChanged = " _this spawn MMF_fnc_ObjSel;";
        onTreeLButtonDown = "";
        onTreeDblClick = "";
        onTreeExpanded = "";
        onTreeCollapsed = "";
        onTreeMouseMove = "";
        onTreeMouseHold = "";
        onTreeMouseExit = "";
        class ScrollBar: RscTreeScrollBar{};
    };
    class RscObjPreview :  RscObject
    {
        onLoad= "(_this select 0) ctrlShow false;";
        idc = 30002;
        type = 81;
        enableZoom = 1;
        model = "\A3\Structures_F_Heli\Items\Airport\PortableHelipadLight_01_F.p3d";
        scale = 1;
        x = 0.6025 * safezoneW + safezoneX;
        y = 0.425 * safezoneH + safezoneY;
        z = 40;
        direction[] = {0.25,0,0};
        up[] = {0,1,0};
        tooltip = "";
        tooltipColorShade[] = {0,0,0,1};
        tooltipColorText[] = {1,1,1,1};
        tooltipColorBox[] = {1,1,1,1};
        onMouseMoving = "";
        onMouseHolding = "";
        onMouseDown = "";
    };
    class RscPlayerInfo: RscStructuredText
    {
        idc = 30003;
        colorText[] = {1,1,1,1};
        colorBackground[] = {0,0,0,0};
        class Attributes
        {
            font = "RobotoCondensed";
            color = "#ffffff";
            align = "left";
            shadow = 1;
        };

        size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25)";
        x = 0.3 * safezoneW + safezoneX;
        y = 0.77 * safezoneH + safezoneY;
        w = 0.25 * safezoneW;
        h = 0.14 * safezoneH;
        text = "";
    };
    class RscObjInfo: RscStructuredText
    {
        idc = 30004;
        colorText[] = {1,1,1,1};
        colorBackground[] = {0,0,0,0};
        class Attributes
        {
            font = "RobotoCondensed";
            color = "#ffffff";
            align = "left";
            shadow = 1;
        };
        size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25)";
        x = 0.555 * safezoneW + safezoneX;
        y = 0.77 * safezoneH + safezoneY;
        w = 0.25 * safezoneW;
        h = 0.14 * safezoneH;
        text = "";
    };
    class RscBtnCancel: RscShortcutButton
    {
        idc = 30005;
        text = "Cancel";
        colorBackground[] = {0,0,0,0.7};
        colorBackground2[] = {0,0,0,0.7};
        colorBackgroundFocused[] = {0,0,0,0.7};
        colorFocused[] = {1,1,1,1};
        onButtonClick  = "closeDialog 2;";
        x = 0.815 * safezoneW + safezoneX;
        y = 0.76 * safezoneH + safezoneY;
        w = 0.085 * safezoneW;
        h = 0.065 * safezoneH;
        size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25)";
            class TextPos
        {
            left = 0;
            top = 0.02;
            right = 0;
            bottom = 0;
        };
    };
    class RscBtnConfirm: RscShortcutButton
    {
        idc = 30006;
        text = "Confirm";
        colorBackground[] = {0,0,0,0.7};
        colorBackground2[] = {0,0,0,0.7};
        colorBackgroundFocused[] = {0,0,0,0.7};
        colorFocused[] = {1,1,1,1};
       	onButtonClick  = "[player] spawn MMF_fnc_SpawnItem;";
        x = 0.815 * safezoneW + safezoneX;
        y = 0.835 * safezoneH + safezoneY;
        w = 0.085 * safezoneW;
        h = 0.065 * safezoneH;
        size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25)";
            class TextPos
        {
            left = 0;
            top = 0.02;
            right = 0;
            bottom = 0;
        };
    };
};