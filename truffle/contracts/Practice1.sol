pragma solidity 0.8.15;

contract Practice1 {
    uint256 private totalSupply = 10;
    string public name = 'wow';
    address public owner;
    mapping(uint256 => string) public tokenURIs;
    constructor() public {
        owner = msg.sender;
    }


    function getTotalSupply() public view returns (uint256) {
        return totalSupply + 100000;
    }

    function setTotalSupply(uint256 newSupply) public {
        require(owner == msg.sender, 'Not Owner');
        totalSupply = newSupply;
    }

    function setTokenUri(uint256 id, string memory uri) public {
        tokenURIs[id] = uri;
    }
}
