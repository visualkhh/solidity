// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintNFT is ERC721Enumerable {
    mapping(uint => string) public metadataURIs;
    constructor() ERC721("h662Proejct", "662") {}

    function mintNFT() public {
        uint tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);
    }
    function setTokenURI(uint _tokenId, string memory _metadataURI) public {
        metadataURIs[_tokenId] = _metadataURI;
    }
    function tokenURI(uint _tokenId) public override view returns(string memory) {
        return metadataURIs[_tokenId];
    }
}