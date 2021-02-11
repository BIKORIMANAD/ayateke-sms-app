
class Services{
    static const String appName = "Ayateke Star ";
    static const String powered = "Powered by Iwawe Technology ©";
    static const bool debugMode = true;
    static const String env = "local";
    static const String local_url = "http://192.168.43.70:8000/api/v1";
    static const String production_url = "https://sms.ascms.rw/api/v1";

    static const String url = env == "local"?local_url:production_url;
    static bool requestedChanged = false;

    static void setRequestedChanged(bool requestedChanged){
      Services.requestedChanged = requestedChanged;
    }
    static bool getRequestedChanged(){
      return Services.requestedChanged;
    }
    static String greeting() {
        var hour = DateTime.now().hour;
        if (hour < 12) {
            return 'Good Morning';
        }
        if (hour < 17) {
            return 'Good Afternoon';
        }
        return 'Good Evening';
    }

}