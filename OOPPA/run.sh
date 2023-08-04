docker network create deep_brain
cd web
docker-compose -p brain_web down
docker-compose -p brain_web up -d
cd ..
cd api
docker-compose -p brain_api down
docker-compose -p brain_api up -d
cd ..
