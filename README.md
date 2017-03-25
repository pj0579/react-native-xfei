# react-native-xfei
讯飞RN组件
Android manually configure(you change the xunfei id，need to use your iflyMSC.sdk）

1.android/setting.pradle     add include ':react-native-xfei'
project(':react-native-xfei').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-xfei/android')

2.android/app/build.gradle   add dependencies {   compile project(':react-native-xfei')

3.mainActivity add
@Override protected void onCreate(Bundle savedInstanceState) {   super.onCreate(savedInstanceState);     SpeechUtility.createUtility(this, SpeechConstant.APPID +"=58c77ca8");

mainApplication add new XfeiPackage()}

4.react-native-xfei to node_modules

5.js  import Xfei from “xxxxx/node_mudles/react-native-Xfei”
start
Xfei.setParameter("60000", "zh_cn", "10000", "10000", "mandarin", "iat");//setParameter
Xfei.startRecord((msg) => {       alert(msg);//sucess   },   (mag) => {        alert(mag);   });
end
Xfei.stopRecord()


IOS
iOS setting(you change the xunfei id，need to use your iflyMSC.Framework)

1.add two static libraries
TARGETS -Build Phases -Link binary With Libraries 
add 
Contacts.framework
AddressBook.framework

2.TARGETS -Build Setting -Header Search Paths
add $(SRCROOT)/../node_modules/react-native-xfei/ios

3.
AppDelegate.m
add #import "RCTXfei.h"
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
…
[RCTXfei crateMyUtility:@"58c90a6b"];
…
}
4.Libraries中 add
RCTXfei.xcodeproj   

5.TARGETS -Build Phases -Link binary With Libraries
add RCTXfei.a
6.js same as Android
different
Xfei.startRecord((res, isSucess) => {   if(isSucess){      alert(res);   }else{       alert("error");   }});





