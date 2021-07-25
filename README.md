# Resume
This repo should now build with live-reloading on linux, mac, and windows.

### ACKNOWLEDGMENT
This resume is a heavily modified version of AltaCV by LianTze Lim (liantze@gmail.com)
https://github.com/liantze/AltaCV

## Linux Setup
- `sudo apt install biber`
- `sudo apt install texlive-latex-base`
- `sudo apt-get install texlive-full`
- `sudo apt install -y inotify-tools` to get monitor script working
- `sudo chmod +x livereload.sh` to get the ease of use script

## Mac Setup:
- [Install Instructions](https://sourabhbajaj.com/mac-setup/LaTeX/)
- Once you have the prereqs installed, you can use the same make file as the linux install.

## Windows Setup:
Start by installing these chocolatey packages
- `choco install texlive`
- `choco install miktex`
- You should now have access to the `pdflatex` command. (you may have to restart your terminal session)
- Run `./winmake.ps1` from a powershell terminal to hot-reload build the pdf.

## Makefile (Linux and mac only)
- run `make` to build resume
- run `make get-dep` to install dependencies
- run `make live` to run live reload script
- run `make clean` to remove all log files

## Context/How-to
- The resume.tex file contains content for your header as well as your main bar on the left
- The sidebar.tex file contains content that appears in the right sidebar
- You can change the margins (I have obnoxiously large ones) in the 5th line of resume.tex
- custom functions are defined in the altacv.cls file
