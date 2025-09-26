{
  description = "A new Flutter project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = ["x86_64-linux"]; # You can add other systems if you need them

      perSystem = { system, ... }:
        let

           pkgs = import inputs.nixpkgs {
           inherit system;
           config.allowUnfree = true;
        };
        in
        {
  formatter = pkgs.alejandra;
  packages.default = pkgs.hello;

  devShells.default = pkgs.mkShell {
    packages = [
      pkgs.flutter
      pkgs.jdk17
      pkgs.chromium
      pkgs.killall
    ];

    shellHook = ''
      trap "pkill -f 'org.gradle.launcher.daemon.bootstrap.GradleDaemon' || true" EXIT
    '';

    ANDROID_SDK_ROOT = "/home/amir/FROMOLDPC/Project/AndroidStudioSdk/sdk";
    ANDROID_HOME = "/home/amir/FROMOLDPC/Project/AndroidStudioSdk/sdk";

    CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
  };
};

      # Keep your original templates
      flake = {
        templates = rec {
          flutter = {
            path = ./.;
            description = "A simple flutter template to sit up flutter androidSDK + chrome";
            welcomeText = ''
              # Welcome to nixos Flutter Template
              yipeeeeeee!!!!
            '';
          };
          default = flutter;
        };
      };
    };
}
