FROM alpine:3.18.4
MAINTAINER Mac Liu <linuzilla@gmail.com>

RUN apk update && apk upgrade && \
	apk add git gcc make musl-dev tmux openssh tzdata && \
	rm -fr /var/cache/apk/*

RUN cd /tmp; git clone https://github.com/Wind4/vlmcsd.git; cd vlmcsd; make; cp bin/vlmcsd bin/vlmcs /usr/local/bin; cd /tmp; rm -fr vlmcsd; apk del git gcc make musl-dev

COPY files/init.sh /
COPY files/sshd_config /etc/ssh

RUN chmod 755 /init.sh

VOLUME [ "/workspace" ]

ENV TZ Asia/Taipei

EXPOSE 1688
EXPOSE 22

CMD [ "/init.sh" ]
