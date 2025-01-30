FROM quay.io/keycloak/keycloak:26.0

USER root

RUN mkdir -p /exports

USER 1000

EXPOSE 8080