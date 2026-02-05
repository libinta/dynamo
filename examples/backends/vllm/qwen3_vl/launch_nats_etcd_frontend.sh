nats-server -js &

export LIP=$(hostname -I | awk '{ print $1 }')
etcd --listen-client-urls http://0.0.0.0:2379 --advertise-client-urls http://${LIP}:2379 --data-dir /tmp/etcd &

#python -m dynamo.frontend --http-port=8003 &
