FROM archlinux:latest

RUN pacman -Syyu && pacman -S --noconfirm ponysay

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology"]