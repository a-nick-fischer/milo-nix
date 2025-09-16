{ ... }: {
    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            AllowUsers = [ "nick" ];
            PermitRootLogin = "no";
        };
    };
}