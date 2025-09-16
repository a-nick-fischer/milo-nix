{ ... }: {
    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            # We actually need root login for remote deployments
            AllowUsers = [ "nick" "root" ];
        };
    };

    services.radicale = {
        enable = true;
        settings = {
            auth.type = "none"; # Temporary, we switch to LDAP later
            server.hosts = [ "0.0.0.0:5232" ];
        };
    };

    services.immich = {
        enable = true;
        port = 2283;
        accelerationDevices = null;
    };
}