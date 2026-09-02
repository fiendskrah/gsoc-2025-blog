#!/usr/bin/env bash
# Prepares a local OSRM routing backend for spopt.route's OSRM engine
# (see gsoc-2025-blog/_posts/2025-06-17-vrpworking.md and
# 2025-08-18-fallback.md for the surrounding narrative).
#
# This is step 2 of a 2-step workflow:
#
#   1. Download the raw OSM extract for the region you want to route
#      within, and put it under data/. This one's region is
#      Ireland + Northern Ireland, downloaded from Geofabrik:
#      https://download.geofabrik.de/europe/ireland-and-northern-ireland.html
#      (data/ireland-and-northern-ireland-latest.osm.pbf here, and
#      gitignored since it's ~360MB — re-download rather than expecting
#      it to already be present).
#
#   2. Run this script to preprocess that raw extract into the
#      routable graph format OSRM actually serves from. This is the
#      standard OSRM Multi-Level Dijkstra (MLD) pipeline, run via the
#      official Docker image so there's no local OSRM install needed:
#        - osrm-extract:   parses the .osm.pbf against a routing
#                           profile (car.lua = drive-time routing) and
#                           builds the initial .osrm graph files.
#        - osrm-partition: partitions that graph into cells for MLD.
#        - osrm-customize: bakes per-partition edge weights into the
#                           graph so queries don't recompute them.
#
# Once this script finishes, the data/ireland-and-northern-ireland-latest.osrm*
# files are ready to serve. Start the actual server separately, e.g.:
#   docker run -t -i -p 5000:5000 -v "${PWD}:/data" \
#     ghcr.io/project-osrm/osrm-backend osrm-routed --algorithm mld \
#     data/ireland-and-northern-ireland-latest.osrm

docker run -t -v "${PWD}:/data" ghcr.io/project-osrm/osrm-backend osrm-extract -p /opt/car.lua data/ireland-and-northern-ireland-latest.osm.pbf || echo "osrm build failed"
docker run -t -v "${PWD}:/data" ghcr.io/project-osrm/osrm-backend osrm-partition data/ireland-and-northern-ireland-latest.osrm || echo "osrm-partition failed"
docker run -t -v "${PWD}:/data" ghcr.io/project-osrm/osrm-backend osrm-customize  data/ireland-and-northern-ireland-latest.osrm || echo "osrm-customize failed"
echo "osrm server can now be started"
