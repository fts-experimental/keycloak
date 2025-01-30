up:
	docker compose -f docker-compose-dev.yml \
	up -d --build

bash:
	docker compose -f docker-compose-dev.yml \
	exec exp-keycloak-app sh

import:
	docker compose -f docker-compose-dev.yml \
	exec exp-keycloak-app /opt/keycloak/bin/kc.sh import \
	--file ./data/import/realm.json

export:
	docker compose -f docker-compose-dev.yml \
	exec exp-keycloak-app /opt/keycloak/bin/kc.sh export \
	--file ./realm.json \
	--realm fts-experimental \
	--users same_file

cp:
	docker cp exp-keycloak-app:/opt/keycloak/realm.json config/realm.json

log:
	docker logs exp-keycloak-app