class Notification
{
  idd= 55000;
  duration = 5;
  onLoad= "uiNamespace setVariable ['MMF_Notification', _this #0]";

    controls[]=
    {
        MyNotification
    };

    class MyNotification: RscStructuredText
    {
      	idc = 1;
        w = SafeZoneW * 10;
        h = SafeZoneH * 10;
    };
};
