Faye.Transport.NodeHttps = Faye.extend(Faye.Class(Faye.Transport, {
  request: function(message, timeout) {        
    var uri      = url.parse(this._endpoint),
        secure   = (uri.protocol === 'https:'),
        port     = (secure ? 443 : 80),
        //client   = http.createClient(uri.port || port, uri.hostname, secure),
        content  = JSON.stringify(message),
        response = null,
        retry    = this.retry(message, timeout),
        self     = this;
    //client.addListener('error', retry);
    //client.addListener('error', function(error){ console.log("FUCKING CHRIST: " + error)});
    // client.addListener('end', function() {
    //       if (!response) retry();
    //     });    
    
    var sid = "sid="+ message[0].ext.auth;
    var options = {
      host: uri.hostname,
      port: (secure ? 443 : 80),
      method: 'POST',
      path: '/cometd',  //TODO PARSE THIS PATH
      headers:{
        'Content-Type':   'application/json',
        'Host':           uri.hostname,
        'Content-Length': content.length,
        'Cookie': sid  //TODO AASHAY
      }
    };
        
    var request = https.request(options);
    
    request.on('error', retry);
    
    request.on('error', function(error){
        console.log("REQUEST ERROR: " + error);
    });
    
    request.on('response', function(stream) {
      response = stream;
      Faye.withDataFor(response, function(data) {
        try {
          self.receive(JSON.parse(data));
        } catch (e) {
          retry();
        }
      });
    });
    
    request.write(content);
    request.end();
    
    
  }
}), {
  isUsable: function(endpoint, callback, scope) {
    callback.call(scope, typeof endpoint === 'string');
  }
});

Faye.Transport.register('long-polling', Faye.Transport.NodeHttp);