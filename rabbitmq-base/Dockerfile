FROM rabbitmq:3.7.4-management

COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY ./cluster-entrypoint.sh /usr/local/bin/

#RUN chmod +x /usr/local/bin/cluster-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/cluster-entrypoint.sh"]