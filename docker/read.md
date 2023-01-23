# 1 - NETWORK ( teste-network )
	
	command : 
		docker network create -d bridge teste-network

# 2 - VOLUME
	
	command : 
		docker volume create production
		docker volume create firebird4
		
		
# 3 - IMAGE

	command :
		docker build -t teste-firebird4 ./firebird
		docker build -t teste-production ./production-linux
	
	obs: dockerfile em cada diretório

# 4 - Docker-Compose

	command : (simples)
		docker-compose up -d
	
	command : (reconstruindo containers)
		docker-compose up -d --build 

	command : (remover containers)
		docker-compose down -t 0
