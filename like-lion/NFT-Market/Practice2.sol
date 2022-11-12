pragma solidity >=0.4.24 <=0.5.6;

contract Practice2 {
    string public name = 'KlayLion';
    string public symbol = 'KL';
    mapping(uint256 => address) public tokenOwner;
    mapping(uint256 => string) public tokenURIs;
    // 소유한 토큰 리스트
    mapping(uint256 => uint256[]) private _ownedTokens;


    function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public returns (bool) {
        // to에게 tokenID(일련번호)를 발행하겠다.
        tokenOwner[tokenId] = to; // msg.sender <--이렇게해도됨
        tokenURIs[tokenId] = tokenURI;

        // add token to the list
        _ownedTokens[to].push(tokenId);
        return true;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        require(from == msg.sender, 'from != msg.sender');
        require(from == tokenOwner[tokenId], 'you are not the owner of th token');

        _removeTokenFromList(from, tokenId);
        _ownedTokens[to].push(tokenId);
        tokenOwner[tokenId] = to;
    }

    function _removeTokenFromList(address from, uint256 tokenId) public {
        // [10, 15, 19, 20] -> 19삭제하고싶으면
        // [10, 15, 20, 19]
        // [10, 15, 20]
        uint256 lastTokenIdex = _ownedTokens[from].length - 1;
        for(uint256 i = 0; i < _ownedTokens[from].length ; i++) {
            if (tokenId == _ownedTokens[from][lastTokenIdex]) {
                // swap
                _ownedTokens[from][i] = _ownedTokens[from][lastTokenIdex];
                _ownedTokens[from][lastTokenIdex] = tokenId;
                break;
            }
        }
        _ownedTokens[from].length--;
    }

    function ownedTokens(address owner) public view returns (uint256[] memory) {
        return _ownedTokens[from];
    }
}
