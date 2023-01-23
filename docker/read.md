# 1 - NETWORK ( teste-network )

		docker network create -d bridge teste-network

# 2 - VOLUME
	
		docker volume create production
		docker volume create firebird4
		
		
# 3 - IMAGE

		docker build -t teste-firebird4 ./firebird
		docker build -t teste-production ./production-linux

# 4 - Docker-Compose UP (Iniciar containners)

		docker-compose up -d	

# 5 - Docker-Compose UP Build (Iniciar containners recriando)

		docker-compose up -d --build 

# 6 - Docker-Compose Down (Encerrar containers)

		docker-compose down -t 0


para acesso as pastas onde estão "D:/Projects/Development/Study/delphi/teste/firebird/data" e "D:/Projects/Development/Study/delphi/teste/Production"
devem ser alteradas para a path que você salvou
