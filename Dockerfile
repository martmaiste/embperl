FROM centos:7
LABEL description="Apache web-server with mod-perl+Embperl support" \
      maintainer="ull <mart.maiste@gmail.com>"

RUN \
    yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install curl epel-release perl-DBD-MySQL mod_ssl && \ 
    curl mirror.dbweb.ee/pub/centos/7/dbweb.repo -o /etc/yum.repos.d/dbweb.repo && \
    yum -y --setopt=tsflags=nodocs --enablerepo=epel groupinstall WiseCMS && \
    yum clean all && \
    curl mirror.dbweb.ee/pub/conf/etc/httpd/conf.d/x-embperl.conf -o /etc/httpd/conf.d/x-embperl.conf

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
