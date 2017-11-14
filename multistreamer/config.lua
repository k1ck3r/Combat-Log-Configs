local config = require('lapis.config').config

config({'production'}, {
  -- name of the cookie used to store session data
  session_name = 'multistreamer',

  -- key for encrypting session data
  secret = 'fzvMxMrTMqwEP6A7M4ZkDeiUX8u5Rg',

  -- whether to log queries and requests
  logging = {
      queries = true,
      requests = true
  },

  -- if deploying somewhere other than the root of a domain,
  -- set this to your prefix (ie, '/multistreamer')
  http_prefix = '',

  -- set an rtmp prefix
  -- note: this can only be a single string,
  -- no slashes etc
  -- defaults to 'multistreamer' if unset
  rtmp_prefix = 'live',

  -- path to your nginx+lua+rtmp binary
  nginx = '/opt/openresty-rtmp/bin/openresty',

  -- path to psql
  psql = '/usr/bin/psql',

  -- path to ffmpeg
  ffmpeg = '/usr/bin/ffmpeg',

  -- set your logging level
  log_level = 'error',

  -- setup your external urls (without prefixes)
  public_http_url = 'https://app.combatlog.eu',
  public_rtmp_url = 'rtmp://app.combatlog.eu:1935',

  -- setup your private (loopback) urls (without prefixes)
  private_http_url = 'http://127.0.0.1:8081',
  private_rtmp_url = 'rtmp://127.0.0.1:1935',

  -- setup your public IRC hostname, for the web
  -- interface
  public_irc_hostname = 'app.combatlog.eu',
  -- setup your public IRC port, to report in the
  -- web interface
  public_irc_port = '6697',
  -- set to true if you've setup an SSL terminator in front
  -- of multistreamer
  public_irc_ssl = true,

  -- configure streaming networks/services
  -- you'll need to register a new app with each
  -- service and insert keys/ids in here

  -- 'rtmp' just stores RTMP urls and has no config,
  networks = {
    -- mixer = {
    --   client_id = 'client_id',
    --   client_secret = 'client_secret',
    --   ingest_server = 'rtmp://somewhere',
    -- },
    -- twitch = {
    --   client_id = 'client_id',
    --   client_secret = 'client_secret',
    --   ingest_server = 'rtmp://somewhere', -- see https://bashtech.net/twitch/ingest.php
                                             -- for a list of endpoints
    -- },
    -- facebook = {
    --   app_id = 'app_id',
    --   app_secret = 'app_secret',
    -- },
    -- youtube = {
    --   client_id = 'client_id',
    --   client_secret = 'client_secret',
    --   country = 'us', -- 2-character country code, used for listing available categories
    -- },

    
    
    
    
    
    
    
    
     twitch = {
	    client_id = 'ooa4t9808i72fvcs65jkt4i4nk8gi9',
	    client_secret = 'jedlf6tfpg0q67sxsu6frkhmzczxia',
	    ingest_server = 'rtmp://live-ams.twitch.tv/app', -- see https://bashtech.net/twitch/ingest.php
       },
          facebook = {
	    app_id = '899844616837620',
	    app_secret = '71ade3ebdef1fc42bd36674c3cbd3bec',
       },
          youtube = {
            client_id = '712306600392-1vv0mr5pgi4s3kjmcuomielbpie0i0mh.apps.googleusercontent.com',
	    client_secret = 'b8IEttM0XX_DvMdbiUfPoWS8',
	    country = 'us',
       },
       rtmp = true,
  },

  -- postgres connection settings
  postgres = {
    host = '127.0.0.1',
    user = 'combatlog',
    password = 'x4x0b3x0',
    database = 'combatlog'
  },

  -- nginx http "listen" directive, see
  -- http://nginx.org/en/docs/http/ngx_http_core_module.html#listen
  http_listen = '127.0.0.1:8081',

  -- nginx rtmp "listen" directive, see
  -- https://github.com/arut/nginx-rtmp-module/wiki/Directives#listen
  -- default: listen on all ipv6+ipv4 addresses
--  rtmp_listen = '[::]:1935 ipv6only=off',
  rtmp_listen = '1935',
  -- nginx irc "listen" directive, see
  -- https://nginx.org/en/docs/stream/ngx_stream_core_module.html#listen
  -- default: listen on all ipv6+ipv4 addresses
  irc_listen = '127.0.0.1:6667',

  -- set the IRC hostname reported by the server
  irc_hostname = 'app.combatlog.eu',

  -- should users be automatically brought into chat rooms when
  -- their streams go live? (default false)
  -- this is handy for clients like Adium, Pidgin, etc that don't
  -- have a great IRC interface
  irc_force_join = true,

  -- number of worker processes
  worker_processes = 1,

  -- http auth endpoint
  -- multistreamer will make an HTTP request with the 'Authorization'
  -- header to this URL when a user logs in
  -- see http://nginx.org/en/docs/http/ngx_http_auth_request_module.html
  -- see https://github.com/jprjr/ldap-auth-server for an LDAP implementation
  auth_endpoint = 'http://127.0.0.1:8080/users/auth',

  -- redis host
  redis_host = '127.0.0.1:6379',

  -- prefix for redis keys
  redis_prefix = 'multistreamer/',

  -- path to trusted ssl certificate store
  ssl_trusted_certificate = '/etc/ssl/certs/ca-certificates.crt',

  -- dns resolver
  dns_resolver = '8.8.8.8 ipv6=off',

  -- maximum ssl verify depth
  ssl_verify_depth = 5,

  -- sizes for shared dictionaries (see https://github.com/openresty/lua-nginx-module#lua_shared_dict)
  lua_shared_dict_streams_size = '10m',
  lua_shared_dict_writers_size = '10m',

  -- specify the run directory to hold temp files etc,
  -- defaults to /root/.multistreamer if not set
  -- work_dir = '/path/to/some/folder',

  -- set the path to sockexec's socket
  -- see https://github.com/jprjr/sockexec for installation details
  sockexec_path = '/tmp/exec.sock',

  -- allow/disallow transcoding (default: true)
  allow_transcoding = true,

  -- allow/disallow creating pullers (default: true)
  allow_custom_puller = true,
})
