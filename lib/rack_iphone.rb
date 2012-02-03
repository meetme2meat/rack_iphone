module Rack
 class Iphone
    CODE = %{
      <script type="text/javascript">
      (function(){
        var RESEND_REQUEST = {{RESEND}};

        function isFullScreen(){
          return navigator.userAgent.match(/WebKit.*Mobile/) &&
                 !navigator.userAgent.match(/Safari/);
        }

        if(isFullScreen()){
          
          if(!document.cookie.match(/{{REGEX}}/)){
            var storedValues = localStorage.getItem('__cookie__');
              if(storedValues){
                var values = storedValues.split(';');
                for(var i=0; i < values.length; i++)
                  document.cookie = values[i];
              }
              document.cookie = '_cookieset_=1';
            
            if(RESEND_REQUEST){
              window.location.reload();
            }
            
          }  
        }
      })()
      </script>
    }
    COOKIE = %{
         <script type="text/javascript"> 
            (function(){
               var COOKIE = "{{COOKIE}}";
	       var lastCookie = null;
               setInterval(function(){
               if(lastCookie != ''+COOKIE){
                 lastCookie = ''+COOKIE;
                 localStorage.setItem('__cookie__', ''+COOKIE);
                }
              },1000);
             })()
       </script>
     }
    
    def initialize(app)
      @app = app
    end
    
    def call(env)
      if iphone_web_app?(env)
        if new_session?(env)
          [200,{'Content-Length' => code(true).length.to_s, 'Content-Type' => 'text/html'}, code(true)]
        else
          status, headers, body = @app.call(env)
          # Put in patch code
          ## 
          ##
        
          request = Rack::Request.new(env) 
          response = Rack::Response.new([], status, headers)
          cookie = String.new
          request.cookies.each_pair do |key,value|
	            cookie += "#{key}=#{value};"
          end
          body.each do |part|
            part.gsub!(/<\/head>/, "#{set_cookie(cookie)}</head>")
            response.write(part)
          end
          response.finish
        end
      else
        @app.call(env)
      end
    end

  protected
  
    def code(resend=false)
      regex = "_session_id"
      regex = Rails.configuration.session_options[:key] if Rails.configuration.session_store.name == "ActionDispatch::Session::CookieStore"
      CODE.gsub('{{RESEND}}', resend.to_s).gsub('{{REGEX}}',regex.to_s)
    end
  
   def set_cookie(cookie)
      COOKIE.gsub('{{COOKIE}}',cookie.to_s)
   end

    def new_session?(env)
      request = Rack::Request.new(env)
      if request.cookies['_cookieset_'].nil? 
        true
      else
        false
      end
    end
  
    def iphone_web_app?(env)
      if env['HTTP_USER_AGENT']
        env['HTTP_USER_AGENT'] =~ /WebKit.*Mobile/ && !(env['HTTP_USER_AGENT'] =~ /Safari/)
      end
    end
  end
end
