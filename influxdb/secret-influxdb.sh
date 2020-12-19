kubectl create secret generic influxdb-creds \
  --from-literal=INFLUXDB_DATABASE=navigation \
  --from-literal=INFLUXDB_USERNAME=root \
  --from-literal=INFLUXDB_PASSWORD=root \
  --from-literal=INFLUXDB_HOST=influxdb \
  -n navigation