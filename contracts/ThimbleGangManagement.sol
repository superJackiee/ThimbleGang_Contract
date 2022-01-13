// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ITGTToken.sol";

contract ThimbleGangManagement is Ownable {
    mapping(address => uint16) balanceOf;
    mapping(uint256 => address) tokenToOwner;

    uint256 tokenPrice = 0.05 ether;
    uint256 totalAmountToken;

    ITGTToken private tokenTGT;

    constructor(ITGTToken _tokenTGT) {
        tokenTGT = _tokenTGT;
    }

    function createTGT(
        string memory _ipfsUrl,
        uint256 _charvision,
        uint256 _score,
        uint256 _rarityIndex,
        string memory _gender
    ) public onlyOwner {
        tokenTGT.mint(
            address(this),
            _ipfsUrl,
            _charvision,
            _score,
            _rarityIndex,
            _gender
        );
    }

    function buyTGT(uint256 _tokenId, address _buyer) public payable {
        require(msg.value == tokenPrice, "Token Value should be 0.05 ETH!");
        require(
            tokenToOwner[_tokenId] == address(this),
            "This token was sold already!"
        );
        require(
            balanceOf[_buyer] <= 10,
            "Your token range is fully charged already!"
        );

        tokenTGT.transfer(address(this), _buyer, _tokenId);
        tokenToOwner[_tokenId] = _buyer;
        balanceOf[_buyer]++;
    }
}
