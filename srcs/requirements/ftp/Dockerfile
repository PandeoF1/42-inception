FROM debian:buster

ARG FTP_USR_A
ARG FTP_PWD_A
ENV FTP_USR=$FTP_USR_A
ENV FTP_PWD=$FTP_PWD_A

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

RUN apt update && apt install -y vsftpd

RUN adduser $FTP_USR --disabled-password && echo "$FTP_USR:$FTP_PWD" >> /usr/sbin/chpasswd && echo $FTP_USR >> /etc/vsftpd.userlist

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
