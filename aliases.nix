{
  # bash aliases
  programs.bash = {
    enable = true;
    shellAliases = {

      rebuild = "sudo nixos-rebuild switch";

      # NIX stuff
      nixupdate = "sudo nixos-rebuild switch --upgrade";
      nixconf="sudo nvim /etc/nixos/configuration.nix";
      nixclean="nix-collect-garbage";
      nixbins="ls -l /nix/var/nix/profiles/system/sw/bin";

      # VSCodium
      code="codium";
      
      # basic stuff
      t="top";
      ht="htop --sort PERCENT_CPU";
      x="exit";
      c="clear";
      dc="cd";
      
      # ls
      l="ls --color=auto";
      ld="ls -dtr */";
      ls="ls --color=auto --group-directories-first";
      ll="ls -lh --color=auto";
      la="ls -A --color=auto";
      lrt="ls -lhrt --color=auto";
      lrs="ls -lhrs --color=auto";
      rt="ls -lhrt --color=auto";
      rs="ls -lhrs --color=auto";
      lrtr="ls -lht --color=auto";
      lrsr="ls -lhs -color=auto";
      
      wifioff="nmcli radio wifi off";
      wifion="nmcli radio wifi on";
      
      # go somewhere
      ".."="cd ..";
      "..."="cd ../..";
      "...."="cd ../../..";
      "cd.."="cd ..";
      "cd..."="cd ../..";
      "cd...."="cd ../../..";
      d="cd ~/Desktop";
      dn="cd ~/Downloads";
      
      # sleep and shutdown
      sleep="systemctl suspend";
      shutdown="echo SHUTDOWN;sudo shutdown now";

      getpid="xprop _NET_WM_PID | cut -d' ' -f3";
      vkill="xprop _NET_WM_PID | cut -d' ' -f3 | xargs -I % kill -SEGV %";
      
      # view images
      i="ls *.jpg *.JPG *.PNG *.png *.jpeg *.JPEG *.tif *.TIF *.tiff *.TIFF 2> /dev/null | xargs -I % feh %";
      # text editors
      v="xset r rate 300 50 && nvim";
      
      # GIT
      gs="git status";
      gc="git commit -m";
      gp="git push";
      ga="git add";
      
      # others
      p="python3";

    };
  };
}
