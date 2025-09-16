{ ... }: {
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 443 80 ];
    };

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            # We actually need root login for remote deployments
            AllowUsers = [ "nick" "root" ];
        };
    };

    services.caddy = {
        enable = true;
        virtualHosts = {
            "home.nifi.blog".extraConfig = ''
                tls internal
                
                handle /cal* {
                    reverse_proxy localhost:5232
                }
                
                handle /photos* {
                    reverse_proxy localhost:2283
                }
                
                handle {
                    respond "Welcome to home.nifi.blog" 200
                }
            '';
        };
    };

    services.radicale = {
        enable = true;
        settings = {
            auth.type = "none"; # Temporary, we switch to LDAP later
            server.hosts = [ "localhost:5232" ];
        };
    };

    services.immich = {
        enable = true;
        port = 2283;
        accelerationDevices = null;
        openFirewall = true;
        mediaLocation = "/volumes/immich";
    };
}