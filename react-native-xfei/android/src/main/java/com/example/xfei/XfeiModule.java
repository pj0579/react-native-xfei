package com.example.xfei;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.iflytek.cloud.SpeechConstant;
import com.iflytek.cloud.SpeechRecognizer;

/**
 * Created by xukankan on 17/3/14.
 */

public class XfeiModule extends ReactContextBaseJavaModule {

    static private String name = "XfeiModule";
    private SpeechRecognizer speechRecognizer;
    static public String result=null;
    public XfeiModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "XfeiModule";
    }


    @ReactMethod
    public void startRecord(Callback successCallback,Callback errorCallback) {
        // 开始听写
        speechRecognizer.startListening(MyRecognizerListener.createRecognizerListener(successCallback,errorCallback));
    }

    @ReactMethod
    public void stopRecord() {
        //停止听写
        speechRecognizer.stopListening();
    }

    @ReactMethod
    public void setParameter(String timeout, String langage, String vad_Bos, String vad_Eos, String accent, String domain) {
        //设置参数
        speechRecognizer = SpeechRecognizer.createRecognizer(getReactApplicationContext(), null);
        speechRecognizer.setParameter(SpeechConstant.DOMAIN, domain);// 短信和日常用语： iat (默认)
        speechRecognizer.setParameter(SpeechConstant.LANGUAGE, langage);// 设置中文
        speechRecognizer.setParameter(SpeechConstant.ACCENT, accent);// 设置普通话
        speechRecognizer.setParameter(SpeechConstant.KEY_SPEECH_TIMEOUT, timeout);//语音输入超时时间
        speechRecognizer.setParameter(SpeechConstant.VAD_BOS, vad_Bos);
        speechRecognizer.setParameter(SpeechConstant.VAD_EOS, vad_Eos);
    }


}
