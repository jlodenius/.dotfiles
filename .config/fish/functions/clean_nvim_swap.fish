function clean_nvim_swap --description 'Clean Neovim swap files'
  set -l swap_dir ~/.local/share/nvim/swap

  if test -d $swap_dir
    set -l files $swap_dir/*
    if test (count $files) -gt 0
      set -l count (count $files)
      rm -f $files
      echo "Cleaned $count swap files from Neovim swap directory"
    else
      echo "No swap files to clean in $swap_dir"
    end
  else
    echo "Neovim swap directory not found at $swap_dir"
  end
end
