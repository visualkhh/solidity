const Helloworld = artifacts.require("Helloworld");
contract("Helloworld", account => {
    it('test', async () => {
        let instance = await Helloworld.deployed();
        let msg = instance.message();
        assert.equal(msg, "HELLO");
    })
})