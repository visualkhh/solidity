pragma solidity >=0.4.24 <=0.5.6;

contract NFTSimple {
    string public name = 'KlayLion';
    string public symbol = 'KL';
    mapping(uint256 => address) public tokenOwner;
    mapping(uint256 => string) public tokenURIs;
    // 소유한 토큰 리스트
    mapping(uint256 => uint256[]) private _ownedTokens;
    // KIP17Received bytes value
    bytes4 private constant _KIP17_RECEIVED = 0x6745782b;


    function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public returns (bool) {
        // to에게 tokenID(일련번호)를 발행하겠다.
        tokenOwner[tokenId] = to;
        // msg.sender <--이렇게해도됨
        tokenURIs[tokenId] = tokenURI;

        // add token to the list
        _ownedTokens[to].push(tokenId);
        return true;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        require(from == msg.sender, 'from != msg.sender');
        require(from == tokenOwner[tokenId], 'you are not the owner of th token');

        _removeTokenFromList(from, tokenId);
        _ownedTokens[to].push(tokenId);
        tokenOwner[tokenId] = to;

        // 만약에 받는쪽에 실행할 코드가 있으면 스마트 컨트랙트이면 코드 실행하자
        require(_checkOnKIP17Received(from, to, tokenId, _data), 'KIP17: transfer to non KIP17Receiver implementer');
    }

    function _checkOnKIP17Received(address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
        bool success;
        bytes memory returndata;
        if (!isContract(to)) {
            return true;
        }
        // 컨트렉트 이면은 받는 사람 주소가서 실행을 하세요
        // _KIP17_RECEIVED 리턴값을 하는 함수를 찾아서
        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _KIP17_RECEIVED,
                msg.sender,
                from,
                tokenId,
                _data
            )
        );
        if (returndata.length != 0 && abi.decode(returndata, (bytes4)) == _KIP17_RECEIVED) {
            return true;
        } else {
            return false;
        }
    }

    // 컨트렉트 사이즈가 있는지 판단.
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {size := extcodesize(account)}
        return size > 0;
    }

    function _removeTokenFromList(address from, uint256 tokenId) public {
        // [10, 15, 19, 20] -> 19삭제하고싶으면
        // [10, 15, 20, 19]
        // [10, 15, 20]
        uint256 lastTokenIdex = _ownedTokens[from].length - 1;
        for (uint256 i = 0; i < _ownedTokens[from].length; i++) {
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

contract NFTMarket {
    mapping(uint256 => address) public seller;

    function buyNFT(iint256 tokenId, address NFTAddress) public payable returns (bool) {
        // 구매한 사람한테 0.01 KLAY 전송
        address payable receiver = address(uint160(seller[tokenId]));

        // send 0.01 KLAY ot receiver
        // 10 ** 18 PEB = 1 KLAY
        // 10 ** 16 PEB = 0.01 KLAY
        receiver.transfer(10 ** 16);
        NFTSimple(NFTAddress).safeTransferFrom(address(this), msg.sender, tokenId, '0x00');
        return true;
    }

    function onKIP17Received(address operator, address from, uint256 tokenId, bytes memory data) public returns (bytes4) {
        seller[tokenId] = from;
        return bytes4(keccak256('onKIP17Received(address,address,uint256,bytes)'));
    }
}
