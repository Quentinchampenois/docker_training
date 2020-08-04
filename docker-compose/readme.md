# Exercices

## Redis

Create a simple docker-compose file that start a small redis.
Remember: 

Video: https://rendezvous.alpha.liiib.re/playback/presentation/2.0/playback.html?meetingId=f621b5239d221e578332c34d904600664135d6cb-1595490782964

time: 23:50

## Network

Create an isolated network, called backed,  and put the redis in it.
Create another isolated network called web.

## Postgres

Add a small postgres container to the network.

## Discourse

Add our disourse service to the web and backend network.
Use the build key to define this service.

## Make sure it works

Exec into the discourse container with the discourse user and make sure you can compile assets.

## volumes and ports

Add volumes to persist the db and the assets, and expose discourse to the port 80 of your host.
