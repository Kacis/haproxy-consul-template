FROM container4armhf/armhf-alpine:3.4

ENV CONSUL_TEMPLATE_VERSION=0.16.0

# Update wget to get support for SSL
RUN apk --update add haproxy jq wget unzip

# Download consul-template
RUN ( wget --no-check-certificate https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_arm.zip -O /tmp/consul_template.zip && unzip /tmp/consul_template.zip -d /tmp/consul_template && cd /tmp/consul_template/ && mv consul-template /usr/bin && rm -rf /tmp/* )

COPY files/haproxy.json /tmp/haproxy.json
COPY files/haproxy.ctmpl /tmp/haproxy.ctmpl
COPY files/bin /tmp/bin
env PATH $PATH:/tmp/bin

CMD ["consul-template", "-config=/tmp/haproxy.json"]