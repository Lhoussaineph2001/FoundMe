-include .env
 
build: ; forage build  

deploy-sepolia :
	  
	   forage scripte scripte/Deploy_FoundMe.s.sol:Deploy_FoundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY)
		--broadcast --verify --etherscan-api-key $(ETNERSCAN_API_KEY) --vvvv

format: ; forge fmt 

test: ; forge test

One_test: ;  forge test --mt  

snapshot: ; forge snapshot

coverage: ; forge coverage







