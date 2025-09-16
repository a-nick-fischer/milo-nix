{ ... }: {
    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            AllowUsers = [ "nick" ];
            PermitRootLogin = "no";
        };
    };

    services.radicale = {
        enable = true;
        settings.server.hosts = [ "0.0.0.0:5232" ];
    };

    services.immich = {
        enable = true;
        port = 2283;
        accelerationDevices = null;
    };

    users.users.immich.extraGroups = [ "video" "render" ];
}