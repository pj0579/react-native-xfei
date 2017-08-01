react-native-xfei
====   
use for android and ios <br/>
Android manually configure(you change the xunfei id，need to use your iflyMSC.sdk）<br/>

Installation Android
-------
1.android/setting.pradle<br/>
`add include ':react-native-xfei'
project(':react-native-xfei').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-xfei/android')`

2.android/app/build.gradle  <br/>
 `add dependencies {   compile project(':react-native-xfei')`

3.mainActivity add <br/>
` ``
@Override protected void onCreate(Bundle savedInstanceState) {   super.onCreate(savedInstanceState);     SpeechUtility.
` ``
createUtility(this, SpeechConstant.APPID +"=58c77ca8");mainApplication add new XfeiPackage()}
` ``

4.move react-native-xfei to node_modules <br/>

5.js<br/>  
`import Xfei from “xxxxx/node_mudles/react-native-Xfei”`

start<br/>  
`Xfei.setParameter("60000", "zh_cn", "10000", "10000", "mandarin", "iat");//setParameter
Xfei.startRecord((msg) => {       alert(msg);//sucess   },   (mag) => {        alert(mag);   });`<br/>
end <br/>
`Xfei.stopRecord()`


IOS
-----------
iOS setting(you change the xunfei id，need to use your iflyMSC.Framework)

1.add two static libraries <br/>
`TARGETS -Build Phases -Link binary With Libraries 
add Contacts.framework ,AddressBook.framework`

2.TARGETS -Build Setting -Header Search Paths  <br/>
`add $(SRCROOT)/../node_modules/react-native-xfei/ios`

3.AppDelegate.m <br/>
`add #import "RCTXfei.h"` <br/>
```
(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions<br/>
{<br/>
…<br/>
[RCTXfei crateMyUtility:@"58c90a6b"];<br/>
…
}
```
<br/>
4.Libraries  add <br/>
`RCTXfei.xcodeproj` <br/>
5.TARGETS -Build Phases -Link binary With Libraries<br/>

`add RCTXfei.a `<br/>

6.js same as Android <br/>
`different Xfei.startRecord((res, isSucess) => {   if(isSucess){      alert(res);   }else{       alert("error");   }})`






