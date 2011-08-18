Force.com Streaming Pilot demo in Node!
====================================

Before you attempt to try this thing, make sure you have a PushTopic created in your org according to the official docs.  Once your server is up and running, create an object in your org using the API or whatever you want.

Usage
------

1. git clone this thing
2. Install dependencies: express, connect, oauth. 
3. Build Faye from my fork, which includes HTTPS, Cookies, and a small workaround for a bug in the pilot: cd node_modules && git clone git@github.com:aashay/faye.git  (See also: [https://github.com/aashay/faye](https://github.com/aashay/faye)
4. cd faye
5. Build faye according to the readme instructions (starting with "git submodule update --init --recursive"). You don't need to run tests but it's probably a good idea! :)
6. Make sure to run jake as part of the process.  This will output the required files into the /build folder which is where our server.js will look for its faye files.
7. Make sure your app is properly configured in your org.  Setup > Develop > Remote Access  (I use localhost:4567/oauth/yay as my callback url).
8. Create a file called config.js at the root of your app (same place as server.js) and make it look like the following:
<pre>
    
    exports.PORT = parseInt(process.env.PORT) || 4567; 
    exports.cookieMaxAge = 3600000; //length of idle session in ms
    exports.sessionSecret = process.env.SESSION_SECRET || "someSessionSecret";


    //Salesforce stuff.    
    //Put your Client ID and Secret and Login here:
    exports.CLIENT_ID = process.env.CLIENT_ID || 'yourClientId';
    exports.CLIENT_SECRET = process.env.CLIENT_SECRET || 'superSecret';

    exports.LOGIN = "you@yourorg.com";
    exports.PUSH_TOPIC = 'TestTopic';
</pre>
9. node server.js 

10. Open up your browser at [http://localhost:4567](http://localhost:4567).  When your browser tells you to check the console, go watch the fun!