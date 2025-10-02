{ pkgs }:

let
  greet = pkgs.writeScriptBin "greet" ''
    #!${pkgs.bash}/bin/bash
    ${pkgs.figlet}/bin/figlet SuprLab -f rectangles
  '';
in
{
  buildInputs = [
    pkgs.figlet
    pkgs.fish
    (pkgs.python311.withPackages (ps: [
        ps.pip
        ps.requests
    ]))
    greet
  ];

  shellHook = ''
    export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
    exec fish -C "
    function fish_greeting
        greet
    end
    
    function fish_prompt
      echo -e '\n\033[1;36mSL\033[0m \033[1;34m'(pwd)'\033[0m\n\$ '
    end"
  '';
}

