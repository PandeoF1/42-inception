FROM debian:buster

ARG FTP_USR_A
ARG FTP_PWD_A
ENV FTP_USR=$FTP_USR_A
ENV FTP_PWD=$FTP_PWD_A

RUN apt update && apt install -y vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./conf/vsftpd.conf /etc/vsftpd.conf

RUN adduser ${FTP_USR} --disabled-password
RUN echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd
RUN echo ${FTP_USR} >>  /etc/vsftpd.userlist
RUN mkdir -p /var/www
RUN chown -R $FTP_USR:$FTP_USR /var/www/
RUN mkdir -p /var/run/vsftpd/empty && chmod 555 -R /var/run/vsftpd/empty

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
