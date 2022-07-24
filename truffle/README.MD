# link
- https://trufflesuite.com/docs/truffle/getting-started/using-truffle-develop-and-the-console/

# init
truffle init

# compile
truffle compile

# develop
truffle develop
> 1. truffle migrate
> 2. let instance = await HelloWorld.deployed()
> 3. instance.hello();

# migrate
- reset: migrate --reset

# test
triffle test


# 실행
- payable: instance.setMessage("good", {value: 10000});
- payable: instance.setMessage("good", {value: web3.utils.toWei("2", "ether")});



# accounts
truffle(develop)>
> let accounts = await web3.eth.getAccounts()
> change: setMessage("msg", {value: web3.utils.toWei("2", "ether"), from: accounts[2]});



# truffle migration
- https://www.youtube.com/watch?v=TDDuLlOiYJ8&ab_channel=MoralisWeb3
- 