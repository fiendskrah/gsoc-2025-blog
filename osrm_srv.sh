docker run -t -v "${PWD}:/data" ghcr.io/project-osrm/osrm-backend osrm-extract -p /opt/car.lua data/ireland-and-northern-ireland-latest.osm.pbf || echo "osrm build failed"
docker run -t -v "${PWD}:/data" ghcr.io/project-osrm/osrm-backend osrm-partition data/ireland-and-northern-ireland-latest.osrm || echo "osrm-partition failed"
docker run -t -v "${PWD}:/data" ghcr.io/project-osrm/osrm-backend osrm-customize  data/ireland-and-northern-ireland-latest.osrm || echo "osrm-customize failed"
echo "osrm server can now be started"
